within OpenHPL.Functions;
package KP07 "Methods for KP07 scheme"
  extends Modelica.Icons.UtilitiesPackage;

  annotation (Documentation(info="<html>
<h4>KP Scheme</h4>
<p>
Functions for solving PDEs in Modelica are described here. The Kurganov-Petrova (KP) scheme is a 
wellbalanced second-order scheme, which is a Riemann problem solver free scheme (central scheme) while 
at the same time, it takes advantage of the upwind scheme by utilizing the local, one side speed of 
propagation during the calculation of the flux at the cell interfaces.
</p>

<h5>Mathematical Formulation</h5>
<p>
The central-upwind numerical scheme is presented for the one-dimensional case:
</p>
<p>
$$ \\frac{\\partial U(x,t)}{\\partial t} + \\frac{\\partial F(x,t,U)}{\\partial x} = S(x,t,U) $$
</p>
<p>
where U(x,t) is the state vector, F(x,t,U) is the vector of fluxes and S(x,t,U) is the source terms.
</p>

<p align=\"center\">
  <img src=\"modelica://OpenHPL/Resources/Images/kp.svg\" alt=\"Control volume\" width=\"500\"/>
</p>
<p><em>Figure: Control volume/cell for finite volume discretization.</em></p>

<h5>Discretization</h5>
<p>
With the finite volume method, we divide the grid into small control volumes/cells and then apply the 
conservation laws. The semi-discrete (time-dependent ODEs) central-upwind scheme can be written as:
</p>
<p>
$$ \\frac{d}{dt}\\bar{U}_j(t) = -\\frac{H_{j+\\frac{1}{2}}(t) - H_{j-\\frac{1}{2}}(t)}{\\Delta x} + \\bar{S}_j(t) $$
</p>
<p>
Here, Ū<sub>j</sub> are the cell centre average values, while H<sub>j±1/2</sub>(t) are the central 
upwind numerical fluxes at the cell interfaces. The numerical fluxes are calculated using the one-sided 
local speeds of propagation and the piecewise linearly reconstructed state values at cell interfaces.
</p>

<h5>Slope Limiter</h5>
<p>
The slope s<sub>j</sub> of the reconstructed function in each cell is computed using a limiter function 
to obtain a non-oscillatory nature of the reconstruction. The KP scheme utilizes the generalized 
<em>minmod</em> limiter. The parameter θ ∈ [1,2] is used to control or tune the amount of numerical 
dissipation present in the resulting scheme. The value of θ = 1.3 is an acceptable starting point 
in general.
</p>

<p align=\"center\">
  <img src=\"modelica://OpenHPL/Resources/Images/ghosts.svg\" alt=\"Ghost cells\" width=\"500\"/>
</p>
<p><em>Figure: Ghost cells at the grid boundaries.</em></p>

<h5>Ghost Cells</h5>
<p>
For boundary cells, imaginary cells called ghost cells are used outside the physical boundary. The 
average value of the conserved variables at the centre of these ghost cells depends on the nature of 
the physical boundary taken into account.
</p>

<h5>Implementation in OpenHPL</h5>
<p>
Functions for each element of the KP scheme are implemented in the <code>KP07</code> package:
</p>
<ul>
<li><code>GhostCells</code> &mdash; provides values at ghost cells</li>
<li><code>SlopeVectorS</code> &mdash; returns the slope vector using the minmod limiter</li>
<li><code>PieceWiseU</code> &mdash; defines state values at cell interfaces</li>
<li><code>SpeedPropagationApipe</code> &mdash; provides one-sided local speeds of propagation</li>
<li><code>FluxesH</code> &mdash; defines central upwind numerical fluxes</li>
<li><code>KPmethod</code> &mdash; primary function that assembles all components</li>
</ul>

<p>
Note: Due to simulation speed considerations, these functions are implemented as <code>model</code> type 
instead of <code>function</code> type in OpenModelica.
</p>

<p>
Examples of using the KP scheme for solving PDEs are provided in class <code>KP07</code>. More information 
about using the <code>KPmethod</code> function is presented in the waterway modelling section for the 
<code>PenstockKP</code> and <code>OpenChannel</code> units.
</p>
</html>"));
end KP07;
