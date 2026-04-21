within OpenHPLTest.EmpiricalTurbine.TurbineTest;
model Test04_Turbine
   extends Modelica.Icons.Example;
   inner OpenHPL.Data data annotation (
    Placement(transformation(origin = {-84, 82}, extent = {{-10, -10}, {10, 10}})));
    parameter Modelica.Units.SI.Height Hn=600;
    parameter Real opening=0.2;
  //
  OpenHPL.Waterway.Reservoir overvann(h_0 = Hn, constantLevel = true) annotation (
    Placement(transformation(origin = {-82, 12}, extent = {{-10, -10}, {10, 10}})));
  OpenHPL.Waterway.Reservoir undervann(h_0 = 0.0, constantLevel = true) annotation (
    Placement(transformation(origin = {72, -16}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  OpenHPL.ElectroMech.Turbines.EmpiricalTurbine turbine( H_n = Hn, P_n = 1e7, p = 18,enable_nomSpeed = false, enable_f = true, f_0 = 0, useH = false, J = 2e3 ) annotation (
    Placement(transformation(origin = {12, 12}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant const(k = opening)  annotation(
    Placement(transformation(origin = {-18, 68}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(turbine.o, undervann.o) annotation(
    Line(points = {{22, 12}, {28, 12}, {28, -16}, {62, -16}}, color = {0, 128, 255}));
  connect(overvann.o, turbine.i) annotation(
    Line(points = {{-72, 12}, {2, 12}}, color = {0, 128, 255}));
  connect(const.y, turbine.u_t) annotation(
    Line(points = {{-6, 68}, {4, 68}, {4, 24}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 25, Tolerance = 1e-06, Interval = 0.001),
  Icon(graphics = {Text(extent = {{-150, 90}, {150, -90}}, textString = "%name")}));
end Test04_Turbine;
