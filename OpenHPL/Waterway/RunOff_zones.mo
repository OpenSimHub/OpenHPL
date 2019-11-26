within OpenHPL.Waterway;
model RunOff_zones "Run off model. (with 10 height zones)"
  extends OpenHPL.Icons.RunOff;
  //// height zone segmentation
  parameter Integer N = 10 "# of height zones" annotation (
    Dialog(group = "Geometry"));
  //// parameters of the hydrology model
  parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T_t = -3.91223331e-01 "Threshold temperature" annotation (
    Dialog(group = "Physically-based parameters"));
  parameter Modelica.SIunits.Area A[N] = ones(N) * 41.3e6 "Catchment area" annotation (
    Dialog(group = "Geometry"));
  parameter Real s_T = 3.99187122e-02 "Soil zone saturation threshold, m" annotation (
    Dialog(group = "Empirical parameters")), a_1 = 2.31870660e-06 "Discharge frequency for surface runoff, 1/sec" annotation (
    Dialog(group = "Empirical parameters")), a_2 = 4.62497942e-06 "Discharge frequency for fast runoff, 1/sec" annotation (
    Dialog(group = "Empirical parameters")), a_3 = 1.15749393e-06 "Discharge frequency for base runoff, 1/sec" annotation (
    Dialog(group = "Empirical parameters")), a_L[N] = {15.43, 3.97, 1.79, 0.81, 1.27, 1.44, 1.03, 2.32, 1.31, 0.57} .* 1e6 ./ A "Fractional area covered by lakes, -" annotation (
    Dialog(group = "Geometry")), g_T = 1.50394570e-01 "Ground saturation threshold, m" annotation (
    Dialog(group = "Physically-based parameters")), PERC = 5.79256691e-09 "preccolation from soil zone to base zone, m/sec" annotation (
    Dialog(group = "Empirical parameters")), beta = 1.00291469e+00 "Ground zone shape coefficient, -" annotation (
    Dialog(group = "Empirical parameters")), k_m = 3.47554015e-08 "Melting factor, m/deg/sec" annotation (
    Dialog(group = "Physically-based parameters")), PCORR = 1.05 "Precipitation correction - Rainfall, -" annotation (
    Dialog(group = "Empirical parameters")), SCORR = 1.2 "Precipitation correction - Snowfall, -" annotation (
    Dialog(group = "Empirical parameters")), CE = 0.04 "Model parameter for adjusted evapotranspiration, 1/deg" annotation (
    Dialog(group = "Empirical parameters"));
  //a_w = 0.03 "Saturation coeficieant, -" annotation (Dialog(group="Empirical parameters")),
  //a = 0.001 "Snow surface fraction, -" annotation (Dialog(group="Empirical parameters")),
  //// parameters for outsource files with data
  parameter String fileName_temp = Modelica.Utilities.Files.loadResource("modelica://OpenHPL/Resources/Tables/Temp_var.txt") "File with temperature variations in different height zones" annotation (
    Dialog(tab = "Temperature")), fileName_prec = Modelica.Utilities.Files.loadResource("modelica://OpenHPL/Resources/Tables/Prec_var.txt") "File with precipitation variations in different height zones" annotation (
    Dialog(tab = "Precipitation")), fileName_evap = Modelica.Utilities.Files.loadResource("modelica://OpenHPL/Resources/Tables/Evap_var.txt") "File with evapotranspiration variations during the year" annotation (
    Dialog(tab = "Evapotranspiration")), fileName_month_temp = Modelica.Utilities.Files.loadResource("modelica://OpenHPL/Resources/Tables/Month_av_temp.txt") "File with monthly average temperature for evapotranspiration calculation" annotation (
    Dialog(tab = "Evapotranspiration")), fileName_flow = Modelica.Utilities.Files.loadResource("modelica://OpenHPL/Resources/Tables/Flow_var_d.txt") "File with real observed run off" annotation (
    Dialog(tab = "Real run off"));
  parameter String tableName_temp = "zones_temp" "Table with temperature variations in different height zones" annotation (
    Dialog(tab = "Temperature")), tableName_prec = "zones_prec" "Table with precipitation variations in different height zones" annotation (
    Dialog(tab = "Precipitation")), tableName_evap = "evap" "Table with evapotranspiration variations during the year" annotation (
    Dialog(tab = "Evapotranspiration")), tableName_month_temp = "month_temp" "Table with monthly average temperature" annotation (
    Dialog(tab = "Evapotranspiration")), tableName_flow = "flow" "Table with real observed run off" annotation (
    Dialog(tab = "Real run off"));
  parameter Integer columns_temp[:] = 2:N + 1 "Columns with temperature variations for different height zones" annotation (
    Dialog(tab = "Temperature")), columns_prec[:] = 2:N + 1 "Columns with precipitation variations for different height zones" annotation (
    Dialog(tab = "Precipitation")), columns_evap[:] = {2} "Column with evapotranspiration variations during the year" annotation (
    Dialog(tab = "Evapotranspiration")), columns_month_temp[:] = 2:N + 1 "Columns with monthly average temperature variations for different height zones" annotation (
    Dialog(tab = "Evapotranspiration")), columns_flow[:] = {2} "Column with real observed run off" annotation (
    Dialog(tab = "Real run off"));
  //// variables
  Modelica.SIunits.Height V_s_w[N] "Water content in soil zone", V_b_w[N] "Water content in base zone", V_g_w[N] "Water content in ground zone", V_s_d[N] "Dry snow";
  //V_s_s[N] "Soggy snow";
  Modelica.SIunits.VolumeFlowRate V_doT_tot "Total runoff";
  Modelica.SIunits.Velocity V_dot_s2b[N] "Runoff rate from soil zone to base zone", V_dot_pl[N] "Precipitation in lake", V_dot_b2br[N] "Runoff rate from base zone t obase runoff", V_dot_l_e[N] "Rate of evapotranspiration from lake", V_dot_g2s[N] "Runoff rate from ground zone to soil zone", V_dot_s2sr[N] "Runoff rate from soil zone to surface runoff", V_dot_s2fr[N] "Runoff rate from soil zone to fast runoff", V_dot_s2g[N] "Runoff rate from snow zone to ground zone", V_dot_g_e[N] "Evapotranspiration rate from ground zone", V_dot_p_r[N] "Precipitation in mainland in the form of snow", V_dot_d2w[N] "Melting rate from dry snow form to water snow form", V_dot_p_s[N] "Precipitation in mainland in the form of snow", V_dot_epot[N] "Evapotranspiration";
  //V_dot_w2d[N] "Freezing rate from water snow form to dry snow form";
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T[N] "Ambient temperature";
  Modelica.SIunits.Velocity V_dot_p[N] "Precipitation";
  Real a_e[N], a_sw[N], F_o, F_e, R2, err = 0.5e-3 "Smal error, m";
  //// using  data
  Modelica.Blocks.Sources.CombiTimeTable temp_var(tableOnFile = true, columns = columns_temp, tableName = tableName_temp, fileName = fileName_temp);
  Modelica.Blocks.Sources.CombiTimeTable prec_var(tableOnFile = true, fileName = fileName_prec, columns = columns_prec, tableName = tableName_prec);
  Modelica.Blocks.Sources.CombiTimeTable evap_var(tableOnFile = true, fileName = fileName_evap, columns = columns_evap, tableName = tableName_evap);
  Modelica.Blocks.Sources.CombiTimeTable month_temp(tableOnFile = true, fileName = fileName_month_temp, columns = columns_month_temp, tableName = tableName_month_temp);
  Modelica.Blocks.Sources.CombiTimeTable flow_var(tableOnFile = true, fileName = fileName_flow, columns = columns_flow, tableName = tableName_flow);
  //// connector
  Modelica.Blocks.Interfaces.RealOutput V_dot_runoff annotation (
    Placement(transformation(extent = {{90, -10}, {110, 10}}), iconTransformation(extent = {{80, -20}, {120, 20}})));
initial equation
  //V_s_s = zeros(N);
  V_s_d = zeros(N);
  V_g_w = zeros(N);
  V_s_w = zeros(N);
  V_b_w = zeros(N);
equation
  //// Total runoff
  //der(V_doT_tot) = if V_s_w > s_T then (a_1*(V_s_w-s_T)+a_2*V_s_w)*(1-sum(a_L)/N)*sum(A) + sum(A)*a_3*V_b_w else a_2*V_s_w*(1-sum(a_L)/N)*sum(A) + sum(A)*a_3*V_b_w;
  V_doT_tot = sum(A .* (V_dot_b2br + V_dot_s2sr + V_dot_s2fr));
  for i in 1:N loop
    //// Snow zone (Snow rourine)
    T[i] = temp_var.y[i];
    V_dot_p[i] = prec_var.y[i] * 1e-3 / 86400;
    der(V_s_d[i]) = V_dot_p_s[i] - V_dot_d2w[i];
    // + V_dot_w2d[i];
    //der(V_s_s[i]) = V_dot_p_r[i] - V_dot_w2d[i] + V_dot_d2w[i] - V_dot_s2g[i];
    V_dot_p_s[i] = if T[i] <= T_t then V_dot_p[i] * PCORR * SCORR * (1 - a_L[i]) else 0;
    V_dot_p_r[i] = if T[i] > T_t then V_dot_p[i] * PCORR * (1 - a_L[i]) else 0;
    V_dot_d2w[i] = if T[i] > T_t and V_s_d[i] >= err * 1e-2 then k_m * (T[i] - T_t) * (1 - a_L[i]) else 0;
    //V_dot_w2d[i] = if T[i]<=T_t and V_s_s[i]>=0 then k_m*(T_t-T[i]) else 0;
    //V_dot_s2g[i] = if T[i]>T_t and V_s_s[i]<err*1e-5 and V_s_d[i]<err then V_dot_p_r[i] elseif V_s_s[i]>=err and V_s_d[i]>=err then (1+a_w)*V_dot_d2w[i]+V_dot_p_r[i] else 0;
    V_dot_s2g[i] = V_dot_p_r[i] + V_dot_d2w[i];
    //// Ground zone (Soil moisure)
    //der(V_g_w[i]) = V_dot_s2g[i] -V_dot_g2s[i] - (1-a)*V_dot_g_e[i];
    der(V_g_w[i]) = V_dot_s2g[i] - V_dot_g2s[i] - a_e[i] .* V_dot_g_e[i];
    V_dot_g2s[i] = if V_g_w[i] >= 0 and V_g_w[i] < g_T then (V_g_w[i] / g_T) ^ beta * V_dot_s2g[i] else V_dot_s2g[i];
    V_dot_epot[i] = evap_var.y[1] * 1e-3 / 86400 * (1 + CE * (T[i] - month_temp.y[i]));
    V_dot_g_e[i] = if V_g_w[i] < g_T then V_g_w[i] / g_T * V_dot_epot[i] else V_dot_epot[i];
    a_e[i] = if V_s_d[i] < err then 1 else 0;
    //// Soil zone (Upprec zone)
    der(V_s_w[i]) = V_dot_g2s[i] - a_sw[i] * V_dot_s2b[i] - V_dot_s2sr[i] - V_dot_s2fr[i];
    V_dot_s2b[i] = (1 - a_L[i]) * PERC;
    V_dot_s2sr[i] = if V_s_w[i] > s_T then a_1 * (V_s_w[i] - s_T) else 0;
    V_dot_s2fr[i] = a_2 * V_s_w[i];
    a_sw[i] = if V_dot_g2s[i] < V_dot_s2b[i] then 0 else 1;
    //// Basement zone (Lower zone)
    der(V_b_w[i]) = V_dot_s2b[i] + V_dot_pl[i] - V_dot_b2br[i] - V_dot_l_e[i];
    V_dot_pl[i] = a_L[i] * V_dot_p[i];
    V_dot_b2br[i] = a_3 * V_b_w[i];
    V_dot_l_e[i] = a_L[i] * V_dot_epot[i];
  end for;
  //// Error
  F_o = (flow_var.y[1] - 17.230144) ^ 2;
  F_e = (flow_var.y[1] - V_doT_tot) ^ 2;
  R2 = 1 - F_e / F_o;
  V_dot_runoff = V_doT_tot;
  annotation (
    Documentation(info="<html>
<p>
This is the hydrology model that is based on the HBV hydrological model. 
This model can be used to define the inflow (runoff) to the reservoir.</p>
<p>Here, the input data are used for the model and this data is in: 
<a href=\"modelica://OpenHPL/Resources/Tables/\">Resources/Tables/...</a></p>
<p>More info about model can be found in 
<a href=\"modelica://OpenHPL.UsersGuide.References\">[Shafiee2013]</a>.</p>
</html>"));
end RunOff_zones;
