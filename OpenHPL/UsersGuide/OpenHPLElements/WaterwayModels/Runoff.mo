within OpenHPL.UsersGuide.OpenHPLElements.WaterwayModels;
class Runoff "Description of Runoff (HBV) model"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4>Runoff</h4>
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
$$ \\frac{dV_\\mathrm{s,d}}{dt}=\\dot{V}_\\mathrm{p,s}-\\dot{V}_\\mathrm{d2w} $$
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
$$ \\frac{dV_\\mathrm{s,m}}{dt}=\\dot{V}_\\mathrm{s2s}-\\dot{V}_\\mathrm{s2u}-\\alpha_\\mathrm{e}\\dot{V}_\\mathrm{s,e} $$
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
$$ \\frac{dV_\\mathrm{u,w}}{dt}=\\dot{V}_\\mathrm{s2u}-\\dot{V}_\\mathrm{u2l}-\\dot{V}_\\mathrm{u2s}-\\dot{V}_\\mathrm{u2q} $$
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
$$ \\frac{dV_\\mathrm{l,w}}{dt}=\\dot{V}_\\mathrm{u2l}+a_\\mathrm{L}\\dot{V}_\\mathrm{p}-\\dot{V}_\\mathrm{l2b}-a_\\mathrm{L}\\dot{V}_\\mathrm{e} $$
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
</html>", revisions=""));
end Runoff;
