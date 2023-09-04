within OpenHPL.Tests.SummerProject2023;
model Model_I_SimPel "Simpel system w/o generator"
  OpenHPL.Waterway.Reservoir tail(h_0 = 1) annotation (
    Placement(visible = true, transformation(origin = {90, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Reservoir reservoir(L = 500000, W = 100000) annotation (
    Placement(visible = true, transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe penstock(D_i = 0.7, H = 389.7, L = 2006.2) annotation (
    Placement(visible = true, transformation(origin = {-30, 30}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  inner OpenHPL.Data data(SteadyState = true, Vdot_0 = 1.2) annotation (
    Placement(visible = true, transformation(origin = {-90, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1) annotation (
    Placement(visible = true, transformation(origin = {-26, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.ElectroMech.Turbines.Turbine turbine(H_n = 380, Pmax = 3.9e6, ValveCapacity = false, Vdot_n = 1.2) annotation (
    Placement(visible = true, transformation(origin = {40, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp(duration = 32, height = -0.99999, offset = 1, startTime = 2) annotation (
    Placement(visible = true, transformation(origin = {-2, 80}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(reservoir.o, penstock.i) annotation (
    Line(points = {{-80, 30}, {-40, 30}}, color = {0, 128, 255}));
  connect(const.y, turbine.w_in) annotation (
    Line(points = {{-15, 52}, {-8.75, 52}, {-8.75, 20}, {-8.5, 20}, {-8.5, 18}, {32, 18}}, color = {0, 0, 127}));
  connect(turbine.o, tail.o) annotation (
    Line(points = {{50, 30}, {80, 30}}, color = {0, 128, 255}));
  connect(ramp.y, turbine.u_t) annotation (
    Line(points = {{-13, 80}, {32, 80}, {32, 42}}, color = {0, 0, 127}));
  connect(penstock.o, turbine.i) annotation (
    Line(points = {{-20, 30}, {30, 30}}, color = {0, 128, 255}));
  annotation (
  Diagram(coordinateSystem(extent = {{-100, 100}, {100, 20}})));
end Model_I_SimPel;
