within OpenHPLTest.TestPipe;
model Test03
   extends AbstractTest(data(SteadyState = true));

   OpenHPL.Waterway.Pipe pipe1(H = 0, L = Ln, D_i = Dn) annotation (
    Placement(transformation(origin = {0, 60}, extent = {{-10, -10}, {10, 10}})));
   OpenHPL.Waterway.Pipe pipe2(H = 0, L = Ln, D_i = Dn) annotation (
    Placement(transformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}})));
   OpenHPL.Waterway.Pipe pipe3(H = 0, L = Ln, D_i = Dn) annotation ( Placement(transformation(extent = {{-10, -10}, {10, 10}})));
 OpenHPL.Waterway.Valve valve1(ValveCapacity = false, H_n = 100, Vdot_n = 1)  annotation (
    Placement(transformation(origin = {30, 60}, extent = {{-10, -10}, {10, 10}})));
   OpenHPL.Waterway.Valve valve2(ValveCapacity = false, H_n = 100, Vdot_n = 1) annotation (
    Placement(transformation(origin = {30, 30}, extent = {{-10, -10}, {10, 10}})));
   OpenHPL.Waterway.Valve valve3(ValveCapacity = false, H_n = 100, Vdot_n = 1) annotation (
    Placement(transformation(origin = {30, 0}, extent = {{-10, 10}, {10, -10}})));
  Modelica.Blocks.Sources.Ramp ramp1(height = 1, duration = 5, offset = 0, startTime = 2)  annotation (
    Placement(transformation(origin = {80, 80}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Blocks.Sources.Ramp ramp2(duration = 5, height = 0.5, offset = 0.5, startTime = 2) annotation (
    Placement(transformation(origin = {80, 50}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.Ramp ramp3(duration = 5, height = -1, offset = 1, startTime = 2) annotation (
    Placement(transformation(origin = {80, -20}, extent = {{10, -10}, {-10, 10}})));
equation
error=sqrt((pipe1.mdot-pipe2.mdot)^2 + (pipe2.mdot-pipe3.mdot)^2 + (pipe3.mdot-pipe1.mdot)^2);
connect(pipe1.o, valve1.i) annotation (
    Line(points = {{10, 60}, {20, 60}}, color = {0, 128, 255}));
connect(pipe2.o, valve2.i) annotation (
    Line(points = {{10, 30}, {20, 30}}, color = {0, 128, 255}));
connect(pipe3.o, valve3.i) annotation (
    Line(points = {{10, 0}, {20, 0}}, color = {0, 128, 255}));
connect(ramp1.y, valve1.opening) annotation (
    Line(points = {{69, 80}, {30, 80}, {30, 68}}, color = {0, 0, 127}));
connect(valve1.o, Downstream.o) annotation (
    Line(points = {{40, 60}, {52, 60}, {52, 10}, {62, 10}}, color = {0, 128, 255}));
connect(valve2.o, Downstream.o) annotation (
    Line(points = {{40, 30}, {52, 30}, {52, 10}, {62, 10}}, color = {0, 128, 255}));
connect(ramp3.y, valve3.opening) annotation (
    Line(points = {{69, -20}, {30, -20}, {30, -8}}, color = {0, 0, 127}));
connect(valve3.o, Downstream.o) annotation (
    Line(points = {{40, 0}, {52, 0}, {52, 10}, {62, 10}}, color = {0, 128, 255}));
connect(valve2.opening, ramp2.y) annotation (
    Line(points = {{30, 38}, {30, 50}, {70, 50}}, color = {0, 0, 127}));
connect(Upstream.o, pipe2.i) annotation (
    Line(points = {{-40, 30}, {-10, 30}}, color = {0, 128, 255}));
connect(Upstream.o, pipe1.i) annotation (
    Line(points = {{-40, 30}, {-20, 30}, {-20, 60}, {-10, 60}}, color = {0, 128, 255}));
connect(Upstream.o, pipe3.i) annotation (
    Line(points = {{-40, 30}, {-20, 30}, {-20, 0}, {-10, 0}}, color = {0, 128, 255}));
annotation (
    experiment(StartTime = 0, StopTime = 30, Tolerance = 1e-06, Interval = 0.001));
end Test03;
