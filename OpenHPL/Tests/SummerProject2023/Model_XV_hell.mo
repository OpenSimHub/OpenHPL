within OpenHPL.Tests.SummerProject2023;
model Model_XV_hell "Based on Examples.SimpleGen"
  inner OpenHPL.Data data(SteadyState = false) annotation (
    Placement(visible = true, transformation(origin = {-92, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Reservoir reservoir(h_0 = 48) annotation (
    Placement(visible = true, transformation(origin = {-92, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe pipe(H = 23, Vdot(fixed = true)) annotation (
    Placement(visible = true, transformation(origin = {-62, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe pipe1(D_i = 3, H = 428.5, L = 600) annotation (
    Placement(visible = true, transformation(origin = {-4, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.ElectroMech.Turbines.Turbine turbine(ConstEfficiency = false, ValveCapacity = true, enable_P_out = true) annotation (
    Placement(visible = true, transformation(origin = {28, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.ElectroMech.Generators.SimpleGen simpleGen annotation (
    Placement(visible = true, transformation(origin = {20, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe pipe2(H = 0.5, L = 600) annotation (
    Placement(visible = true, transformation(origin = {56, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Reservoir reservoir1(h_0 = 5) annotation (
    Placement(visible = true, transformation(origin = {82, 38}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp(duration = 30, height = -0.7, offset = 0.75, startTime = 50) annotation (
    Placement(visible = true, transformation(origin = {-46, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.SurgeTank surgeTank annotation (
    Placement(visible = true, transformation(origin = {-32, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 0) annotation (
    Placement(visible = true, transformation(origin = {54, 88}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(simpleGen.flange, turbine.flange) annotation (
    Line(points = {{20, 84}, {20, 54}, {28, 54}, {28, 38}}));
  connect(reservoir.o, pipe.i) annotation (
    Line(points = {{-82, 38}, {-72, 38}}, color = {0, 128, 255}));
  connect(pipe1.o, turbine.i) annotation (
    Line(points = {{6, 38}, {18, 38}}, color = {0, 128, 255}));
  connect(turbine.o, pipe2.i) annotation (
    Line(points = {{38, 38}, {46, 38}}, color = {0, 128, 255}));
  connect(pipe2.o, reservoir1.o) annotation (
    Line(points = {{66, 38}, {72, 38}}, color = {0, 128, 255}));
  connect(surgeTank.o, pipe1.i) annotation (
    Line(points = {{-22, 38}, {-14, 38}}, color = {0, 128, 255}));
  connect(pipe.o, surgeTank.i) annotation (
    Line(points = {{-52, 38}, {-42, 38}}, color = {0, 128, 255}));
  connect(gain.y, simpleGen.Pload) annotation (
    Line(points = {{43, 88}, {37.5, 88}, {37.5, 96}, {20, 96}}, color = {0, 0, 127}));
  connect(ramp.y, turbine.u_t) annotation (
    Line(points = {{-35, 80}, {9, 80}, {9, 50}, {20, 50}}, color = {0, 0, 127}));
  connect(turbine.P_out, gain.u) annotation (
    Line(points={{32,49},{32,68},{74,68},{74,88},{66,88}},            color = {0, 0, 127}));
  annotation (
    Diagram(coordinateSystem(extent = {{-120, 100}, {100, 20}})),
    experiment(StartTime = 0, StopTime = 300, Tolerance = 1e-06, Interval = 0.6));
end Model_XV_hell;
