within OpenHPL.Tests.SummerProject2023;
model Model_II_SimPelGen "Simpel system with generator"
  inner OpenHPL.Data data(SteadyState = true, Vdot_0 = 1.2) annotation (
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe penstock(D_i = 0.7, H = 389.7, L = 2006.2) annotation (
    Placement(visible = true, transformation(origin = {-50, 30}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  OpenHPL.ElectroMech.Turbines.Turbine turbine(H_n = 380, Pmax = 3.9e6, ValveCapacity = false, Vdot_n = 1.2) annotation (
    Placement(visible = true, transformation(origin = {16, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Reservoir reservoir(L = 500000, W = 100000) annotation (
    Placement(visible = true, transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp(duration = 10, height = -0.5, offset = 1, startTime = 2) annotation (
    Placement(visible = true, transformation(origin = {-22, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Reservoir tail(h_0 = 1) annotation (
    Placement(visible = true, transformation(origin = {90, -10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  OpenHPL.ElectroMech.Generators.SimpleGen simpleGen annotation (
    Placement(visible = true, transformation(origin = {16, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 0)  annotation (
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch1 annotation (
    Placement(visible = true, transformation(origin = {46, 70}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const2(k = 4000000) annotation (
    Placement(visible = true, transformation(origin = {90, 22}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime = 40)  annotation (
    Placement(visible = true, transformation(origin = {90, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(penstock.o, turbine.i) annotation (
    Line(points = {{-40, 30}, {-24, 30}, {-24, 10}, {6, 10}}, color = {0, 128, 255}));
  connect(turbine.o, tail.o) annotation (
    Line(points = {{26, 10}, {53, 10}, {53, -10}, {80, -10}}, color = {0, 128, 255}));
  connect(reservoir.o, penstock.i) annotation (
    Line(points = {{-80, 30}, {-60, 30}}, color = {0, 128, 255}));
  connect(ramp.y, turbine.u_t) annotation (
    Line(points={{-11,70},{-4,70},{-4,34},{8,34},{8,22}},            color = {0, 0, 127}));
  connect(simpleGen.flange, turbine.flange) annotation (
    Line(points = {{16, 58}, {16, 10}}));
  connect(switch1.y, simpleGen.Pload) annotation (
    Line(points = {{35, 70}, {16, 70}}, color = {0, 0, 127}));
  connect(const.y, switch1.u1) annotation (
    Line(points = {{79, 90}, {64.5, 90}, {64.5, 78}, {58, 78}}, color = {0, 0, 127}));
  connect(const2.y, switch1.u3) annotation (
    Line(points={{79,22},{68,22},{68,62},{58,62}},          color = {0, 0, 127}));
  connect(booleanStep.y, switch1.u2) annotation (
    Line(points={{79,56},{72,56},{72,70},{58,70}},          color = {255, 0, 255}));
  annotation (
  Diagram(coordinateSystem(extent = {{-100, 100}, {100, -20}})));
end Model_II_SimPelGen;
