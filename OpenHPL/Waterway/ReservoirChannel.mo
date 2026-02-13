within OpenHPL.Waterway;
model ReservoirChannel "Reservoir model based on open channel model"
  extends Modelica.Icons.UnderConstruction;
  extends OpenHPL.Icons.Reservoir;
  outer Data data "Using standard data set";
  // reservoir segmentation
  parameter Integer N = 20 "Number of segments";
  // geometrical parameters of the reservoir
  parameter SI.Length W=1000 "Reservoir width";
  parameter SI.Length l=5000 "Reservoir length";
  parameter SI.Height H[2] = {2, 2} "Reservoir bed height from left and right side";
  // initialization
  parameter SI.Height h_0=50 "Initial water level of the reservoir";
  // condition of steady state
  parameter Boolean SteadyState=data.SteadyState "If true, starts in steady state";
  // variables
  Real q "Flow rate per width";
  // connector
  Interfaces.Contact_o o annotation (Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{68,-32},{134,34}})));
  // using the open channel example from the KP method class
  Internal.KPOpenChannel openChannel(
    N=N,
    W=W,
    H=H,
    h_0=ones(N)*h_0,
    boundaryValues=[h_0 + H[1],q; h_0 + H[2],q],
    boundaryCondition=[true,true; false,true],
    SteadyState=SteadyState) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  // boundaries
  o.mdot =-q*W*data.rho;
  o.p = data.p_a + data.rho * data.g * openChannel.h[N];
  annotation (
    Documentation(info="<html>
<h4>Reservoir Channel Model</h4>
<p>A more detailed reservoir model based on the open channel model, where the channel bed is assumed to be flat (no slope).</p>

<h5>Description</h5>
<p>This model extends the <a href=\"modelica://OpenHPL.Waterway.OpenChannel\">OpenChannel</a> functionality for reservoir applications.
The flatbed assumption simplifies the model for reservoir scenarios where bed slope effects are negligible.</p>

<h5>Parameters</h5>
<ul>
<li>Geometry: channel (reservoir) length L and width w</li>
<li>Height vector H of reservoir bed with equal heights from left and right sides (ensuring flat bed)</li>
<li>Number of discretization cells N</li>
<li>Initialization: initial water depth h₀ in the reservoir</li>
</ul>

<h5>Connectors</h5>
<p>Uses the <a href=\"modelica://OpenHPL.Interfaces.Contact\">Contact</a> connector providing outlet pressure and flow rate
information, which can be connected to other waterway units.</p>

<p><em>Note: Has not been tested properly.</em></p>
</html>"));
end ReservoirChannel;
