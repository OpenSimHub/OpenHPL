within OpenHPL.UsersGuide.OpenHPLElements.WaterwayModels;
class OpenChannel "Description of Open Channel unit"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4>Open Channel</h4>
<p>
Similarly to the detailed model of the pipe, the model of the open channel is also encoded in the library. The open channel
model looks as follows:
</p>
<p>
$$ \\frac{\\partial U}{\\partial t}+\\frac{\\partial F}{\\partial x} = S $$
</p>
<p>
where:
</p>
<ul>
<li>\\(U=\\left[\\begin{matrix}q & z\\end{matrix}\\right]^T\\)</li>
<li>\\(F=\\left[\\begin{matrix}q & \\frac{q^2}{z-B}+\\frac{g}{2}\\left(z-B\\right)^2\\end{matrix}\\right]^T\\)</li>
<li>\\(S=\\left[\\begin{matrix}0 & -g\\left(z-B\\right)\\frac{\\partial B}{\\partial x}-\\frac{gf_n^2q|q|\\left(w+2\\left(z-B\\right)\\right)^\\frac{4}{3}}{w^\\frac{4}{3}}\\frac{1}{\\left(z-B\\right)^\\frac{7}{3}}\\end{matrix}\\right]^T\\)</li>
</ul>
<p>
with: \\(z=h+B\\), and \\(q=\\frac{\\dot{V}}{w}\\). Here, h is water depth in the channel, B is the channel bed elevation,
q is the discharge per unit width w of the open channel. f<sub>n</sub> is the Manning's roughness coefficient.
</p>

<h5>Eigenvalues</h5>
<p>
The KP scheme is described earlier, but some additional specific details for open channels should be added here. First,
the eigenvalues for this model are defined as follows:
</p>
<p>
$$ \\lambda_{1,2}=u\\pm\\sqrt{gh} $$
</p>
<p>
where, u is the cross-section average water velocity.
</p>

<h5>Desingularization</h5>
<p>
In the channel areas which are dry or almost dry (if the computational domain contains a dry bed, islands or coastal areas),
the values of \\(h_{i\\pm\\frac{1}{2}}^\\pm\\) could be very small or even zero. In such cases when
\\(h_{i\\pm\\frac{1}{2}}^\\pm<\\epsilon\\), with ε being an a-priori chosen small positive number (e.g. ε = 1e⁻⁵),
the velocity at the cell centres in the entire domain is recomputed by the desingularization formula:
</p>
<p>
$$ \\bar{u}_j=\\frac{2\\bar{h}_j\\bar{q}_j}{\\bar{h}_j^2+\\max\\left(\\bar{h}_j^2,\\epsilon^2\\right)} $$
</p>
<p>
Then, the point values of the velocity \\(u_{i\\pm\\frac{1}{2}}^\\pm\\) at the left/right cell interfaces,
i.e., at \\(x_j = x_{j\\pm\\frac{1}{2}}\\) are computed using slope limiters.
</p>

<h5>Implementation</h5>
<p>
Similar to the <code>PenstockKP</code> unit, the function for the KP scheme <code>KPmethod</code> from function class
<code>KP07</code> is used in unit <code>OpenChannel</code> in order to discretize the presented PDEs into ODEs. The
values of states at the cell interfaces are taken from function <code>KPmethod</code> in the <code>OpenChannel</code>
unit in order to define the vectors of eigenvalues, the point values of the velocity, and the vector of fluxes. The
boundaries conditions are specified for the <code>KPmethod</code> function in the <code>OpenChannel</code> unit and
are the values for the inlet and outlet flows per unit width q₁ and q₂.
</p>

<h5>Connectors and Parameters</h5>
<p>
The <code>OpenChannel</code> unit uses the <code>TwoContact</code> connector model that gives information about inlet
and outlet pressure (water depth in the channel) and the flow rate of two connectors which can be connected to other
waterway units. In this <code>OpenChannel</code> unit, the user can specify the required geometry parameters for the:
length L and width w of the channel, height vector H of the channel bed with a height from the left and right sides,
the Manning's roughness coefficient f<sub>n</sub>, and the number of cells N for the discretization. This unit can be
initialized by the initial value of the flow rate \\(\\dot{V}_0\\) and water depth h₀ for each cell of the channel.
User can also change the boundary condition for the KP scheme.
</p>
</html>", revisions=""));
end OpenChannel;
