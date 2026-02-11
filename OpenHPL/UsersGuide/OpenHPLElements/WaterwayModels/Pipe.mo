within OpenHPL.UsersGuide.OpenHPLElements.WaterwayModels;
class Pipe "Simple Pipe Model"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<h4>Pipe</h4>
<p>
The simple model of the pipe unit gives possibilities for easy modelling of different conduits: intake 
race, penstock, tailrace, etc. The model assumes incompressible water and inelastic walls since there are 
only small pressure variations.
</p>

<p align=\"center\">
  <img src=\"modelica://OpenHPL/Resources/Images/pipe.svg\" alt=\"Pipe model\" width=\"500\"/>
</p>
<p><em>Figure: Model for flow through a pipe.</em></p>

<h5>Mass Balance</h5>
<p>
For incompressible water, the mass in the filled pipe is constant:
</p>
<p>
$$ \\frac{dm_\\mathrm{c}}{dt} = \\dot{m}_\\mathrm{c,in} - \\dot{m}_\\mathrm{c,out} = 0 $$
</p>

<h5>Momentum Balance</h5>
<p>
The momentum balance can be expressed as:
</p>
<p>
$$ \\frac{dM_\\mathrm{c}}{dt} = \\dot{M}_\\mathrm{c,in} - \\dot{M}_\\mathrm{c,out} + F_\\mathrm{p,c} + F_\\mathrm{g,c} + F_\\mathrm{f,c} $$
</p>
<p>
where:
</p>
<ul>
<li>M<sub>c</sub> = m<sub>c</sub> v<sub>c</sub> is the momentum</li>
<li>F<sub>p,c</sub> is the pressure force due to inlet/outlet pressure difference</li>
<li>F<sub>g,c</sub> = m<sub>c</sub> g cos θ<sub>c</sub> is the gravity force</li>
<li>F<sub>f,c</sub> is the friction force calculated using the Darcy friction factor</li>
</ul>

<h5>Features</h5>
<p>
The <code>Pipe</code> unit:
</p>
<ul>
<li>Uses the <code>ContactPort</code> connector model</li>
<li>Assumes flow rate changes simultaneously throughout the pipe</li>
<li>Supports positive and negative slopes</li>
<li>Can be initialized with initial flow rate or steady-state</li>
</ul>

<h5>Parameters</h5>
<p>
User specifies: length L<sub>c</sub>, height difference H<sub>c</sub>, inlet and outlet diameters, 
and pipe roughness height ε<sub>c</sub>.
</p>
</html>"));
end Pipe;
