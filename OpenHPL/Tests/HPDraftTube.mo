within OpenHPL.Tests;
model HPDraftTube "Testing the draft tube models."
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(H_r=48) annotation (Placement(visible=true, transformation(
        origin={-90, 50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe intake(H=23) annotation (Placement(visible=true, transformation(extent={{-62, 40}, {-42, 60}},                                                                                              rotation=0)));
  OpenHPL.Waterway.Pipe discharge(
    H=4.92,
    L=5,
    D_i=3,
    D_o=4.73)                                   annotation (Placement(visible=true, transformation(extent={{50, 40}, {70, 60}},                                                                                                         rotation=0)));
  OpenHPL.Waterway.Reservoir tail(H_r=5, Input_level=false) annotation (Placement(visible=true, transformation(
        origin={90, 50},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.Pipe penstock(
    D_i=3,
    D_o=3,
    H=428.5,
    L=600,
    vertical=true) annotation (Placement(visible=true, transformation(
        origin={10, 50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.SurgeTank surgeTank(h_0=69.9) annotation (Placement(visible=true, transformation(
        origin={-20, 50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.ElectroMech.Turbines.Turbine turbine annotation(
    Placement(visible = true, transformation(origin = {34, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = -0.04615, offset = 0.7493, startTime = 600) annotation(
    Placement(visible = true, transformation(origin = {10, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(reservoir.o, intake.i) annotation(
    Line(points = {{-80, 50}, {-62, 50}}, color = {28, 108, 200}));
  connect(intake.o, surgeTank.i) annotation(
    Line(points = {{-42, 50}, {-30, 50}}, color = {28, 108, 200}));
  connect(surgeTank.o, penstock.i) annotation(
    Line(points = {{-10, 50}, {0, 50}}, color = {28, 108, 200}));
  connect(discharge.o, tail.o) annotation(
    Line(points = {{70, 50}, {80, 50}}, color = {28, 108, 200}));
  connect(turbine1.o, draftTube.i) annotation(
    Line(points = {{42, -14}, {48, -14}, {48, -8}, {54, -8}}, color = {28, 108, 200}));
  connect(tail1.o, draftTube.o) annotation(
    Line(points = {{80, -4}, {78, -4}, {78, -8}, {74, -8}}, color = {28, 108, 200}));
  connect(turbine2.o, draftTube1.i) annotation(
    Line(points = {{42, -70}, {48, -70}, {48, -62}, {54, -62}}, color = {28, 108, 200}));
  connect(tail2.o, draftTube1.o) annotation(
    Line(points = {{80, -60}, {78, -60}, {78, -62}, {74, -62}}, color = {28, 108, 200}));
  connect(penstock.o, turbine.i) annotation(
    Line(points = {{20, 50}, {24, 50}}, color = {28, 108, 200}));
  connect(turbine.o, discharge.i) annotation(
    Line(points = {{44, 50}, {50, 50}}, color = {28, 108, 200}));
  connect(control.y, turbine.u_t) annotation(
    Line(points = {{22, 86}, {34, 86}, {34, 62}, {34, 62}}, color = {0, 0, 127}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPDraftTube;
