within OpenHPL.Functions;
package Fitting "Functions for pipe fitting"
  extends Modelica.Icons.UtilitiesPackage;

 annotation (preferredView="info", Documentation(info="<html>
<h4>Fitting</h4>
<p>
The functions for defining the pressure drop in various pipe fittings are described here. Due to different
constrictions in the pipes, it is of interest to define losses in these fittings. This can be done based
on friction pressure drop which can be calculated as:
</p>
<p>
$$ \\Delta p_\\mathrm{f} = \\frac{1}{2}\\varphi\\rho v|v| $$
</p>
<p>
Here, the dimensionless factor φ is the generalized friction factor. For a long, straight pipe,
φ = f<sub>D</sub> L/D.
</p>

<h5>Types of Fittings</h5>
<p>
Pressure drop equations are provided for different types of constrictions:
</p>

<h5>Square Reduction/Expansion Fittings</h5>
<p align=\"center\">
  <img src=\"modelica://OpenHPL/Resources/Images/SquaredReduction.svg\" alt=\"Square reduction\" width=\"300\"/>
  <img src=\"modelica://OpenHPL/Resources/Images/SquaredExpansion.svg\" alt=\"Square expansion\" width=\"300\"/>
</p>

<h5>Tapered Reduction/Expansion Fittings</h5>
<p align=\"center\">
  <img src=\"modelica://OpenHPL/Resources/Images/TaperedReduction.svg\" alt=\"Tapered reduction\" width=\"300\"/>
  <img src=\"modelica://OpenHPL/Resources/Images/TaperedExpansion.svg\" alt=\"Tapered expansion\" width=\"300\"/>
</p>

<h5>Rounded Reduction/Expansion Fittings</h5>
<p align=\"center\">
  <img src=\"modelica://OpenHPL/Resources/Images/RoundedReduction.svg\" alt=\"Rounded reduction\" width=\"300\"/>
  <img src=\"modelica://OpenHPL/Resources/Images/RoundedExpansion.svg\" alt=\"Rounded expansion\" width=\"300\"/>
</p>

<h5>Sharp/Thick Orifice Fittings</h5>
<p align=\"center\">
  <img src=\"modelica://OpenHPL/Resources/Images/OrificeSharp.svg\" alt=\"Sharp orifice\" width=\"300\"/>
  <img src=\"modelica://OpenHPL/Resources/Images/OrificeThick.svg\" alt=\"Thick orifice\" width=\"300\"/>
</p>

<h5>Implementation</h5>
<p>
Based on the presented equations for the calculation of the dimensionless factor φ in various fittings,
a set of functions is encoded in the <code>Fitting</code> package, such as:
</p>
<ul>
<li><code>SquareReduction</code></li>
<li><code>SquareExpansion</code></li>
<li><code>TaperedReduction</code></li>
<li><code>TaperedExpansion</code></li>
<li><code>RoundedReduction</code></li>
<li><code>SharpOrifice</code></li>
<li><code>ThickOrifice</code></li>
</ul>

<p>
All these functions receive the Reynolds number N<sub>Re</sub>, diameters of first and second pipes
D<sub>1</sub> and D<sub>2</sub>, and the pipe roughness height ε. Then, based on the appropriate
equations, these functions provide value for the dimensionless factor φ.
</p>

<h5>Example Code</h5>
<p>
An example of Modelica code for the <code>SquareReduction</code> function:
</p>
<pre>
function SquareReduction
  input Modelica.SIunits.ReynoldsNumber N_Re \"Reynolds number\";
  input Modelica.SIunits.Height eps \"Pipe roughness height\";
  input Modelica.SIunits.Diameter D_i, D_o \"Pipe diameters\";
  output Real phi;
protected
  Real f_D \"friction factor\";
algorithm
  f_D := Functions.DarcyFriction.fDarcy(N_Re, D_1, eps);
  if N_Re &lt; 2500 then
    phi := (1.2 + 160 / N_Re) * ((D_i / D_o) ^ 4 - 1);
  else
    phi := (0.6 + 0.48 * f_D) * (D_i / D_o) ^ 2 * ((D_i / D_o) ^ 2 - 1);
  end if;
end SquareReduction;
</pre>

<p>
Another function, <code>FittingPhi</code>, calls the specific fitting functions based on a
<code>FittingType</code> parameter to provide the dimensionless factor φ for any fitting type.
</p>
</html>"));
end Fitting;
