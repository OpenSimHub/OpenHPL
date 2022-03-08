within OpenHPL.Waterway;
model ReservoirChannel "Reservoir model based on open channel model"
  extends OpenHPL.Icons.Reservoir;
  outer Data data "Using standard data set";
  //// reservoir segmentation
  parameter Integer N = 20 "Number of segments";
  //// geometrical parameters of the reservoir
  parameter Modelica.SIunits.Length w = 1000 "Reservoir width";
  parameter SI.Length l=5000 "Reservoir length";
  parameter Modelica.SIunits.Height H[2] = {2, 2} "Reservoir bed height from left and right side";
  //// initialization
  parameter SI.Height H_0=50 "Initial depth of the reservoir";
  //// condition of steady state
  parameter Boolean SteadyState = data.Steady "if true - starts from Steady State";
  //// variables
  Real q "flow rate";
  //// connector
  Interfaces.Contact_o       o annotation (Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{68,-32},{134,34}})));
  //// using the open channel example from the KP method class
  Internal.KPOpenChannel openChannel(
    N=N,
    w=w,
    H=H,
    h0=ones(N)*H_0,
    boundaryValues=[H_0 + H[1],q; H_0 + H[2],q],
    boundaryCondition=[true,true; false,true],
    SteadyState=SteadyState) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  //// boundaries
  o.mdot = -q * w * data.rho;
  o.p = data.p_a + data.rho * data.g * openChannel.h[N];
  annotation (
    Documentation(info="<html><p>This is a model for the reservoir, based on the open channel (river) model.</p>
<p><em>Has not been tested properly.</em></p>
</html>"));
end ReservoirChannel;
