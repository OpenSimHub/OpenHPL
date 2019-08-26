within OpenHPL.Waterway;
model RunOff_zones_input "Run off model without input data (inputs could be specified in Python)"
  extends OpenHPL.Icons.RunOff;
  parameter Integer N = 10 "# of height zones" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T_t = 1 "Threshold temperature" annotation (
    Dialog(group = "Physically-based parameters"));
  parameter Modelica.SIunits.Area A[N] = ones(N) * 41.3e6 "Catchment area" annotation (
    Dialog(group = "Geometry"));
  parameter Real s_T = 20e-3 "Soil zone saturation threshold, m" annotation (
    Dialog(group = "Empirical parameters")), a_1 = 0.547 / 86400 "Discharge frequency for surface runoff, 1/sec" annotation (
    Dialog(group = "Empirical parameters")), a_2 = 0.489 / 86400 "Discharge frequency for fast runoff, 1/sec" annotation (
    Dialog(group = "Empirical parameters")), a_3 = 0.0462 / 86400 "Discharge frequency for base runoff, 1/sec" annotation (
    Dialog(group = "Empirical parameters")), a_L[N] = {15.43, 3.97, 1.79, 0.81, 1.27, 1.44, 1.03, 2.32, 1.31, 0.57} .* 1e6 ./ A "Fractional area covered by lakes, -" annotation (
    Dialog(group = "Geometry")), g_T = 150e-3 "Ground saturation threshold, m" annotation (
    Dialog(group = "Physically-based parameters")), precC = 0.6e-3 / 86400 "preccolation from soil zone to base zone, m/sec" annotation (
    Dialog(group = "Empirical parameters")), beta = 2 "Ground zone shape coefficient, -" annotation (
    Dialog(group = "Empirical parameters")), k_m = 4e-3 / 86400 "Melting factor, m/deg/sec" annotation (
    Dialog(group = "Physically-based parameters")), PCORR = 1.05 "Precipitation correction - Rainfall, -" annotation (
    Dialog(group = "Empirical parameters")), SCORR = 1.2 "Precipitation correction - Snowfall, -" annotation (
    Dialog(group = "Empirical parameters")), CE = 0.04 "Model parameter for adjusted evapotranspiration, 1/deg" annotation (
    Dialog(group = "Empirical parameters"));
  input Real temp_var[N], prec_var[N], evap_var, month_temp[N], flow_var;
  Modelica.SIunits.Height V_s_w[N] "Water content in soil zone", V_b_w[N] "Water content in base zone", V_g_w[N] "Water content in ground zone", V_s_d[N] "Dry snow";
  //V_s_s[N] "Soggy snow";
  Modelica.SIunits.VolumeFlowRate V_doT_tot "Total runoff";
  Modelica.SIunits.Velocity V_dot_s2b[N] "Runoff rate from soil zone to base zone", V_dot_pl[N] "Precipitation in lake", V_dot_b2br[N] "Runoff rate from base zone t obase runoff", V_dot_l_e[N] "Rate of evapotranspiration from lake", V_dot_g2s[N] "Runoff rate from ground zone to soil zone", V_dot_s2sr[N] "Runoff rate from soil zone to surface runoff", V_dot_s2fr[N] "Runoff rate from soil zone to fast runoff", V_dot_s2g[N] "Runoff rate from snow zone to ground zone", V_dot_g_e[N] "Evapotranspiration rate from ground zone", V_dot_p_r[N] "Precipitation in mainland in the form of snow", V_dot_d2w[N] "Melting rate from dry snow form to water snow form", V_dot_p_s[N] "Precipitation in mainland in the form of snow", V_dot_epot[N] "Evapotranspiration";
  //V_dot_w2d[N] "Freezing rate from water snow form to dry snow form";
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T[N] "Ambient temperature";
  Modelica.SIunits.Velocity V_dot_p[N] "Precipitation";
  Real a_e[N], a_sw[N], F_o, F_e, R2, err = 0.5e-3 "Smal error, m";
  Modelica.Blocks.Interfaces.RealOutput V_dot_runoff annotation (
    Placement(transformation(extent = {{90, -10}, {110, 10}}), iconTransformation(extent = {{80, -20}, {120, 20}})));
initial equation
  //V_s_s = zeros(N);
  V_s_d = zeros(N);
  V_g_w = zeros(N);
  V_s_w = zeros(N);
  V_b_w = zeros(N);
equation
  ///// Total runoff
  //der(V_doT_tot) = if V_s_w > s_T then (a_1*(V_s_w-s_T)+a_2*V_s_w)*(1-sum(a_L)/N)*sum(A) + sum(A)*a_3*V_b_w else a_2*V_s_w*(1-sum(a_L)/N)*sum(A) + sum(A)*a_3*V_b_w;
  V_doT_tot = sum(A .* (V_dot_b2br + V_dot_s2sr + V_dot_s2fr));
  for i in 1:N loop
    ///// Snow zone (Snow rourine)
    //T[i] = temp_var.y[i];
    T[i] = temp_var[i];
    //V_dot_p[i] = prec_var.y[i] * 1e-3 / 86400;
    V_dot_p[i] = prec_var[i] * 1e-3 / 86400;
    der(V_s_d[i]) = V_dot_p_s[i] - V_dot_d2w[i];
    // + V_dot_w2d[i];
    //der(V_s_s[i]) = V_dot_p_r[i] - V_dot_w2d[i] + V_dot_d2w[i] - V_dot_s2g[i];
    V_dot_p_s[i] = if T[i] <= T_t then V_dot_p[i] * PCORR * SCORR * (1 - a_L[i]) else 0;
    V_dot_p_r[i] = if T[i] > T_t then V_dot_p[i] * PCORR * (1 - a_L[i]) else 0;
    V_dot_d2w[i] = if T[i] > T_t and V_s_d[i] >= 0 then k_m * (T[i] - T_t) * (1 - a_L[i]) else 0;
    //V_dot_w2d[i] = if T[i]<=T_t and V_s_s[i]>=0 then k_m*(T_t-T[i]) else 0;
    //V_dot_s2g[i] = if T[i]>T_t and V_s_s[i]<err*1e-5 and V_s_d[i]<err then V_dot_p_r[i] elseif V_s_s[i]>=err and V_s_d[i]>=err then (1+a_w)*V_dot_d2w[i]+V_dot_p_r[i] else 0;
    V_dot_s2g[i] = V_dot_p_r[i] + V_dot_d2w[i];
    ///// Ground zone (Soil moisure)
    //der(V_g_w[i]) = V_dot_s2g[i] - V_dot_g2s[i] - (1-a)*V_dot_g_e[i];
    der(V_g_w[i]) = V_dot_s2g[i] - V_dot_g2s[i] - a_e[i] .* V_dot_g_e[i];
    V_dot_g2s[i] = if V_g_w[i] >= 0 and V_g_w[i] < g_T then (V_g_w[i] / g_T) ^ beta * V_dot_s2g[i] else V_dot_s2g[i];
    V_dot_epot[i] = evap_var * 1e-3 / 86400 * (1 + CE * (T[i] - month_temp[i]));
    V_dot_g_e[i] = if V_g_w[i] < g_T then V_g_w[i] / g_T * V_dot_epot[i] else V_dot_epot[i];
    a_e[i] = if V_s_d[i] < err then 1 else 0;
    ///// Soil zone (Upprec zone)
    der(V_s_w[i]) = V_dot_g2s[i] - a_sw[i] * V_dot_s2b[i] - V_dot_s2sr[i] - V_dot_s2fr[i];
    V_dot_s2b[i] = (1 - a_L[i]) * precC;
    V_dot_s2sr[i] = if V_s_w[i] > s_T then a_1 * (V_s_w[i] - s_T) else 0;
    V_dot_s2fr[i] = a_2 * V_s_w[i];
    a_sw[i] = if V_dot_g2s[i] < V_dot_s2b[i] then 0 else 1;
    ///// Basement zone (Lower zone)
    der(V_b_w[i]) = V_dot_s2b[i] + V_dot_pl[i] - V_dot_b2br[i] - V_dot_l_e[i];
    V_dot_pl[i] = a_L[i] * V_dot_p[i];
    V_dot_b2br[i] = a_3 * V_b_w[i];
    V_dot_l_e[i] = a_L[i] * V_dot_epot[i];
  end for;
  ///// Error
  F_o = (flow_var - 17.230144) ^ 2;
  F_e = (flow_var - V_doT_tot) ^ 2;
  R2 = 1 - F_e / F_o;
  V_dot_runoff = V_doT_tot;
  annotation (
    experiment(StopTime = 315360000, Interval = 86400),
    Documentation(info = "<html><head></head><body><span style=\"font-size: 12px;\">This is the same hydrology model that is based on the HBV hydrological model. This model can be used to define the inflow (runoff) to the reservoir.</span><div><br></div><div>Here the input data are not specified.&nbsp;<br><div><span style=\"font-size: 12px;\"><br></span></div></div></body></html>"));
end RunOff_zones_input;
