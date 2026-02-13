within OpenHPL.Functions;
package DarcyFriction "Functions to define the Darcy friction factor and friction Force"
  extends Modelica.Icons.UtilitiesPackage;

  annotation (
    Documentation(info = "<html>
<h4>Friction Term</h4>
<p>
First, the functions for defining the friction force in the waterway are described. The friction force 
F<sub>f</sub> is directed in the opposite direction of the velocity v (the linear velocity average across 
the cross-section of the pipe) of the fluid. A common expression for friction force in the filled pipes 
is the following:
</p>
<p>
$$ F_\\mathrm{f} = -\\frac{1}{8}\\pi\\rho LDf_\\mathrm{D}v|v| $$
</p>
<p>
Here, L and D are related to the pipe length and diameter, respectively. f<sub>D</sub> is a Darcy friction 
factor that is a function of Reynolds number N<sub>Re</sub>, with the roughness ratio ε/D as a parameter.
</p>

<p align=\"center\">
  <img src=\"modelica://OpenHPL/Resources/Images/darcyf.svg\" alt=\"Darcy friction factor\" width=\"600\"/>
</p>
<p><em>Figure: Darcy friction factor as a function of the Reynolds number.</em></p>

<h5>Flow Regimes</h5>
<p>
The turbulent region (N<sub>Re</sub> &gt; 2.3×10³) is a flow regime where the velocity across the pipe has 
a stochastic nature, and where the velocity v is relatively uniform across the pipe when we average the 
velocity over some short period of time. The laminar region (N<sub>Re</sub> &lt; 2.1×10³) is a flow regime 
with a regular velocity v which varies as a parabola with the radius of the pipe, with zero velocity at the 
pipe wall and maximal velocity at the centre of the pipe.
</p>

<h5>Laminar Flow</h5>
<p>
Darcy friction factor varies with the roughness of the pipe surface, specified by roughness height ε. For 
laminar flow in a cylindrical pipe (N<sub>Re</sub> &lt; 2.1×10³), the Darcy friction factor f<sub>D</sub> 
can be found using the following expression:
</p>
<p>
$$ f_\\mathrm{D} = \\frac{64}{N_\\mathrm{Re}} $$
</p>
<p>
Here, the Reynolds number is found as follows: \\(N_\\mathrm{Re}=\\frac{\\rho|v|D}{\\mu}\\), where μ is the fluid viscosity.
</p>

<h5>Turbulent Flow</h5>
<p>
For turbulent flow (N<sub>Re</sub> &gt; 2.3×10³), the Darcy friction factor is expressed as:
</p>
<p>
$$ f_\\mathrm{D} = \\frac{1}{\\left(2\\log_{10}\\left(\\frac{\\epsilon}{3.7D} + \\frac{5.74}{N_\\mathrm{Re}^{0.9}}\\right)\\right)^2} $$
</p>

<h5>Transition Zone</h5>
<p>
In order to define the Darcy friction factor in a region between laminar and turbulent flow regimes, a 
cubic polynomial interpolation is used between the laminar value at N<sub>Re</sub>=2100 and the turbulent 
value at N<sub>Re</sub>=2300, with matching slopes at both endpoints to achieve global differentiability.
</p>

<h5>Implementation</h5>
<p>
Based on the presented equations for calculation of the friction force in the waterway, two functions are 
encoded in class <code>DarcyFriction</code>:
</p>
<ol>
<li><code>fDarcy</code> &mdash; calculates the Darcy friction factor. This function has the following inputs: 
Reynolds number N<sub>Re</sub>, pipe diameter D, and pipe roughness height ε. Returns the friction factor 
f<sub>D</sub>.</li>
<li><code>Friction</code> &mdash; calculates the actual friction force based on the response from the 
<code>fDarcy</code> function. This function has the following inputs: linear velocity v, pipe length and 
diameter L and D, liquid density and viscosity ρ and μ, and pipe roughness height ε. Returns friction force 
F<sub>f</sub>.</li>
</ol>

<h5>Example Code</h5>
<p>
An example of a Modelica code for defining the <code>Friction</code> function:
</p>
<pre>
function Friction \"Friction force with Darcy friction factor\"
  import Modelica.Constants.pi;
  input Modelica.SIunits.Velocity v \"Flow velocity\";
  input Modelica.SIunits.Diameter D \"Pipe diameter\";
  input Modelica.SIunits.Length L \"Pipe length\";
  input Modelica.SIunits.Density rho \"Density\";
  input Modelica.SIunits.DynamicViscosity mu \"Dynamic viscosity of water\";
  input Modelica.SIunits.Height eps \"Pipe roughness height\";
  output Modelica.SIunits.Force F_f \"Friction force\";
protected
  Modelica.SIunits.ReynoldsNumber N_Re \"Reynolds number\";
  Real f \"friction factor\";
algorithm
  N_Re:= rho * abs(v) * D / mu;
  f := fDarcy(N_Re, D, eps);
  F_f := 0.5 * pi * f * rho * L * v * abs(v) * D / 4;
end Friction;
</pre>
</html>"));
end DarcyFriction;
