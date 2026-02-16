within OpenHPL.Waterway;
model OpenChannel "Open channel model (use KP scheme)"
  extends Modelica.Icons.UnderConstruction;
  outer Data data "Using standard data set";
  extends OpenHPL.Icons.OpenChannel;
  // geometrical parameters of the open channel
  parameter Integer N = 100 "Number of segments" annotation (Dialog(group = "Geometry"));
  parameter SI.Length W=180 "Channel width" annotation (Dialog(group="Geometry"));
  parameter SI.Length L = 5000 "Channel length" annotation (Dialog(group = "Geometry"));
  parameter SI.Height H[2] = {17.5, 0} "Channel bed geometry, height from the left and right sides" annotation (Dialog(group = "Geometry"));
  parameter Real f_n = 0.04 "Manning's roughness coefficient [s/m^1/3]" annotation (Dialog(group = "Geometry"));
  parameter Boolean SteadyState=data.SteadyState "If true, starts in steady state" annotation (Dialog(group="Initialization"));
  parameter SI.Height h_0[N]=ones(N)*5 "Initial water level" annotation (Dialog(group="Initialization"));
  parameter SI.VolumeFlowRate Vdot_0=data.Vdot_0 "Initial flow rate" annotation (Dialog(group="Initialization"));
  parameter Boolean BoundaryCondition[2,2] = [false, true; false, true] "Boundary conditions. Choose options for the boundaries in a matrix table, i.e., if the matrix element = true, this element is used as boundary. The element represent the following quantities: [inlet depth, inlet flow; outlet depth, outlet flow]" annotation (Dialog(group = "Boundary condition"));
  // variables
  SI.VolumeFlowRate Vdot_o "Outlet flow";
  SI.VolumeFlowRate Vdot_i "Inlet flow rate";
  SI.Height h[N] "Water level in each unit of the channel";
  // connector
  extends OpenHPL.Interfaces.TwoContacts;
  // using open channel example from KP method class
  Internal.KPOpenChannel openChannel(
    N=N,
    W=W,
    L=L,
    Vdot_0=Vdot_0,
    f_n=f_n,
    h_0=h_0,
    boundaryValues=[h_0[1] + H[1],Vdot_i/W; h_0[N] + H[2],Vdot_o/W],
    boundaryCondition=BoundaryCondition,
    SteadyState=SteadyState) annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
equation
// define a vector of the water depth in the channel
  h = openChannel.h;
// flow rate boundaries
  i.mdot =Vdot_i*data.rho;
  o.mdot =-Vdot_o*data.rho;
// presurre boundaries
  i.p = h[1] * data.g * data.rho + data.p_a;
  o.p = h[N] * data.g * data.rho + data.p_a;
  annotation (preferredView="info",
    Documentation(info="<html>
<p style=\"color: #ff0000;\"><em>Note: Currently under investigation for plausibility.</em></p>

<h4>Open Channel Model</h4>
<p>Model for open channels (rivers) that can be used for modeling run-of-river hydropower plants.
The channel inlet and outlet are assumed to be at the bottom of the left and right sides, respectively.</p>

<h5>Governing Equations</h5>
<p>The open channel model is based on the following partial differential equation:</p>
<p>$$ \\frac{\\partial U}{\\partial t}+\\frac{\\partial F}{\\partial x} = S $$</p>
<p>where:</p>
<ul>
<li>\\(U=\\left[\\begin{matrix}q & z\\end{matrix}\\right]^T\\)</li>
<li>\\(F=\\left[\\begin{matrix}q & \\frac{q^2}{z-B}+\\frac{g}{2}\\left(z-B\\right)^2\\end{matrix}\\right]^T\\)</li>
<li>\\(S=\\left[\\begin{matrix}0 & -g\\left(z-B\\right)\\frac{\\partial B}{\\partial x}-\\frac{gf_n^2q|q|\\left(w+2\\left(z-B\\right)\\right)^\\frac{4}{3}}{w^\\frac{4}{3}}\\frac{1}{\\left(z-B\\right)^\\frac{7}{3}}\\end{matrix}\\right]^T\\)</li>
</ul>
<p>with: \\(z=h+B\\), and \\(q=\\frac{\\dot{V}}{w}\\). Here, h is water depth in the channel, B is the channel bed elevation,
q is the discharge per unit width w of the open channel. f<sub>n</sub> is the Manning's roughness coefficient.</p>

<h5>Eigenvalues</h5>
<p>The eigenvalues for this model are defined as:</p>
<p>$$ \\lambda_{1,2}=u\\pm\\sqrt{gh} $$</p>
<p>where u is the cross-section average water velocity.</p>

<h5>Desingularization</h5>
<p>In dry or nearly dry channel areas, velocity at cell centers is recomputed using the desingularization formula:</p>
<p>$$ \\bar{u}_j=\\frac{2\\bar{h}_j\\bar{q}_j}{\\bar{h}_j^2+\\max\\left(\\bar{h}_j^2,\\epsilon^2\\right)} $$</p>
<p>applied when \\(h_{i\\pm\\frac{1}{2}}^\\pm<\\epsilon\\) (typically ε = 1e⁻⁵).</p>

<h5>Implementation</h5>
<p>Similar to <a href=\"modelica://OpenHPL.Waterway.PenstockKP\">PenstockKP</a>, this model uses the KP method
(<a href=\"modelica://OpenHPL.Functions.KP07.KPmethod\">KPmethod</a> function) to discretize the PDEs into ODEs.</p>

<p>Boundary conditions specify inlet and outlet flows per unit width q₁ and q₂.
Connectors should be connected to <a href=\"modelica://OpenHPL.Waterway.Pipe\">Pipe</a> elements from both sides.
Connectors provide inlet/outlet flow rates and pressures (sum of atmospheric pressure and water depth-dependent pressure).</p>

<h5>Parameters</h5>
<ul>
<li>Geometry: channel length L and width w, bed height vector H at left/right sides</li>
<li>Manning's roughness coefficient f<sub>n</sub></li>
<li>Number of discretization cells N</li>
<li>Initialization: initial flow rate \\(\\dot{V}_0\\) and water depth h₀ for each cell</li>
</ul>

<p><em>Note: This model is still under discussion and has not been tested properly.</em></p>
<p>More details in <a href=\"modelica://OpenHPL.UsersGuide.References\">[Vytvytskyi2015]</a>.</p>
</html>"));
end OpenChannel;
