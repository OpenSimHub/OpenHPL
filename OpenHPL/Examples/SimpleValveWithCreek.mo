within OpenHPL.Examples;
model SimpleValveWithCreek
  "Model of a hydropower system with a simple turbine turbine"
  extends Modelica.Icons.Example;
  Waterway.Reservoir reservoir(h_0 = 10, constantLevel = false) annotation(
    Placement(transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp control(duration = 30, height = 0.5, offset = 0, startTime = 500e6) annotation(
    Placement(transformation(origin={-10,0},    extent = {{-10, -10}, {10, 10}})));
  Waterway.Pipe tunnel1(H = 10, D_i = 5) annotation(
    Placement(transformation(extent = {{-70, 20}, {-50, 40}})));
  Waterway.Pipe discharge(H = 0.5, L = 600, D_i = 5) annotation(
    Placement(transformation(origin={0,-50},      extent = {{50, 20}, {70, 40}})));
  Waterway.Reservoir tail(h_0 = 5) annotation(
    Placement(transformation(origin = {90, -20}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
  replaceable Waterway.Pipe penstock(D_i = 3, D_o = 3, H = 80, L = 200, vertical = true)
                                                                                  constrainedby Interfaces.TwoContacts annotation(
     Placement(transformation(origin={60,30},   extent = {{-10, -10}, {10, 10}})));
  Waterway.SurgeTank creekIntake(H = 25, L = 30, h_0 = 20, useCreekIntake = true) annotation(
    Placement(transformation(origin = {-30, 30}, extent = {{-10, -10}, {10, 10}})));
  inner Data data(Vdot_0 = 0) annotation(
    Placement(transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}})));
  Waterway.Valve valve(ValveCapacity = false, C_v = 1) annotation(
    Placement(transformation(origin={0,-50},      extent = {{20, 20}, {40, 40}})));
  OpenHPL.Waterway.Pipe tunnel2(D_i = 5, H = 10) annotation(
    Placement(transformation(origin={58,0},    extent = {{-70, 20}, {-50, 40}})));
  OpenHPL.Waterway.SurgeTank surgeTank(H = 35, L = 40, h_0 = 30) annotation(
    Placement(transformation(origin = {30, 30}, extent = {{-10, -10}, {10, 10}})));
  Waterway.VolumeFlowSource volumeFlowSource annotation(
    Placement(transformation(origin = {-52, 60}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(reservoir.o, tunnel1.i) annotation(
    Line(points = {{-80, 30}, {-70, 30}}, color = {28, 108, 200}));
  connect(tunnel1.o, creekIntake.i) annotation(
    Line(points = {{-50, 30}, {-40, 30}}, color = {28, 108, 200}));
  connect(valve.o, discharge.i) annotation(
    Line(points={{40,-20},{50,-20}},      color = {0, 128, 255}));
  connect(control.y, valve.opening) annotation(
    Line(points={{1,0},{30,0},{30,-12}},          color = {0, 0, 127}));
  connect(creekIntake.o, tunnel2.i) annotation(
    Line(points={{-20,30},{-12,30}},      color = {0, 128, 255}));
  connect(tunnel2.o, surgeTank.i) annotation(
    Line(points={{8,30},{20,30}},       color = {0, 128, 255}));
  connect(surgeTank.o, penstock.i) annotation(
    Line(points={{40,30},{50,30}},      color = {0, 128, 255}));
  connect(volumeFlowSource.o, creekIntake.creek) annotation(
    Line(points = {{-42, 60}, {-30, 60}, {-30, 40}}, color = {0, 128, 255}));
  connect(discharge.o, tail.o) annotation(
    Line(points={{70,-20},{80,-20}},      color = {0, 128, 255}));
  connect(penstock.o, valve.i) annotation (Line(points={{70,30},{80,30},{80,10},
          {8,10},{8,-20},{20,-20}}, color={0,128,255}));
  annotation(
    experiment(StopTime = 1000),
    Documentation(info = "<html>
<p>
Simple model of a water way with one creek intake.
This can be used to investigate the effects of a creek intake.
</p>
</html>"));
end SimpleValveWithCreek;
