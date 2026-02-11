within OpenHPL.UsersGuide.OpenHPLElements.WaterwayModels;
class Gate "Description of Gate unit"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4>Sluice and Tainter Gates</h4>
<p>
The <em>Gate</em> unit models hydraulic gates used for flow control in hydropower systems and water management 
structures. The library includes models for both sluice gates (vertical gates) and tainter gates (radial gates) 
based on established hydraulic engineering principles.
</p>

<h5>Gate Types</h5>
<p>
Two main gate configurations are supported:
</p>
<ul>
<li><strong>Sluice Gate</strong>: Vertical gate that slides up and down (\\(\\alpha = 90°\\))</li>
<li><strong>Tainter/Radial Gate</strong>: Curved gate pivoting around a horizontal axis above the gate</li>
</ul>

<h5>Flow Modeling</h5>
<p>
The gate discharge is calculated using the standard weir equation with correction coefficients:
</p>
<p>
$$ \\dot{V} = \\chi \\cdot \\mu_A \\cdot A \\cdot \\sqrt{2g h_0} $$
</p>
<p>
where:
</p>
<ul>
<li>\\(\\dot{V}\\): Volume flow rate [m³/s]</li>
<li>\\(\\chi\\): Back-up coefficient (accounts for downstream submergence) [-]</li>
<li>\\(\\mu_A\\): Discharge coefficient [-]</li>
<li>\\(A\\): Gate opening area (\\(A = a \\cdot b\\)) [m²]</li>
<li>\\(g\\): Gravitational acceleration [m/s²]</li>
<li>\\(h_0\\): Upstream water level above gate bottom [m]</li>
<li>\\(a\\): Gate opening height [m]</li>
<li>\\(b\\): Gate width [m]</li>
</ul>

<h5>Discharge Coefficient</h5>
<p>
The discharge coefficient \\(\\mu_A\\) is calculated as:
</p>
<p>
$$ \\mu_A = \\frac{\\psi}{\\sqrt{1 + \\psi a / h_0}} $$
</p>
<p>
where \\(\\psi\\) is the contraction coefficient, which depends on the gate type:
</p>
<ul>
<li><strong>Sluice gate</strong>: \\(\\psi = \\frac{1}{1 + 0.64\\sqrt{1-(a/h_0)^2}}\\)</li>
<li><strong>Tainter gate</strong>: \\(\\psi = 1.3 - 0.8\\sqrt{1 - ((\\alpha_{deg}-205)/220)^2}\\) where \\(\\alpha\\) is the gate edge angle</li>
</ul>

<h5>Flow Regimes</h5>
<p>
The model automatically distinguishes between two flow regimes:
</p>
<ul>
<li><strong>Free flow</strong> (\\(\\chi = 1\\)): When downstream water level is below the critical level</li>
<li><strong>Submerged/backed-up flow</strong> (\\(\\chi &lt; 1\\)): When downstream water level affects the discharge</li>
</ul>
<p>
The critical level for free flow is:
</p>
<p>
$$ h_{2,limit} = \\frac{a\\psi}{2}\\left(\\sqrt{1 + \\frac{16}{\\psi(1+\\psi a/h_0)} \\cdot \\frac{h_0}{a}} - 1\\right) $$
</p>

<h5>Tainter Gate Geometry</h5>
<p>
For tainter gates, additional geometric parameters are required:
</p>
<ul>
<li>\\(r\\): Radius of the gate arm [m]</li>
<li>\\(h_h\\): Height of the hinge above gate bottom [m]</li>
<li>\\(\\alpha\\): Edge angle of the gate, calculated as: \\(\\alpha = \\frac{\\pi}{2} - \\arcsin\\left(\\frac{h_h - a}{r}\\right)\\)</li>
</ul>

<h5>Control Interface</h5>
<p>
The gate model has a <code>RealInput</code> connector for the gate opening <code>a</code> [m], allowing 
dynamic control of the gate position during simulation.
</p>

<h5>Applications</h5>
<p>
Gate models are essential for:
</p>
<ul>
<li>Spillway operation and flood control</li>
<li>Intake gate operation in hydropower systems</li>
<li>Canal and irrigation system control</li>
<li>Emergency shutdown procedures</li>
<li>Water level regulation in reservoirs</li>
</ul>

<h5>References</h5>
<p>
The gate model is based on the hydraulic formulations presented in:
</p>
<ul>
<li><strong>[Bollrich2019]</strong>: Bollrich, G. and Preißler, G., \"Technische Hydromechanik 2\", Beuth Verlag, 2019</li>
</ul>
</html>", revisions=""));
end Gate;
