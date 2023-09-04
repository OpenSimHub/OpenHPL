within OpenHPL.Tests.SummerProject2023;
model Model_XV_hell "Based on Examples.SimpleGen"
  inner OpenHPL.Data data(SteadyState = false) annotation (
    Placement(visible = true, transformation(origin={-90,90},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Reservoir reservoir(h_0 = 48) annotation (
    Placement(visible = true, transformation(origin={-90,40},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe pipe(H = 23, Vdot(fixed = true)) annotation (
    Placement(visible = true, transformation(origin={-60,40},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe pipe1(D_i = 3, H = 428.5, L = 600) annotation (
    Placement(visible = true, transformation(origin={0,40},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.ElectroMech.Turbines.Turbine turbine(ConstEfficiency = false, ValveCapacity = true, enable_P_out = true) annotation (
    Placement(visible = true, transformation(origin={30,40},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.ElectroMech.Generators.SimpleGen simpleGen annotation (
    Placement(visible = true, transformation(origin={30,80},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe pipe2(H = 0.5, L = 600) annotation (
    Placement(visible = true, transformation(origin={60,40},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Reservoir reservoir1(h_0 = 5) annotation (
    Placement(visible = true, transformation(origin={90,40},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp(duration = 30, height = -0.7, offset = 0.75, startTime = 50) annotation (
    Placement(visible = true, transformation(origin={-50,80},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.SurgeTank surgeTank annotation (
    Placement(visible = true, transformation(origin={-30,40},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 0) annotation (
    Placement(visible = true, transformation(origin={68,90},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(simpleGen.flange, turbine.flange) annotation (
    Line(points={{30,80},{30,40}}));
  connect(reservoir.o, pipe.i) annotation (
    Line(points={{-80,40},{-70,40}},      color = {0, 128, 255}));
  connect(pipe1.o, turbine.i) annotation (
    Line(points={{10,40},{20,40}},     color = {0, 128, 255}));
  connect(turbine.o, pipe2.i) annotation (
    Line(points={{40,40},{50,40}},      color = {0, 128, 255}));
  connect(pipe2.o, reservoir1.o) annotation (
    Line(points={{70,40},{80,40}},      color = {0, 128, 255}));
  connect(surgeTank.o, pipe1.i) annotation (
    Line(points={{-20,40},{-10,40}},      color = {0, 128, 255}));
  connect(pipe.o, surgeTank.i) annotation (
    Line(points={{-50,40},{-40,40}},      color = {0, 128, 255}));
  connect(gain.y, simpleGen.Pload) annotation (
    Line(points={{57,90},{48,90},{48,96},{30,96},{30,92}},      color = {0, 0, 127}));
  connect(ramp.y, turbine.u_t) annotation (
    Line(points={{-39,80},{6,80},{6,60},{22,60},{22,52}},  color = {0, 0, 127}));
  connect(turbine.P_out, gain.u) annotation (
    Line(points={{34,51},{34,60},{90,60},{90,90},{80,90}},            color = {0, 0, 127}));
  annotation (
    Diagram(coordinateSystem(extent = {{-120, 100}, {100, 20}})),
    experiment(StartTime = 0, StopTime = 300, Tolerance = 1e-06, Interval = 0.6));
end Model_XV_hell;
