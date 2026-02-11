within OpenHPL.UsersGuide.OpenHPLElements.WaterwayModels;
class Valve "Description of Valve unit"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4>Hydraulic Valve</h4>
<p>
The <em>Valve</em> unit provides a simple model of a hydraulic valve for controlling water flow in hydropower systems. 
The model is based on energy balance principles and can represent various types of control valves such as butterfly 
valves, spherical valves, or needle valves.
</p>

<h5>Model Formulation</h5>
<p>
The valve model uses a valve-like flow expression relating flow rate to pressure drop:
</p>
<p>
$$ \\dot{V} = C_v \\cdot u \\cdot \\sqrt{\\frac{2\\Delta p}{\\rho}} $$
</p>
<p>
where:
</p> 
<ul>
<li>\\(\\dot{V}\\): Volume flow rate [m³/s]</li>
<li>\\(C_v\\): Valve capacity coefficient [m²]</li>
<li>\\(u\\): Valve opening signal (0 = closed, 1 = fully open) [-]</li>
<li>\\(\\Delta p\\): Pressure drop across the valve [Pa]</li>
<li>\\(\\rho\\): Water density [kg/m³]</li>
</ul>

<h5>Valve Capacity</h5>
<p>
The valve capacity \\(C_v\\) can be specified in two ways:
</p>
<ol>
<li><strong>Direct specification</strong>: User provides \\(C_v\\) directly from manufacturer data</li>
<li><strong>Calculated from nominal conditions</strong>: \\(C_v\\) is computed from nominal head \\(H_n\\) and nominal flow rate \\(\\dot{V}_n\\)</li>
</ol>

<h5>Efficiency</h5>
<p>
The valve model can account for energy losses through an efficiency parameter \\(\\eta\\):
</p>
<ul>
<li><strong>Constant efficiency</strong>: Single value (0 to 1)</li>
<li><strong>Variable efficiency</strong>: Look-up table based on valve opening</li>
</ul>
<p>
The valve power loss is calculated as:
</p>
<p>
$$ \\dot{W}_{loss} = \\dot{V} \\cdot \\Delta p \\cdot (1 - \\eta) $$
</p>

<h5>Control Interface</h5>
<p>
The valve has a <code>RealInput</code> connector called <code>opening</code> that accepts control signals:
</p>
<ul>
<li><code>opening = 0</code>: Valve completely closed</li>
<li><code>opening = 1</code>: Valve fully open</li>
<li>Intermediate values: Partial opening</li>
</ul>

<h5>Applications</h5>
<p>
The valve model is useful for:
</p>
<ul>
<li>Emergency shutdown scenarios</li>
<li>Flow regulation and control studies</li>
<li>Load rejection analysis</li>
<li>Testing different valve closing strategies to minimize water hammer</li>
<li>Bypass systems in hydropower plants</li>
</ul>

<h5>Parameters</h5>
<p>
Key parameters for the valve model:
</p>
<ul>
<li>\\(C_v\\): Valve capacity coefficient [m²]</li>
<li>\\(H_n\\): Nominal head [m] (if \\(C_v\\) is calculated)</li>
<li>\\(\\dot{V}_n\\): Nominal flow rate [m³/s] (if \\(C_v\\) is calculated)</li>
<li>\\(\\eta\\): Valve efficiency [-] or efficiency table</li>
</ul>
</html>", revisions=""));
end Valve;
