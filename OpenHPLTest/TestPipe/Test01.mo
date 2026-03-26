within OpenHPLTest.TestPipe;
model Test01
  extends AbstractTest;
  OpenHPL.Waterway.Pipe pipe1(H = 0, L = Ln, D_i = 0.8*Dn, D_o = 1.2*Dn) annotation (
    Placement(transformation(origin = {0, 60}, extent = {{-10, -10}, {10, 10}})));
  OpenHPL.Waterway.Pipe pipe2(H = 0, L = Ln, D_i = Dn, D_o = Dn) annotation (
    Placement(transformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}})));
  OpenHPL.Waterway.Pipe pipe3(H = 0, L = Ln, D_i = 1.2*Dn, D_o = 0.8*Dn) annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
equation
 error=sqrt((pipe1.mdot-pipe2.mdot)^2 + (pipe2.mdot-pipe3.mdot)^2 + (pipe3.mdot-pipe1.mdot)^2);
connect(Upstream.o, pipe1.i) annotation (
    Line(points = {{-40, 30}, {-20, 30}, {-20, 60}, {-10, 60}}, color = {0, 128, 255}));
connect(pipe2.i, Upstream.o) annotation (
    Line(points = {{-10, 30}, {-40, 30}}, color = {0, 128, 255}));
connect(Upstream.o, pipe3.i) annotation (
    Line(points = {{-40, 30}, {-20, 30}, {-20, 0}, {-10, 0}}, color = {0, 128, 255}));
connect(pipe1.o, Downstream.o) annotation (
    Line(points = {{10, 60}, {50, 60}, {50, 10}, {60, 10}}, color = {0, 128, 255}));
connect(pipe2.o, Downstream.o) annotation (
    Line(points = {{10, 30}, {50, 30}, {50, 10}, {60, 10}}, color = {0, 128, 255}));
connect(pipe3.o, Downstream.o) annotation (
    Line(points = {{10, 0}, {50, 0}, {50, 10}, {60, 10}}, color = {0, 128, 255}));
annotation (
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
end Test01;
