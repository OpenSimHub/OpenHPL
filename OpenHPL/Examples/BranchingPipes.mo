within OpenHPL.Examples;
model BranchingPipes "Model of branching pipes"
  extends Modelica.Icons.Example;
  Waterway.Reservoir reservoir annotation (
    Placement(transformation(extent = {{-80, -10}, {-60, 10}})));
  Waterway.Pipe mainPipe(D_i = 6, H = 1, L = 100) annotation (
    Placement(transformation(extent = {{-52, -10}, {-32, 10}})));
  Waterway.Reservoir reservoir1 annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {70, 0})));
  Waterway.Pipe branch1(D_i = 3, H = 1, L = 100, Vdot_0 = data.Vdot_0/2) annotation (
    Placement(transformation(extent = {{-10, 10}, {10, 30}})));
  Waterway.Pipe branch2(D_i = 3, H = 1, L = 100, Vdot_0 = data.Vdot_0/2) annotation (
    Placement(transformation(extent = {{-10, -30}, {10, -10}})));
  Waterway.Pipe mainPipeOut(D_i = 5, H = 1, L = 100) annotation (
    Placement(transformation(extent = {{30, -10}, {50, 10}})));
  inner Data data(SteadyState = true, Vdot_0 = 75) annotation (
    Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
equation
  connect(reservoir.o, mainPipe.i) annotation (
    Line(points = {{-60, 0}, {-52, 0}}, color = {28, 108, 200}));
  connect(branch1.i, mainPipe.o) annotation (
    Line(points = {{-10, 20}, {-20, 20}, {-20, 0}, {-32, 0}}, color = {28, 108, 200}));
  connect(mainPipe.o, branch2.i) annotation (
    Line(points = {{-32, 0}, {-20, 0}, {-20, -20}, {-10, -20}}, color = {28, 108, 200}));
  connect(branch2.o, mainPipeOut.i) annotation (
    Line(points = {{10, -20}, {20, -20}, {20, 0}, {30, 0}}, color = {28, 108, 200}));
  connect(branch1.o, mainPipeOut.i) annotation (
    Line(points = {{10, 20}, {20, 20}, {20, 0}, {30, 0}}, color = {28, 108, 200}));
  connect(mainPipeOut.o, reservoir1.o) annotation (
    Line(points = {{50, 0}, {60, 0}}, color = {0, 128, 255}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end BranchingPipes;
