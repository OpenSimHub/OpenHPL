within OpenHPL.UsersGuide.OpenHPLElements.WaterwayModels;
class BendPipe "Description of Bend Pipe unit"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4>Pipe Bends</h4>
<p>
The <em>BendPipe</em> unit models the head loss that occurs when water flows through a bend or elbow in a piping system. 
Pipe bends are common in hydropower installations where the conduit path must change direction, and the associated 
energy losses can be significant, especially at high flow velocities.
</p>

<h5>Loss Mechanism</h5>
<p>
Flow through a bend creates secondary flows and flow separation, resulting in minor head losses. These losses are 
typically expressed using a loss coefficient \\(K_L\\):
</p>
<p>
$$ \\Delta p = K_L \\cdot \\frac{1}{2} \\rho v^2 $$
</p>
<p>
where:
</p>
<ul>
<li>\\(\\Delta p\\): Pressure drop across the bend [Pa]</li>
<li>\\(K_L\\): Loss coefficient (dimensionless) [-]</li>
<li>\\(\\rho\\): Water density [kg/m³]</li>
<li>\\(v\\): Flow velocity [m/s]</li>
</ul>

<h5>Loss Coefficient</h5>
<p>
The loss coefficient \\(K_L\\) depends on several factors:
</p>
<ul>
<li>Bend angle (45°, 90°, etc.)</li>
<li>Bend radius ratio (\\(r/D\\), where \\(r\\) is bend radius and \\(D\\) is pipe diameter)</li>
<li>Flow Reynolds number</li>
<li>Bend type (flanged, threaded, mitered)</li>
<li>Surface roughness</li>
</ul>

<h5>Typical Loss Coefficient Values</h5>
<p>
The model documentation includes reference values from standard fluid mechanics literature:
</p>
<table border=\"1\" cellpadding=\"5\" cellspacing=\"0\">
<tr><th>Fitting Type</th><th>Typical \\(K_L\\)</th></tr>
<tr><td>90° flanged elbow (r/D = 1)</td><td>0.3</td></tr>
<tr><td>90° threaded elbow</td><td>1.5</td></tr>
<tr><td>90° mitered elbow</td><td>1.1</td></tr>
<tr><td>45° flanged elbow</td><td>0.2</td></tr>
<tr><td>180° return bend</td><td>2.2</td></tr>
</table>
<p>
Note: Values may vary based on manufacturer specifications and installation conditions. Users should utilize manufacturer 
data when available.
</p>

<h5>Model Parameters</h5>
<ul>
<li>\\(K_L\\): Loss coefficient (user-specified or from manufacturer) [-]</li>
<li>\\(D_i\\): Inlet pipe diameter [m]</li>
<li>\\(D_o\\): Outlet pipe diameter [m] (typically equal to \\(D_i\\) for bends)</li>
</ul>

<h5>Applications</h5>
<p>
Accurate modeling of bend losses is important for:
</p>
<ul>
<li>Detailed hydraulic system analysis</li>
<li>Pressure profile calculations along complex conduit layouts</li>
<li>Optimization of piping layouts to minimize losses</li>
<li>Validation against field measurements</li>
<li>Economic analysis of different routing options</li>
</ul>

<h5>Implementation Notes</h5>
<p>
The <em>BendPipe</em> model is similar to the general <em>Fitting</em> model but is specifically tailored for 
pipe bends with appropriate default values and documentation. It simplifies the setup when modeling systems 
with multiple directional changes.
</p>
</html>", revisions=""));
end BendPipe;
