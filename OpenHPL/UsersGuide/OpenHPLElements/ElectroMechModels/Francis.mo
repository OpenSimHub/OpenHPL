within OpenHPL.UsersGuide.OpenHPLElements.ElectroMechModels;
class Francis "Francis Turbine Model"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<h4>Francis Turbine</h4>
<p>
The library includes a mechanistic Francis turbine model based on the Euler turbine equations. The shaft 
power produced is:
</p>
<p>
$$ \\dot{W}_s = \\dot{m}\\omega \\left(R_1\\frac{\\dot{V}}{A_1}\\cot{\\alpha_1} - R_2\\left(\\omega R_2 + \\frac{\\dot{V}}{A_2}\\cot{\\beta_2}\\right)\\right) $$
</p>

<p align=\"center\">
  <img src=\"modelica://OpenHPL/Resources/Images/turbinefrancis.svg\" alt=\"Francis turbine\" width=\"500\"/>
</p>
<p><em>Figure: Key quantities in the Francis turbine model.</em></p>

<p>
where ṁ and V̇ are mass and volumetric flow rates, ω is angular velocity, R<sub>1</sub> and R<sub>2</sub> 
are inlet and outlet radii, A<sub>1</sub> and A<sub>2</sub> are cross-sectional areas, α<sub>1</sub> is 
inlet guide vane angle, and β<sub>2</sub> is outlet blade angle.
</p>

<h5>Total Work and Efficiency</h5>
<p>
The total work rate is:
</p>
<p>
$$ \\dot{W}_t = \\dot{W}_s + \\dot{W}_{ft} + \\Delta p_v \\dot{V} $$
</p>
<p>
where Ẇ<sub>ft</sub> represents various friction losses. Efficiency \\(\\eta = \\dot{W}_s / \\dot{W}_t\\).
</p>

<h5>Turbine Design Algorithm</h5>
<p>
A design algorithm is provided to calculate geometry parameters from nominal operating conditions 
(net head and flow rate). The algorithm determines: outlet blade angle β<sub>2</sub>, runner radii 
R<sub>1</sub> and R<sub>2</sub>, runner width w<sub>1</sub>, and inlet blade angle β<sub>1</sub>.
</p>

<h5>Guide Vane Actuation</h5>
<p>
A guide vane opening model relates actuator position Y to guide vane angle α<sub>1</sub> through geometric 
relationships.
</p>

<h5>Implementation</h5>
<p>
The <code>Francis</code> unit uses <code>TurbineContacts</code> and has a <code>RealInput</code> for 
angular velocity from the generator. User can use the design algorithm or specify geometry parameters 
manually.
</p>
</html>"));
end Francis;
