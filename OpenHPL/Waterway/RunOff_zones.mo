within OpenHPL.Waterway;
model RunOff_zones "Run off model. (with 10 height zones)"
  extends OpenHPL.Icons.RunOff;
  // height zone segmentation
  parameter Integer N = 10 "# of height zones" annotation (
    Dialog(group = "Geometry"));
  // parameters of the hydrology model
  parameter Modelica.Units.NonSI.Temperature_degC T_t=-3.91223331e-01 "Threshold temperature" annotation (Dialog(group="Physically-based parameters"));
  parameter SI.Area A[N] = ones(N) * 41.3e6 "Catchment area" annotation (
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
  // parameters for outsource files with data
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
  // variables
  SI.Height V_s_w[N] "Water content in soil zone", V_b_w[N] "Water content in base zone", V_g_w[N] "Water content in ground zone", V_s_d[N] "Dry snow";
  //V_s_s[N] "Soggy snow";
  SI.VolumeFlowRate Vdot_tot "Total runoff";
  SI.Velocity Vdot_s2b[N] "Runoff rate from soil zone to base zone", Vdot_pl[N] "Precipitation in lake", Vdot_b2br[N] "Runoff rate from base zone t obase runoff", Vdot_l_e[N] "Rate of evapotranspiration from lake", Vdot_g2s[N] "Runoff rate from ground zone to soil zone", Vdot_s2sr[N] "Runoff rate from soil zone to surface runoff", Vdot_s2fr[N] "Runoff rate from soil zone to fast runoff", Vdot_s2g[N] "Runoff rate from snow zone to ground zone", Vdot_g_e[N] "Evapotranspiration rate from ground zone", Vdot_p_r[N] "Precipitation in mainland in the form of snow", Vdot_d2w[N] "Melting rate from dry snow form to water snow form", Vdot_p_s[N] "Precipitation in mainland in the form of snow", Vdot_epot[N] "Evapotranspiration";
  //Vdot_w2d[N] "Freezing rate from water snow form to dry snow form";
  Modelica.Units.NonSI.Temperature_degC T[N] "Ambient temperature";
  SI.Velocity Vdot_p[N] "Precipitation";
  Real a_e[N], a_sw[N], F_o, F_e, R2, err = 0.5e-3 "Small error, m";
  // using  data
  Modelica.Blocks.Sources.CombiTimeTable temp_var(tableOnFile = true, columns = columns_temp, tableName = tableName_temp, fileName = fileName_temp);
  Modelica.Blocks.Sources.CombiTimeTable prec_var(tableOnFile = true, fileName = fileName_prec, columns = columns_prec, tableName = tableName_prec);
  Modelica.Blocks.Sources.CombiTimeTable evap_var(tableOnFile = true, fileName = fileName_evap, columns = columns_evap, tableName = tableName_evap);
  Modelica.Blocks.Sources.CombiTimeTable month_temp(tableOnFile = true, fileName = fileName_month_temp, columns = columns_month_temp, tableName = tableName_month_temp);
  Modelica.Blocks.Sources.CombiTimeTable flow_var(tableOnFile = true, fileName = fileName_flow, columns = columns_flow, tableName = tableName_flow);
  // connector
  Modelica.Blocks.Interfaces.RealOutput Vdot_runoff annotation (
    Placement(transformation(extent = {{90, -10}, {110, 10}}), iconTransformation(extent = {{80, -20}, {120, 20}})));
initial equation
  //V_s_s = zeros(N);
  V_s_d = zeros(N);
  V_g_w = zeros(N);
  V_s_w = zeros(N);
  V_b_w = zeros(N);
equation
  // Total runoff
  //der(Vdot_tot) = if V_s_w > s_T then (a_1*(V_s_w-s_T)+a_2*V_s_w)*(1-sum(a_L)/N)*sum(A) + sum(A)*a_3*V_b_w else a_2*V_s_w*(1-sum(a_L)/N)*sum(A) + sum(A)*a_3*V_b_w;
  Vdot_tot = sum(A .* (Vdot_b2br + Vdot_s2sr + Vdot_s2fr));
  for i in 1:N loop
    // Snow zone (Snow rourine)
    T[i] = temp_var.y[i];
    Vdot_p[i] = prec_var.y[i] * 1e-3 / 86400;
    der(V_s_d[i]) = Vdot_p_s[i] - Vdot_d2w[i];
    // + Vdot_w2d[i];
    //der(V_s_s[i]) = Vdot_p_r[i] - Vdot_w2d[i] + Vdot_d2w[i] - Vdot_s2g[i];
    Vdot_p_s[i] = if T[i] <= T_t then Vdot_p[i] * PCORR * SCORR * (1 - a_L[i]) else 0;
    Vdot_p_r[i] = if T[i] > T_t then Vdot_p[i] * PCORR * (1 - a_L[i]) else 0;
    Vdot_d2w[i] = if T[i] > T_t and V_s_d[i] >= err * 1e-2 then k_m * (T[i] - T_t) * (1 - a_L[i]) else 0;
    //Vdot_w2d[i] = if T[i]<=T_t and V_s_s[i]>=0 then k_m*(T_t-T[i]) else 0;
    //Vdot_s2g[i] = if T[i]>T_t and V_s_s[i]<err*1e-5 and V_s_d[i]<err then Vdot_p_r[i] elseif V_s_s[i]>=err and V_s_d[i]>=err then (1+a_w)*Vdot_d2w[i]+Vdot_p_r[i] else 0;
    Vdot_s2g[i] = Vdot_p_r[i] + Vdot_d2w[i];
    // Ground zone (Soil moisure)
    //der(V_g_w[i]) = Vdot_s2g[i] -Vdot_g2s[i] - (1-a)*Vdot_g_e[i];
    der(V_g_w[i]) = Vdot_s2g[i] - Vdot_g2s[i] - a_e[i] .* Vdot_g_e[i];
    Vdot_g2s[i] = if V_g_w[i] >= 0 and V_g_w[i] < g_T then (V_g_w[i] / g_T) ^ beta * Vdot_s2g[i] else Vdot_s2g[i];
    Vdot_epot[i] = evap_var.y[1] * 1e-3 / 86400 * (1 + CE * (T[i] - month_temp.y[i]));
    Vdot_g_e[i] = if V_g_w[i] < g_T then V_g_w[i] / g_T * Vdot_epot[i] else Vdot_epot[i];
    a_e[i] = if V_s_d[i] < err then 1 else 0;
    // Soil zone (Upprec zone)
    der(V_s_w[i]) = Vdot_g2s[i] - a_sw[i] * Vdot_s2b[i] - Vdot_s2sr[i] - Vdot_s2fr[i];
    Vdot_s2b[i] = (1 - a_L[i]) * PERC;
    Vdot_s2sr[i] = if V_s_w[i] > s_T then a_1 * (V_s_w[i] - s_T) else 0;
    Vdot_s2fr[i] = a_2 * V_s_w[i];
    a_sw[i] = if Vdot_g2s[i] < Vdot_s2b[i] then 0 else 1;
    // Basement zone (Lower zone)
    der(V_b_w[i]) = Vdot_s2b[i] + Vdot_pl[i] - Vdot_b2br[i] - Vdot_l_e[i];
    Vdot_pl[i] = a_L[i] * Vdot_p[i];
    Vdot_b2br[i] = a_3 * V_b_w[i];
    Vdot_l_e[i] = a_L[i] * Vdot_epot[i];
  end for;
  // Error
  F_o = (flow_var.y[1] - 17.230144) ^ 2;
  F_e = (flow_var.y[1] - Vdot_tot) ^ 2;
  R2 = 1 - F_e / F_o;
  Vdot_runoff = Vdot_tot;
  annotation (
    Documentation(info="<html>
<p>
Similar to many other hydrological models, the HBV model is based on the land phase of the hydrological (water) cycle. 
The figure shows that the HBV model consists of four main water storage components connected in a cascade form. Using 
a variety of weather information, such as air temperature, precipitation and potential evapotranspiration, the dynamics 
and the balances of the water in the presented water storages are calculated. Hence, the runoff/inflow from some of the 
defined catchment areas can be found.
</p>

<p align=\"center\">
  <img src=\"modelica://OpenHPL/Resources/Images/hydrology.png\" alt=\"HBV model structure\" width=\"600\"/>
</p>
<p><em>Figure: Structure of the HBV model.</em></p>

<p>
The model is developed for each water storage component to define the dynamics and balances of the water. In addition, 
the catchment area is divided into elevation zones (usually not more than ten) where each zone has the same area. The 
air temperature and the precipitation are provided for each elevation zone. Hence, all calculations within each water 
storage component are performed for each elevation zone.
</p>

<h5>Snow Routine</h5>
<p>
In the snow routine segment, the snow storage, as well as snowmelt are computed. This computation is performed for 
each elevation zone. Using the mass balance, the change in the dry snow storage volume \\(V_\\mathrm{s,d}\\), is found 
as follows:
</p>
<p>
$$ \\frac{\\mathrm{d}V_\\mathrm{s,d}}{\\mathrm{d}t}=\\dot{V}_\\mathrm{p,s}-\\dot{V}_\\mathrm{d2w} $$
</p>
<p>
Here, the flow of the precipitation in the form of snow is denoted as \\(\\dot{V}_\\mathrm{p,s}\\). This precipitation 
in the form of snow is defined from the input precipitation flow, \\(\\dot{V}_\\mathrm{p}\\), based on the information 
about the air temperature, T, a threshold temperature for snowmelt, T<sub>T</sub>, and for the area that is not covered 
by lakes (the fractional area covered by the lakes, a<sub>L</sub>, is used):
</p>
<p>
$$
\\dot{V}_\\mathrm{p,s}=\\begin{cases} \\dot{V}_\\mathrm{p}K_\\mathrm{CR}K_\\mathrm{CS}(1 - a_\\mathrm{L}), & \\mbox{if } T\\leq T_\\mathrm{T}\\\\ 0, & \\mbox{if } T>T_\\mathrm{T} \\end{cases}
$$
</p>
<p>
Precipitation correction coefficients K<sub>CR</sub> and K<sub>CS</sub> are also used here, for the rainfall and 
snowfall precipitations, respectively. Then, the flow of precipitation in the form of rain is defined as follows:
</p>
<p>
$$
\\dot{V}_\\mathrm{p,r}=\\begin{cases} \\dot{V}_\\mathrm{p}K_\\mathrm{CR}(1 - a_\\mathrm{L}), & \\mbox{if } T>T_\\mathrm{T}\\\\ 0, & \\mbox{if } T\\leq T_\\mathrm{T} \\end{cases}
$$
</p>
<p>
The flow of the melting snow (melting of snow from dry form to water form), \\(\\dot{V}_\\mathrm{d2w}\\), can be found 
using the following expression based on the degree-day factor K<sub>dd</sub> and the area of the elevation zone A<sub>e</sub>:
</p>
<p>
$$
\\dot{V}_\\mathrm{d2w}=\\begin{cases} A_\\mathrm{e}K_\\mathrm{dd}(T - T_\\mathrm{T})(1 - a_\\mathrm{L}), & \\mbox{if }T>T_\\mathrm{T}\\mbox{ and }V_\\mathrm{s,d}>0\\\\ 0, & \\mbox{otherwise} \\end{cases}
$$
</p>
<p>
Finally, the flow out of the snow routine to the next soil moisture segment, \\(\\dot{V}_\\mathrm{s2s}\\), is found as 
a sum of flows of precipitation in the form of rain, and the melted snow:
</p>
<p>
$$ \\dot{V}_\\mathrm{s2s}=\\dot{V}_\\mathrm{p,r}+\\dot{V}_\\mathrm{d2w} $$
</p>
<p>
It should be noted that a simplification related to the threshold temperature, T<sub>T</sub>, is assumed here. This 
threshold temperature describes both the snow melt and the rainfall to snowfall transition temperatures in the presented 
model. In reality, this threshold temperature might differ for each of these processes. In addition, the storage of snow 
in water form is not considered here, mostly due to the simplification with the threshold temperature.
</p>

<h5>Soil Moisture Routine</h5>
<p>
In the soil moisture segment, the water storage in the ground (soil) is found together with actual evapotranspiration 
from the snow-free areas. The net runoff to the next segment (upper zone) is also defined here. Using the mass balance, 
the volume of the soil moisture storage, \\(V_\\mathrm{s,m}\\), is found as follows:
</p>
<p>
$$ \\frac{\\mathrm{d}V_\\mathrm{s,m}}{\\mathrm{d}t}=\\dot{V}_\\mathrm{s2s}-\\dot{V}_\\mathrm{s2u}-\\alpha_\\mathrm{e}\\dot{V}_\\mathrm{s,e} $$
</p>
<p>
Here, \\(\\dot{V}_\\mathrm{s2u}\\) is the net runoff to the next segment (the upper zone). \\(\\dot{V}_\\mathrm{s,e}\\) 
is the actual evapotranspiration from the soil, that is taken into account only for the snow-free areas (zones). To define 
these snow-free zones, coefficient α<sub>e</sub> is used and equals one for snow-free areas and zero for covered-by-snow 
areas. The actual evapotranspiration can be found from the potential evapotranspiration, \\(\\dot{V}_\\mathrm{e}\\), 
the volume of the soil moisture storage, \\(V_\\mathrm{s,m}\\), the area of the elevation zone A<sub>e</sub>, and the 
field capacity — threshold soil (ground) moisture storage, g<sub>T</sub>:
</p>
<p>
$$
\\dot{V}_\\mathrm{s,e}=\\begin{cases} \\frac{V_\\mathrm{s,m}}{A_\\mathrm{e}g_\\mathrm{T}}\\dot{V}_\\mathrm{e}, & \\mbox{if } V_\\mathrm{s,m}< A_\\mathrm{e}g_\\mathrm{T}\\\\ \\dot{V}_\\mathrm{e}, & \\mbox{if } V_\\mathrm{s,m}\\geq A_\\mathrm{e}g_\\mathrm{T} \\end{cases}
$$
</p>
<p>
The potential evapotranspiration, \\(\\dot{V}_\\mathrm{e}\\), is defined as the input to the hydrology model, similarly 
to the air temperature and precipitations.
</p>

<p>
The output of the soil moisture segment — the net runoff to the next segment, \\(\\dot{V}_\\mathrm{s2u}\\), can be found 
based on the field capacity, g<sub>T</sub>, as follows:
</p>
<p>
$$
\\dot{V}_\\mathrm{s2u}=\\begin{cases} \\Big(\\frac{V_\\mathrm{s,m}}{A_\\mathrm{e}g_\\mathrm{T}}\\Big)^{\\beta}\\dot{V}_\\mathrm{s2s}, & \\mbox{if } 0\\leq V_\\mathrm{s,m}< A_\\mathrm{e}g_\\mathrm{T}\\\\ \\dot{V}_\\mathrm{s2s}, & \\mbox{if } V_\\mathrm{s,m}\\geq A_\\mathrm{e}g_\\mathrm{T} \\end{cases}
$$
</p>
<p>
Here, β is an empirical parameter for specifying the relationship between the flow out of the snow routine, the soil 
moisture storage, and the net runoff from the soil moisture. Typically, β ∈ [2,3], which leads to nonlinearity in this 
equation.
</p>

<h5>Runoff Routine</h5>
<p>
The upper and lower zones are combined into one segment — the runoff routine. In this segment, the runoff from the 
catchment area is found based on the outflow from the soil moisture. The effects of the precipitation to, and 
evapotranspiration from the lakes in the catchment area are also taken into account here.
</p>

<p>
The upper zone characterises components with quick runoff. The following mass balance is used for the upper zone description:
</p>
<p>
$$ \\frac{\\mathrm{d}V_\\mathrm{u,w}}{\\mathrm{d}t}=\\dot{V}_\\mathrm{s2u}-\\dot{V}_\\mathrm{u2l}-\\dot{V}_\\mathrm{u2s}-\\dot{V}_\\mathrm{u2q} $$
</p>
<p>
Here, \\(V_\\mathrm{u,w}\\) is the water volume in the upper zone that depends on the saturation threshold, s<sub>T</sub>, 
which defines the surface (fast) runoff, \\(\\dot{V}_\\mathrm{u2s}\\), and the fast runoff, \\(\\dot{V}_\\mathrm{u2q}\\). 
\\(\\dot{V}_\\mathrm{u2l}\\) is the runoff to the lower zone and is defined by the percolation capacity, K<sub>PC</sub>, 
for the area that is not covered by lakes:
</p>
<p>
$$ \\dot{V}_\\mathrm{u2l}=A_\\mathrm{e}(1-a_\\mathrm{L})K_\\mathrm{PC} $$
</p>
<p>
The surface runoff, \\(\\dot{V}_\\mathrm{u2s}\\), can be found using the saturation threshold, s<sub>T</sub>, and the 
water volume in the upper zone, \\(V_\\mathrm{u,w}\\):
</p>
<p>
$$
\\dot{V}_\\mathrm{u2s}=\\begin{cases} a_1(V_\\mathrm{u,w}-A_\\mathrm{e}s_\\mathrm{T}), & \\mbox{if } V_\\mathrm{u,w}>A_\\mathrm{e}s_\\mathrm{T}\\\\ 0, & \\mbox{if } V_\\mathrm{u,w}\\leq A_\\mathrm{e}s_\\mathrm{T} \\end{cases}
$$
</p>
<p>
Here, a₁ is a parameter that represents the recession constant for the surface runoff. A similar recession constant, a₂, 
is used for the fast runoff, \\(\\dot{V}_\\mathrm{u2q}\\), calculations:
</p>
<p>
$$ \\dot{V}_\\mathrm{u2q}=a_2\\min{(V_\\mathrm{u,w},A_\\mathrm{e}s_\\mathrm{T})} $$
</p>
<p>
The lower zone characterises the lake and the groundwater storages and defines the base runoff from the catchment area. 
The following mass balance equation is used for the lower zone description:
</p>
<p>
$$ \\frac{\\mathrm{d}V_\\mathrm{l,w}}{\\mathrm{d}t}=\\dot{V}_\\mathrm{u2l}+a_\\mathrm{L}\\dot{V}_\\mathrm{p}-\\dot{V}_\\mathrm{l2b}-a_\\mathrm{L}\\dot{V}_\\mathrm{e} $$
</p>
<p>
The water volume in the lower zone is denoted as \\(V_\\mathrm{l,w}\\). As mentioned previously, \\(\\dot{V}_\\mathrm{p}\\) 
and \\(\\dot{V}_\\mathrm{e}\\) are the precipitation and the potential evapotranspiration flows, respectively. a<sub>L</sub> 
is the fractional area covered by lakes. \\(\\dot{V}_\\mathrm{l2b}\\) is the base runoff from the lower zone that can be 
found as follows:
</p>
<p>
$$ \\dot{V}_\\mathrm{l2b}=a_3V_\\mathrm{l,w} $$
</p>
<p>
Here, a₃ is the recession constant similar to a₁ and a₂.
</p>

<p>
The total runoff from the catchment, \\(\\dot{V}_\\mathrm{tot}\\), is a sum of the base, quick, surface runoffs for each 
elevation zones, and is defined as follows:
</p>
<p>
$$ \\dot{V}_\\mathrm{tot}=\\sum\\limits_{i=1}^n(\\dot{V}_{\\mathrm{l2b},i}+\\dot{V}_{\\mathrm{u2s},i}+\\dot{V}_{\\mathrm{u2q},i}) $$
</p>
<p>
Here, the base \\(\\dot{V}_{\\mathrm{l2b},i}\\), quick \\(\\dot{V}_{\\mathrm{u2q},i}\\), and surface 
\\(\\dot{V}_{\\mathrm{u2s},i}\\) runoffs are first summed up for each of the n elevation zones and then these sums of 
the base, quick and surface runoffs are added together.
</p>

<h5>Implementation</h5>
<p>
This hydrology model is encoded in the <em>OpenHPL</em> library as the <code>RunOff_zones</code> unit where the main 
defined variable is the total runoff from the catchment. This unit uses the standard Modelica connector <code>RealOutput</code> 
connector as an output from the model that can be connected to, for example, simple reservoir model <code>Reservoir</code> unit.
</p>

<p>
In order to get historic information about the air temperature, precipitation, and potential evapotranspiration for each 
of the elevation zones, the standard Modelica <code>CombiTimeTable</code> source models are used in order to read this 
data from the text files.
</p>

<h5>Parameters</h5>
<p>
When the <code>RunOff_zones</code> unit is in use, the user can specify the required geometry parameters for the catchment: 
the number of elevation zones, all hydrology parameters such as threshold temperatures, degree-day factor, precipitation 
correction coefficients, field capacity and β parameter in soil moisture routine, threshold level for quick runoff in upper 
zone, percolation from upper zone to lower zone, recession constants for the surface and quick runoffs in upper zone, and 
recession constant for the base runoff in lower zone. Finally, the user can also specify the info about the text files where 
the data for the <code>CombiTimeTable</code> models are stored.
</p>
</html>"));
end RunOff_zones;
