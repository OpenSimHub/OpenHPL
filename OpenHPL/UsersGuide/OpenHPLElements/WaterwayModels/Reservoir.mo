within OpenHPL.UsersGuide.OpenHPLElements.WaterwayModels;
class Reservoir "Reservoir Model"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<h4>Reservoir</h4>
<p>
The water level in the reservoir H<sub>r</sub> is a key quantity. The reservoir model can be described by
mass and momentum balances. For a detailed model with inflow:
</p>
<p>
$$ H_\\mathrm{r}\\frac{d\\dot{m}_\\mathrm{r}}{dt} = \\frac{\\rho}{A_\\mathrm{r}}\\dot{V}_\\mathrm{r}^2 + A_\\mathrm{r}(p_\\mathrm{atm}-p_\\mathrm{r}) + \\rho gH_\\mathrm{r}A_\\mathrm{r} - F_\\mathrm{f,r} $$
</p>
<p>
$$ \\frac{dm_\\mathrm{r}}{dt} = \\dot{m}_\\mathrm{r} $$
</p>
<p>
where ṁ<sub>r</sub> is the reservoir mass flow rate, A<sub>r</sub> is the cross-sectional area, p<sub>atm</sub>
and p<sub>r</sub> are atmospheric and outlet pressures, and F<sub>f,r</sub> is the friction term.
</p>

<h5>Simplified Model</h5>
<p>
In a simple case with constant reservoir level and infinite area, the reservoir is simply:
</p>
<p>
$$ p_\\mathrm{r} = p_\\mathrm{atm} + \\rho g H_\\mathrm{r} $$
</p>

<h5>Usage</h5>
<p>
The <code>Reservoir</code> unit uses the <code>Contact</code> connector and can be connected to other
waterway units. The user can:
</p>
<ul>
<li>Choose a simple model and calculate outlet pressure from the depth</li>
<li>Use a detailed model with inflow and specify reservoir geometry</li>
<li>Connect an input signal with varying water level</li>
</ul>
</html>"));
end Reservoir;
