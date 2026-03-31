within OpenHPL.Waterway;
model RunOff "Run off model. (with 10 height zones)"
  extends OpenHPL.Icons.RunOff;

  parameter Integer N = 10 "Number of height zones"
    annotation (Dialog(group = "Geometry"));
  parameter SI.Area A[N] = ones(N) * 41.3e6 "Catchment area"
    annotation (Dialog(group = "Geometry"));
  parameter SI.PerUnit a_L[N] = {15.43, 3.97, 1.79, 0.81, 1.27, 1.44, 1.03, 2.32, 1.31, 0.57} .* 1e6 ./ A "Fractional area covered by lakes"
    annotation (Dialog(group = "Geometry"));

  parameter Modelica.Units.NonSI.Temperature_degC T_t=1 "Threshold temperature"
    annotation (Dialog(group="Physically-based parameters"));
  parameter Real k_m(unit="m/deg/s") = 4e-3 / 86400 "Melting factor"
    annotation (Dialog(group = "Physically-based parameters"));
  parameter SI.Volume g_T = 150e-3 "Ground saturation threshold"
    annotation (Dialog(group = "Physically-based parameters"));

  parameter SI.Volume s_T = 20e-3 "Soil zone saturation threshold"
    annotation (Dialog(group = "Empirical parameters"));
  parameter SI.Frequency a_1 = 0.547 / 86400 "Discharge frequency for surface runoff"
    annotation (Dialog(group = "Empirical parameters"));
  parameter SI.Frequency a_2 = 0.489 / 86400 "Discharge frequency for fast runoff"
    annotation (Dialog(group = "Empirical parameters"));
  parameter SI.Frequency a_3 = 0.0462 / 86400 "Discharge frequency for base runoff"
    annotation (Dialog(group = "Empirical parameters"));
  parameter SI.VolumeFlowRate PERC = 0.6e-3 / 86400 "Percolation from soil zone to base zone"
    annotation (Dialog(group = "Empirical parameters"));
  parameter Real beta = 2 "Ground zone shape coefficient"
    annotation (Dialog(group = "Empirical parameters"));
  parameter Real PCORR = 1.05 "Precipitation correction - Rainfall"
    annotation (Dialog(group = "Empirical parameters"));
  parameter Real SCORR = 1.2 "Precipitation correction - Snowfall"
    annotation (Dialog(group = "Empirical parameters"));
  parameter Real CE(unit="1/deg") = 0.04 "Model parameter for adjusted evapotranspiration"
    annotation (Dialog(group = "Empirical parameters"));

  parameter Boolean useInput = false "If true, meteorological data is provided via input variables instead of data files"
    annotation (Dialog(tab = "Input data"), choices(checkBox = true));
  parameter String fileName_temp = Modelica.Utilities.Files.loadResource("modelica://OpenHPL/Resources/Tables/Temp_var.txt") "File with temperature variations in different height zones"
    annotation (Dialog(tab = "Input data", group = "Temperature", enable=not useInput));
  parameter String tableName_temp = "zones_temp" "Table with temperature variations in different height zones"
    annotation (Dialog(tab = "Input data", group = "Temperature", enable=not useInput));
  parameter Integer columns_temp[:] = 2:N + 1 "Columns with temperature variations for different height zones"
    annotation (Dialog(tab = "Input data", group = "Temperature", enable=not useInput));

  parameter String fileName_prec = Modelica.Utilities.Files.loadResource("modelica://OpenHPL/Resources/Tables/Prec_var.txt") "File with precipitation variations in different height zones"
    annotation (Dialog(tab = "Input data", group = "Precipitation", enable=not useInput));
  parameter String tableName_prec = "zones_prec" "Table with precipitation variations in different height zones"
    annotation (Dialog(tab = "Input data", group = "Precipitation", enable=not useInput));
  parameter Integer columns_prec[:] = 2:N + 1 "Columns with precipitation variations for different height zones"
    annotation (Dialog(tab = "Input data", group = "Precipitation", enable=not useInput));

  parameter String fileName_evap = Modelica.Utilities.Files.loadResource("modelica://OpenHPL/Resources/Tables/Evap_var.txt") "File with evapotranspiration variations during the year"
    annotation (Dialog(tab = "Input data", group = "Evapotranspiration", enable=not useInput));
  parameter String tableName_evap = "evap" "Table with evapotranspiration variations during the year"
    annotation (Dialog(tab = "Input data", group = "Evapotranspiration", enable=not useInput));
  parameter Integer columns_evap[:] = {2} "Column with evapotranspiration variations during the year"
    annotation (Dialog(tab = "Input data", group = "Evapotranspiration", enable=not useInput));
  parameter String fileName_month_temp = Modelica.Utilities.Files.loadResource("modelica://OpenHPL/Resources/Tables/Month_av_temp.txt") "File with monthly average temperature for evapotranspiration calculation"
    annotation (Dialog(tab = "Input data", group = "Evapotranspiration", enable=not useInput));
  parameter String tableName_month_temp = "month_temp" "Table with monthly average temperature"
    annotation (Dialog(tab = "Input data", group = "Evapotranspiration", enable=not useInput));
  parameter Integer columns_month_temp[:] = 2:N + 1 "Columns with monthly average temperature variations for different height zones"
    annotation (Dialog(tab = "Input data", group = "Evapotranspiration", enable=not useInput));

  parameter String fileName_flow = Modelica.Utilities.Files.loadResource("modelica://OpenHPL/Resources/Tables/Flow_var_d.txt") "File with real observed run off"
    annotation (Dialog(tab = "Input data", group = "Real run off", enable=not useInput));
  parameter String tableName_flow = "flow" "Table with real observed run off"
    annotation (Dialog(tab = "Input data", group = "Real run off", enable=not useInput));
  parameter Integer columns_flow[:] = {2} "Column with real observed run off"
     annotation (Dialog(tab = "Input data", group = "Real run off", enable=not useInput));

  SI.Volume V_s_w[N] "Water content in soil zone";
  SI.Volume V_b_w[N] "Water content in base zone";
  SI.Volume V_g_w[N] "Water content in ground zone";
  SI.Volume V_s_d[N] "Dry snow";
  SI.VolumeFlowRate Vdot_tot "Total runoff";
  SI.VolumeFlowRate Vdot_s2b[N] "Runoff rate from soil zone to base zone";
  SI.VolumeFlowRate Vdot_pl[N] "Precipitation in lake";
  SI.VolumeFlowRate Vdot_b2br[N] "Runoff rate from base zone t obase runoff";
  SI.VolumeFlowRate Vdot_l_e[N] "Rate of evapotranspiration from lake";
  SI.VolumeFlowRate Vdot_g2s[N] "Runoff rate from ground zone to soil zone";
  SI.VolumeFlowRate Vdot_s2sr[N] "Runoff rate from soil zone to surface runoff";
  SI.VolumeFlowRate Vdot_s2fr[N] "Runoff rate from soil zone to fast runoff";
  SI.VolumeFlowRate Vdot_s2g[N] "Runoff rate from snow zone to ground zone";
  SI.VolumeFlowRate Vdot_g_e[N] "Evapotranspiration rate from ground zone";
  SI.VolumeFlowRate Vdot_p_r[N] "Precipitation in mainland in the form of snow";
  SI.VolumeFlowRate Vdot_d2w[N] "Melting rate from dry snow form to water snow form";
  SI.VolumeFlowRate Vdot_p_s[N] "Precipitation in mainland in the form of snow";
  SI.VolumeFlowRate Vdot_epot[N] "Evapotranspiration";

  Modelica.Units.NonSI.Temperature_degC T[N] "Ambient temperature";
  SI.VolumeFlowRate Vdot_p[N] "Precipitation";
  Real a_e[N], a_sw[N], F_o, F_e, R2, err = 0.5e-3 "Small error, m";

  Modelica.Blocks.Sources.CombiTimeTable temp_var(tableOnFile = true, columns = columns_temp, tableName = tableName_temp, fileName = fileName_temp) if not useInput;
  Modelica.Blocks.Sources.CombiTimeTable prec_var(tableOnFile = true, fileName = fileName_prec, columns = columns_prec, tableName = tableName_prec) if not useInput;
  Modelica.Blocks.Sources.CombiTimeTable evap_var(tableOnFile = true, fileName = fileName_evap, columns = columns_evap, tableName = tableName_evap) if not useInput;
  Modelica.Blocks.Sources.CombiTimeTable month_temp(tableOnFile = true, fileName = fileName_month_temp, columns = columns_month_temp, tableName = tableName_month_temp) if not useInput;
  Modelica.Blocks.Sources.CombiTimeTable flow_var(tableOnFile = true, fileName = fileName_flow, columns = columns_flow, tableName = tableName_flow) if not useInput;

  input Real temp_input[N] if useInput "Zone temperature [degC]";
  input Real prec_input[N] if useInput "Zone precipitation [mm/day]";
  input Real evap_input if useInput "Potential evapotranspiration [mm/day]";
  input Real month_temp_input[N] if useInput "Monthly average zone temperature [degC]";
  input Real flow_input if useInput "Observed flow for R2 calculation [m3/s]";

  Modelica.Blocks.Interfaces.RealOutput Vdot_runoff "Output connector"
    annotation (
    Placement(transformation(extent = {{100, -10}, {120, 10}})));
initial equation
  V_s_d = zeros(N);
  V_g_w = zeros(N);
  V_s_w = zeros(N);
  V_b_w = zeros(N);
equation
  Vdot_tot = sum(A .* (Vdot_b2br + Vdot_s2sr + Vdot_s2fr)) "Total runoff";
  for i in 1:N loop
    if useInput then
      T[i] = temp_input[i];
      Vdot_p[i] = prec_input[i] * 1e-3 / 86400;
    else
      T[i] = temp_var.y[i];
      Vdot_p[i] = prec_var.y[i] * 1e-3 / 86400;
    end if;
    der(V_s_d[i]) = Vdot_p_s[i] - Vdot_d2w[i];
    Vdot_p_s[i] = if T[i] <= T_t then Vdot_p[i] * PCORR * SCORR * (1 - a_L[i]) else 0;
    Vdot_p_r[i] = if T[i] > T_t then Vdot_p[i] * PCORR * (1 - a_L[i]) else 0;
    Vdot_d2w[i] = if T[i] > T_t and V_s_d[i] >= 0 then k_m * (T[i] - T_t) * (1 - a_L[i]) else 0;
    Vdot_s2g[i] = Vdot_p_r[i] + Vdot_d2w[i];

    der(V_g_w[i]) = Vdot_s2g[i] - Vdot_g2s[i] - a_e[i] .* Vdot_g_e[i] "Ground zone (Soil moisure)";
    Vdot_g2s[i] = if V_g_w[i] >= 0 and V_g_w[i] < g_T then (V_g_w[i] / g_T) ^ beta * Vdot_s2g[i] else Vdot_s2g[i];
    if useInput then
      Vdot_epot[i] = evap_input * 1e-3 / 86400 * (1 + CE * (T[i] - month_temp_input[i]));
    else
      Vdot_epot[i] = evap_var.y[1] * 1e-3 / 86400 * (1 + CE * (T[i] - month_temp.y[i]));
    end if;
    Vdot_g_e[i] = if V_g_w[i] < g_T then V_g_w[i] / g_T * Vdot_epot[i] else Vdot_epot[i];
    a_e[i] = if V_s_d[i] < err then 1 else 0;

    der(V_s_w[i]) = Vdot_g2s[i] - a_sw[i] * Vdot_s2b[i] - Vdot_s2sr[i] - Vdot_s2fr[i] "Soil zone (Upprec zone)";
    Vdot_s2b[i] = (1 - a_L[i]) * PERC;
    Vdot_s2sr[i] = if V_s_w[i] > s_T then a_1 * (V_s_w[i] - s_T) else 0;
    Vdot_s2fr[i] = a_2 * V_s_w[i];
    a_sw[i] = if Vdot_g2s[i] < Vdot_s2b[i] then 0 else 1;

    der(V_b_w[i]) = Vdot_s2b[i] + Vdot_pl[i] - Vdot_b2br[i] - Vdot_l_e[i] "Basement zone (Lower zone)";
    Vdot_pl[i] = a_L[i] * Vdot_p[i];
    Vdot_b2br[i] = a_3 * V_b_w[i];
    Vdot_l_e[i] = a_L[i] * Vdot_epot[i];
  end for;

  if useInput then
    F_o = (flow_input - 17.230144) ^ 2;
    F_e = (flow_input - Vdot_tot) ^ 2;
  else
    F_o = (flow_var.y[1] - 17.230144) ^ 2;
    F_e = (flow_var.y[1] - Vdot_tot) ^ 2;
  end if;
  R2 = 1 - F_e / F_o;
  Vdot_runoff = Vdot_tot;
  annotation (preferredView="info",
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
This hydrology model is encoded in the <em>OpenHPL</em> library as the <code>RunOff</code> unit where the main
defined variable is the total runoff from the catchment. This unit uses the standard Modelica connector <code>RealOutput</code>
connector as an output from the model that can be connected to, for example, simple reservoir model <code>Reservoir</code> unit.
</p>

<p>
Meteorological inputs (air temperature, precipitation, potential evapotranspiration, and monthly average temperature for
each elevation zone) can be provided in two ways, controlled by the boolean parameter <code>useInput</code>:
</p>
<ul>
<li>When <code>useInput = false</code> (default), historic data is read from text files using the standard Modelica
<code>CombiTimeTable</code> source models. The file names and table names are specified via the parameters in the
<em>Input data</em> tab.</li>
<li>When <code>useInput = true</code>, the inputs are supplied through <code>input Real</code> connectors
(<code>temp_input</code>, <code>prec_input</code>, <code>evap_input</code>, <code>month_temp_input</code>, and
<code>flow_input</code>), allowing the model to be driven by external signals at runtime.</li>
</ul>

<h5>Parameters</h5>
<p>
When the <code>RunOff</code> unit is in use, the user can specify the required geometry parameters for the catchment:
the number of elevation zones, all hydrology parameters such as threshold temperatures, degree-day factor, precipitation
correction coefficients, field capacity and β parameter in soil moisture routine, threshold level for quick runoff in upper
zone, percolation from upper zone to lower zone, recession constants for the surface and quick runoffs in upper zone, and
recession constant for the base runoff in lower zone. The boolean parameter <code>useInput</code> selects whether
meteorological data is read from files (<code>false</code>) or supplied via input connectors (<code>true</code>). When
<code>useInput = false</code>, the user can also specify the text files where the data for the
<code>CombiTimeTable</code> models are stored.
</p>
</html>"));
end RunOff;