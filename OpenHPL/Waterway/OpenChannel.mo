within OpenHPL.Waterway;
model OpenChannel "Open channel model (use KP scheme)"
  extends Modelica.Icons.UnderConstruction;
  outer Data data "Using standard data set";
  extends OpenHPL.Icons.OpenChannel;
  //// geometrical parameters of the open channel
  parameter Integer N = 100 "Number of segments" annotation (Dialog(group = "Geometry"));
  parameter SI.Length W=180 "Channel width"                 annotation (Dialog(group="Geometry"));
  parameter SI.Length L = 5000 "Channel length" annotation (Dialog(group = "Geometry"));
  parameter SI.Height H[2] = {17.5, 0} "Channel bed geometry, height from the left and right sides" annotation (Dialog(group = "Geometry"));
  parameter Real f_n = 0.04 "Manning's roughness coefficient [s/m^1/3]" annotation (Dialog(group = "Geometry"));
  parameter Boolean SteadyState=data.SteadyState "If true, starts in steady state" annotation (Dialog(group="Initialization"));
  parameter SI.Height h_0[N]=ones(N)*5 "Initial water level"          annotation (Dialog(group="Initialization"));
  parameter SI.VolumeFlowRate Vdot_0=data.Vdot_0 "Initial flow rate" annotation (Dialog(group="Initialization"));
  parameter Boolean BoundaryCondition[2,2] = [false, true; false, true] "Boundary conditions. Choose options for the boundaries in a matrix table, i.e., if the matrix element = true, this element is used as boundary. The element represent the following quantities: [inlet depth, inlet flow; outlet depth, outlet flow]" annotation (Dialog(group = "Boundary condition"));
  //// variables
  SI.VolumeFlowRate Vdot_o "Outlet flow";
  SI.VolumeFlowRate Vdot_i "Inlet flow rate";
  SI.Height h[N] "Water level in each unit of the channel";
  //// connector
  extends OpenHPL.Interfaces.TwoContact;
  //// using open channel example from KP method class
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
//// define a vector of the water depth in the channel
  h = openChannel.h;
//// flow rate boundaries
  i.mdot =Vdot_i*data.rho;
  o.mdot =-Vdot_o*data.rho;
//// presurre boundaries
  i.p = h[1] * data.g * data.rho + data.p_a;
  o.p = h[N] * data.g * data.rho + data.p_a;
  annotation (
    Documentation(info="<html>
<p style=\"color: #ff0000;\"><em>Note: Currently under investigation for plausibility.</em></p>
<p>This is a model for the open channel (river). Could be used for modelling of run-of-river hydropower plants. </p>
<p>In this model it is assumed that the channel has the inlet and outlet from the bottom of the left and right sides, respectevely. </p>
<p>That is why this open channel should be connected from both sides to the <a href=\"modelica://OpenHPL.Waterway.Pipe\">Pipe</a> elements. Connectors hold information about the inlet/outlet flow rate and the pressures that is defined as sum of atmospheric pressure and pressure of the water (depends on depth). </p>
<p>As boundary conditions, at least two of the four quentities (inlet flow or depth and outlet flow or depth) should be used. </p>
<p>Perhaps, this structure is not really useful and some modification should be done. This is still under discussion and has not been tested properly. </p>
<p>More info about the original model can be found in <a href=\"modelica://OpenHPL.UsersGuide.References\">[Vytvytskyi2015]</a>.</p>
</html>"));
end OpenChannel;
