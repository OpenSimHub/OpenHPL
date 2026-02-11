within OpenHPL.UsersGuide.OpenHPLElements.WaterwayModels;
class PenstockKP "Elastic Penstock with KP Method"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<h4>Pipe with Compressible Water and Elastic Walls</h4>

<blockquote style=\"background-color: #ffffcc; border-left: 4px solid #ffcc00; padding: 10px; margin: 10px 0;\">
<strong>Note on Model Evolution:</strong> The older <code>Penstock</code> model using the Staggered Grid scheme 
is now marked as obsolete and should not be used for new models. The <code>PenstockKP</code> model documented 
here, which implements the more accurate and numerically stable KP (Kurganov-Petrova) method, is the recommended 
choice for all elastic penstock modeling. Existing models using <code>Penstock</code> should be migrated to 
<code>PenstockKP</code> for improved accuracy and reliability.
</blockquote>

<p>
Unlike simple conduits, the penstock has considerable pressure variation due to considerable height drop. 
To make the model more realistic, compressible water and elastic walls are taken into account using 
compressibility coefficients.
</p>

<h5>Compressibility</h5>
<p>
The isothermal compressibility β<sub>T</sub> relates density and pressure:
</p>
<p>
$$ \\rho \\approx \\rho^\\mathrm{atm}(1 + \\beta_T(p - p^\\mathrm{atm})) $$
</p>
<p>
Similarly for pipe cross-section area due to elastic walls:
</p>
<p>
$$ A \\approx A^\\mathrm{atm}(1 + \\beta^\\mathrm{eq}(p - p^\\mathrm{atm})) $$
</p>
<p>
The total compressibility β<sup>tot</sup> = β<sub>T</sub> + β<sup>eq</sup> is related to speed of sound 
in water inside the pipe.
</p>

<h5>PDE Formulation</h5>
<p>
Using these relationships, the ODEs for mass and momentum balances develop into PDEs. The KP scheme is 
used for discretization:
</p>
<p>
$$ \\frac{\\partial U}{\\partial t} + \\frac{\\partial F}{\\partial x} = S $$
</p>
<p>
where \\(U = [p_\\mathrm{p}, \\dot{m}_\\mathrm{p}]^T\\) is the state vector.
</p>

<p align=\"center\">
  <img src=\"modelica://OpenHPL/Resources/Images/penstock.png\" alt=\"Penstock discretization\" width=\"600\"/>
</p>

<h5>Implementation</h5>
<p>
The <code>PenstockKP</code> unit uses the <code>KPmethod</code> function from <code>KP07</code> to 
discretize PDEs into ODEs. The eigenvalues λ<sub>1,2</sub> = (v<sub>p</sub> ± √(v<sub>p</sub>² + 
4A<sub>p</sub>/(A<sub>p</sub><sup>atm</sup> ρ<sup>atm</sup> β<sup>tot</sup>))) / 2 determine the 
speed of sound c = √(A<sub>p</sub>/(A<sub>p</sub><sup>atm</sup> ρ<sup>atm</sup> β<sup>tot</sup>)).
</p>

<h5>Parameters</h5>
<p>
User specifies: length, height difference, diameters, roughness, and number of cells N for discretization. 
Initialization can be done with flow rate and pressure values, or from steady-state.
</p>
</html>"));
end PenstockKP;
