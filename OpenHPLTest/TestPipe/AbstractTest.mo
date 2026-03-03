within OpenHPLTest.TestPipe;
partial model AbstractTest
  extends Modelica.Icons.Example;
  //
  inner OpenHPL.Data data(Vdot_0 = 0.0, p_a = 0.0, p_eps = 0.0) annotation (
    Placement(transformation(origin = {-70, 70}, extent = {{-10, -10}, {10, 10}})));
  //
  parameter Modelica.Units.SI.Length Ln = 1000.;
  parameter Modelica.Units.SI.Length Dn = sqrt(A*4/Modelica.Constants.pi);
  Real error;
  OpenHPL.Waterway.Reservoir Upstream(h_0 = 100, constantLevel = true) annotation (
    Placement(transformation(origin = {-50, 30}, extent = {{-10, -10}, {10, 10}})));
  OpenHPL.Waterway.Reservoir Downstream(constantLevel = true, h_0 = 0) annotation (
    Placement(transformation(origin = {70, 10}, extent = {{10, -10}, {-10, 10}})));
protected
  constant Modelica.Units.SI.Area A = 0.1;
end AbstractTest;
