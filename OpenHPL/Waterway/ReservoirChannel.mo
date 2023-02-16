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
    Documentation(info="<html><p>This is a model for the reservoir, based on the open channel (river) model.</p>
<p><em>Has not been tested properly.</em></p>
</html>"));
end ReservoirChannel;
