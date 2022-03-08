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
  Modelica.SIunits.VolumeFlowRate Vdot_tot "Total runoff";
  Modelica.SIunits.Velocity Vdot_s2b[N] "Runoff rate from soil zone to base zone", Vdot_pl[N] "Precipitation in lake", Vdot_b2br[N] "Runoff rate from base zone t obase runoff", Vdot_l_e[N] "Rate of evapotranspiration from lake", Vdot_g2s[N] "Runoff rate from ground zone to soil zone", Vdot_s2sr[N] "Runoff rate from soil zone to surface runoff", Vdot_s2fr[N] "Runoff rate from soil zone to fast runoff", Vdot_s2g[N] "Runoff rate from snow zone to ground zone", Vdot_g_e[N] "Evapotranspiration rate from ground zone", Vdot_p_r[N] "Precipitation in mainland in the form of snow", Vdot_d2w[N] "Melting rate from dry snow form to water snow form", Vdot_p_s[N] "Precipitation in mainland in the form of snow", Vdot_epot[N] "Evapotranspiration";
  //Vdot_w2d[N] "Freezing rate from water snow form to dry snow form";
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T[N] "Ambient temperature";
  Modelica.SIunits.Velocity Vdot_p[N] "Precipitation";
  Real a_e[N], a_sw[N], F_o, F_e, R2, err = 0.5e-3 "Small error, m";
  Modelica.Blocks.Interfaces.RealOutput Vdot_runoff annotation (
    Placement(transformation(extent = {{90, -10}, {110, 10}}), iconTransformation(extent = {{80, -20}, {120, 20}})));
initial equation
  //V_s_s = zeros(N);
  V_s_d = zeros(N);
  V_g_w = zeros(N);
  V_s_w = zeros(N);
  V_b_w = zeros(N);
equation
  ///// Total runoff
  //der(Vdot_tot) = if V_s_w > s_T then (a_1*(V_s_w-s_T)+a_2*V_s_w)*(1-sum(a_L)/N)*sum(A) + sum(A)*a_3*V_b_w else a_2*V_s_w*(1-sum(a_L)/N)*sum(A) + sum(A)*a_3*V_b_w;
  Vdot_tot = sum(A .* (Vdot_b2br + Vdot_s2sr + Vdot_s2fr));
  for i in 1:N loop
    ///// Snow zone (Snow rourine)
    //T[i] = temp_var.y[i];
    T[i] = temp_var[i];
    //Vdot_p[i] = prec_var.y[i] * 1e-3 / 86400;
    Vdot_p[i] = prec_var[i] * 1e-3 / 86400;
    der(V_s_d[i]) = Vdot_p_s[i] - Vdot_d2w[i];
    // + Vdot_w2d[i];
    //der(V_s_s[i]) = Vdot_p_r[i] - Vdot_w2d[i] + Vdot_d2w[i] - Vdot_s2g[i];
    Vdot_p_s[i] = if T[i] <= T_t then Vdot_p[i] * PCORR * SCORR * (1 - a_L[i]) else 0;
    Vdot_p_r[i] = if T[i] > T_t then Vdot_p[i] * PCORR * (1 - a_L[i]) else 0;
    Vdot_d2w[i] = if T[i] > T_t and V_s_d[i] >= 0 then k_m * (T[i] - T_t) * (1 - a_L[i]) else 0;
    //Vdot_w2d[i] = if T[i]<=T_t and V_s_s[i]>=0 then k_m*(T_t-T[i]) else 0;
    //Vdot_s2g[i] = if T[i]>T_t and V_s_s[i]<err*1e-5 and V_s_d[i]<err then Vdot_p_r[i] elseif V_s_s[i]>=err and V_s_d[i]>=err then (1+a_w)*Vdot_d2w[i]+Vdot_p_r[i] else 0;
    Vdot_s2g[i] = Vdot_p_r[i] + Vdot_d2w[i];
    ///// Ground zone (Soil moisure)
    //der(V_g_w[i]) = Vdot_s2g[i] - Vdot_g2s[i] - (1-a)*Vdot_g_e[i];
    der(V_g_w[i]) = Vdot_s2g[i] - Vdot_g2s[i] - a_e[i] .* Vdot_g_e[i];
    Vdot_g2s[i] = if V_g_w[i] >= 0 and V_g_w[i] < g_T then (V_g_w[i] / g_T) ^ beta * Vdot_s2g[i] else Vdot_s2g[i];
    Vdot_epot[i] = evap_var * 1e-3 / 86400 * (1 + CE * (T[i] - month_temp[i]));
    Vdot_g_e[i] = if V_g_w[i] < g_T then V_g_w[i] / g_T * Vdot_epot[i] else Vdot_epot[i];
    a_e[i] = if V_s_d[i] < err then 1 else 0;
    ///// Soil zone (Upprec zone)
    der(V_s_w[i]) = Vdot_g2s[i] - a_sw[i] * Vdot_s2b[i] - Vdot_s2sr[i] - Vdot_s2fr[i];
    Vdot_s2b[i] = (1 - a_L[i]) * precC;
    Vdot_s2sr[i] = if V_s_w[i] > s_T then a_1 * (V_s_w[i] - s_T) else 0;
    Vdot_s2fr[i] = a_2 * V_s_w[i];
    a_sw[i] = if Vdot_g2s[i] < Vdot_s2b[i] then 0 else 1;
    ///// Basement zone (Lower zone)
    der(V_b_w[i]) = Vdot_s2b[i] + Vdot_pl[i] - Vdot_b2br[i] - Vdot_l_e[i];
    Vdot_pl[i] = a_L[i] * Vdot_p[i];
    Vdot_b2br[i] = a_3 * V_b_w[i];
    Vdot_l_e[i] = a_L[i] * Vdot_epot[i];
  end for;
  ///// Error
  F_o = (flow_var - 17.230144) ^ 2;
  F_e = (flow_var - Vdot_tot) ^ 2;
  R2 = 1 - F_e / F_o;
  Vdot_runoff = Vdot_tot;
  annotation (
    Documentation(info="<html>
<p>This is the same hydrology model that is based on the HBV hydrological model.</p>
<p>This model can be used to define the inflow (runoff) to the reservoir.
Here the input data is not specified.</p>
</html>"));
end RunOff_zones_input;
