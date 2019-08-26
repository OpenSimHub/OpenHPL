within OpenHPL.Waterway;
model RunOff_SI
  extends Modelica.Icons.UnderConstruction;
  parameter Integer N = 10 "# of height zones";
  parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T_T = 1 "Threshold temperature";
  //, T[N] "Ambient temperature";
  parameter Modelica.SIunits.Area A[N] = ones(N) * 41.3e6 "Catchment area";
  parameter Real s_T = 20e-3 "Soil zone saturation threshold, m", a_1 = 0.547 / 86400 "Discharge frequency for surface runoff, 1/sec", a_2 = 0.489 / 86400 "Discharge frequency for fast runoff, 1/sec", a_3 = 0.0462 / 86400 "Discharge frequency for base runoff, 1/sec", a_L[N] = {15.43, 3.97, 1.79, 0.81, 1.27, 1.44, 1.03, 2.32, 1.31, 0.57} .* 1e6 ./ A "Fractional area covered by lakes, -", g_T = 150e-3 "Ground saturation threshold, m", PERC = 0.6e-3 / 86400 "Percolation from soil zone to base zone, m/sec", beta = 2 "Ground zone shape coefficient, -", k_m = 4e-3 / 86400 "Melting factor, m/deg/sec", a_w = 0.0 "Saturation coeficieant, -", a = 0.001 "Snow surface fraction, -", PCORR = 1.05 "Precipitation correction - Rainfall, -", SCORR = 1.2 "Precipitation correction - Snowfall, -", err = 0.5e-3 "Smal error, m", CE = 0.04 "Model parameter for adjusted evapotranspiration, 1/deg";
  Modelica.SIunits.Volume V_s_w[N] "Water content in soil zone", V_b_w[N] "Water content in base zone", V_g_w[N] "Water content in ground zone", V_s_d[N] "Dry snow";
  //V_s_s[N] "Soggy snow";
  Modelica.SIunits.VolumeFlowRate V_dot_tot "Total runoff", V_dot_s2b[N] "Runoff rate from soil zone to base zone", V_dot_pl[N] "Precipitation in lake", V_dot_b2br[N] "Runoff rate from base zone t obase runoff", V_dot_l_e[N] "Rate of evapotranspiration from lake", V_dot_g2s[N] "Runoff rate from ground zone to soil zone", V_dot_s2sr[N] "Runoff rate from soil zone to surface runoff", V_dot_s2fr[N] "Runoff rate from soil zone to fast runoff", V_dot_s2g[N] "Runoff rate from snow zone to ground zone", V_dot_g_e[N] "Evapotranspiration rate from ground zone", V_dot_p_r[N] "Precipitation in mainland in the form of snow", V_dot_d2w[N] "Melting rate from dry snow form to water snow form", V_dot_p_s[N] "Precipitation in mainland in the form of snow", V_dot_epot[N] "Evapotranspiration";
  //V_dot_w2d[N] "Freezing rate from water snow form to dry snow form";
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T[N] "Ambient temperature";
  Modelica.SIunits.Velocity V_dot_p[N] "Precipitation";
  Real a_e[N], F_o, F_e, R2;
  Modelica.Blocks.Sources.CombiTimeTable temp_var(tableOnFile = true, columns = 2:11, tableName = "zones_temp", fileName = Modelica.Utilities.Files.loadResource("modelica://OpenHPL/Resources/Tables/Temp_var.txt"));
  Modelica.Blocks.Sources.CombiTimeTable prec_var(tableOnFile = true, fileName = Modelica.Utilities.Files.loadResource("modelica://OpenHPL/Resources/Tables/Prec_var.txt"), columns = 2:11, tableName = "zones_prec");
  Modelica.Blocks.Sources.CombiTimeTable evap_var(tableOnFile = true, fileName = Modelica.Utilities.Files.loadResource("modelica://OpenHPL/Resources/Tables/Evap_var.txt"), columns = {2}, tableName = "evap");
  Modelica.Blocks.Sources.CombiTimeTable month_temp(tableOnFile = true, fileName = Modelica.Utilities.Files.loadResource("modelica://OpenHPL/Resources/Tables/Month_av_temp.txt"), columns = 2:11, tableName = "month_temp");
  Modelica.Blocks.Sources.CombiTimeTable flow_var(tableOnFile = true, fileName = Modelica.Utilities.Files.loadResource("modelica://OpenHPL/Resources/Tables/Flow_var_d.txt"), tableName = "flow");
initial equation
  //V_s_s = zeros(N);
  V_s_d = zeros(N);
  V_g_w = zeros(N);
  V_s_w = zeros(N);
  V_b_w = zeros(N);
equation
  ///// Total runoff
  //der(V_dot_tot) = if V_s_w > s_T then (a_1*(V_s_w-s_T)+a_2*V_s_w)*(1-sum(a_L)/N)*sum(A) + sum(A)*a_3*V_b_w else a_2*V_s_w*(1-sum(a_L)/N)*sum(A) + sum(A)*a_3*V_b_w;
  V_dot_tot = sum(V_dot_b2br + V_dot_s2sr + V_dot_s2fr);
  for i in 1:N loop
    ///// Snow zone (Snow rourine)
    T[i] = temp_var.y[i];
    V_dot_p[i] = prec_var.y[i] * 1e-3 / 86400;
    der(V_s_d[i]) = V_dot_p_s[i] - V_dot_d2w[i];
    // + V_dot_w2d[i];
    //der(V_s_s[i]) = V_dot_p_r[i] - V_dot_w2d[i] + V_dot_d2w[i] - V_dot_s2g[i];
    V_dot_p_s[i] = if T[i] <= T_T then V_dot_p[i] * PCORR * SCORR * (1 - a_L[i]) * A[i] else 0;
    V_dot_p_r[i] = if T[i] > T_T then V_dot_p[i] * PCORR * (1 - a_L[i]) * A[i] else 0;
    V_dot_d2w[i] = if T[i] > T_T and V_s_d[i] > 0 then k_m * (T[i] - T_T) * (1 - a_L[i]) * A[i] else 0;
    //V_dot_w2d[i] = if T[i]<=T_T and V_s_s[i]>=0 then k_m*(T_T-T[i])*A[i] else 0;
    //V_dot_s2g[i] = if T[i]>T_T and V_s_s[i]==0 and V_s_d[i]==0 then V_dot_p_r[i] elseif V_s_s[i]<>0 and V_s_d[i]<>0 then (1-a_w)*V_dot_d2w[i]+V_dot_p_r[i] else 0;
    V_dot_s2g[i] = V_dot_p_r[i] + V_dot_d2w[i];
    ///// Ground zone (Soil moisure)
    //der(V_g_w[i]) = V_dot_s2g[i] - V_dot_g2s[i] - (1-a)*V_dot_g_e[i];
    der(V_g_w[i]) = V_dot_s2g[i] - V_dot_g2s[i] - a_e[i] .* V_dot_g_e[i];
    V_dot_g2s[i] = if V_g_w[i] >= 0 and V_g_w[i] / ((1 - a_L[i]) * A[i]) < g_T then (V_g_w[i] / g_T / ((1 - a_L[i]) * A[i])) ^ beta * V_dot_s2g[i] else V_dot_s2g[i];
    //V_dot_g_e[i] = if V_g_w[i]<g_T*A[i] then (V_g_w[i]/(g_T*A[i]))*V_dot_epot*A[i] else V_dot_epot*A[i];
    V_dot_epot[i] = evap_var.y[1] * 1e-3 / 86400 * (1 + CE * (T[i] - month_temp.y[i]));
    V_dot_g_e[i] = if V_g_w[i] / ((1 - a_L[i]) * A[i]) < g_T then V_g_w[i] / g_T / ((1 - a_L[i]) * A[i]) * V_dot_epot[i] * (1 - a_L[i]) * A[i] else V_dot_epot[i] * (1 - a_L[i]) * A[i];
    a_e[i] = if V_s_d[i] < err then 1 else 0;
    ///// Soil zone (Upper zone)
    der(V_s_w[i]) = V_dot_g2s[i] - V_dot_s2b[i] - V_dot_s2sr[i] - V_dot_s2fr[i];
    V_dot_s2b[i] = if V_dot_g2s[i] > (1 - a_L[i]) * A[i] * PERC then (1 - a_L[i]) * A[i] * PERC else 0;
    V_dot_s2sr[i] = if V_s_w[i] / ((1 - a_L[i]) * A[i]) > s_T then a_1 * (V_s_w[i] - s_T * (1 - a_L[i]) * A[i]) else 0;
    V_dot_s2fr[i] = a_2 * V_s_w[i];
    ///// Basement zone (Lower zone)
    der(V_b_w[i]) = V_dot_s2b[i] + V_dot_pl[i] - V_dot_b2br[i] - V_dot_l_e[i];
    V_dot_pl[i] = a_L[i] * A[i] * V_dot_p[i];
    V_dot_b2br[i] = a_3 * V_b_w[i];
    V_dot_l_e[i] = a_L[i] * A[i] * V_dot_epot[i];
  end for;
  ///// Evaporation
  //V_dot_epot = evap_var.y[1]*1e-3/86400;//V_dot_epot_month[1]*1e-3/86400;//if time<=30 then V_dot_epot_month[1] else V_dot_epot_month[2];
  /////
  F_o = (flow_var.y[1] - 17.230144) ^ 2;
  F_e = (flow_var.y[1] - V_dot_tot) ^ 2;
  R2 = (F_o - F_e) / F_o;
  annotation (
    experiment(StopTime = 31536000, Interval = 86400));
end RunOff_SI;
