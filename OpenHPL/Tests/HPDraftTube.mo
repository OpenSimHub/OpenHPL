within OpenHPL.Tests;
model HPDraftTube "Testing the draft tube models."
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(H_r=48) annotation (Placement(visible=true, transformation(
        origin={-88,64},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = -0.04615, offset = 0.7493, startTime = 600) annotation (
    Placement(visible = true, transformation(origin={32,78},     extent = {{-10, -10}, {10, 10}}, rotation=270)));
  OpenHPL.Waterway.Pipe intake(H=23) annotation (Placement(visible=true, transformation(extent={{-68,54},
            {-48,74}},                                                                                              rotation=0)));
  OpenHPL.Waterway.Pipe discharge(
    H=4.92,
    L=5,
    D_i=3,
    D_o=4.73)                                   annotation (Placement(visible=true, transformation(extent={{54,44},
            {74,64}},                                                                                                         rotation=0)));
  OpenHPL.Waterway.Reservoir tail(H_r=5, Input_level=false) annotation (Placement(visible=true, transformation(
        origin={90,54},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.Pipe penstock(
    D_i=3,
    D_o=3,
    H=428.5,
    L=600,
    vertical=true) annotation (Placement(visible=true, transformation(
        origin={2,64},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.SurgeTank surgeTank(h_0=69.9) annotation (Placement(visible=true, transformation(
        origin={-28,64},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Turbines.Turbine turbine(C_v=3.7, ConstEfficiency=false) annotation (Placement(visible=true, transformation(
        origin={32,44},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner OpenHPL.Data data annotation (Placement(visible=true, transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.Reservoir         reservoir1(H_r=48)
                                               annotation (Placement(visible=true, transformation(
        origin={-88,6},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control1(
    duration=1,
    height=-0.04615,
    offset=0.7493,
    startTime=600)                                                                                        annotation (
    Placement(visible = true, transformation(origin={32,20},     extent = {{-10, -10}, {10, 10}}, rotation=270)));
  Waterway.Pipe         intake1(H=23)
                                     annotation (Placement(visible=true, transformation(extent={{-68,-4},
            {-48,16}},                                                                                              rotation=0)));
  Waterway.Reservoir         tail1(H_r=5, Input_level=false)
                                                            annotation (Placement(visible=true, transformation(
        origin={90,-4},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Waterway.Pipe         penstock1(
    D_i=3,
    D_o=3,
    H=428.5,
    L=600,
    vertical=true) annotation (Placement(visible=true, transformation(
        origin={2,6},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.SurgeTank         surgeTank1(h_0=69.9)
                                                 annotation (Placement(visible=true, transformation(
        origin={-28,6},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Turbines.Turbine turbine1(C_v=3.7, ConstEfficiency=false)
                                                                       annotation (Placement(visible=true, transformation(
        origin={32,-14},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.DraftTube draftTube(
    H=4.92,
    L=5,
    D_i=3,
    D_o=4.73) annotation (Placement(transformation(extent={{54,-18},{74,2}})));
  Waterway.Reservoir         reservoir2(H_r=48)
                                               annotation (Placement(visible=true, transformation(
        origin={-88,-50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control2(
    duration=1,
    height=-0.04615,
    offset=0.7493,
    startTime=600)                                                                                        annotation (
    Placement(visible = true, transformation(origin={32,-36},    extent = {{-10, -10}, {10, 10}}, rotation=270)));
  Waterway.Pipe         intake2(H=23)
                                     annotation (Placement(visible=true, transformation(extent={{-68,-60},
            {-48,-40}},                                                                                             rotation=0)));
  Waterway.Reservoir         tail2(H_r=5, Input_level=false)
                                                            annotation (Placement(visible=true, transformation(
        origin={90,-60},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Waterway.Pipe         penstock2(
    D_i=3,
    D_o=3,
    H=428.5,
    L=600,
    vertical=true) annotation (Placement(visible=true, transformation(
        origin={2,-50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.SurgeTank         surgeTank2(h_0=69.9)
                                                 annotation (Placement(visible=true, transformation(
        origin={-28,-50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Turbines.Turbine turbine2(C_v=3.7, ConstEfficiency=false)
                                                                       annotation (Placement(visible=true, transformation(
        origin={32,-70},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.DraftTube draftTube1(
    DraftTubeType=OpenHPL.Types.DraftTube.MoodySpreadingPipe,
    H=4.92,
    L=5,
    D_i=3,
    D_o=4.73,
    L_m=5,
    L_b1=9,
    L_b2=9,
    D=4)      annotation (Placement(transformation(extent={{54,-72},{74,-52}})));
equation
  connect(turbine.o, discharge.i) annotation (
    Line(points={{42,44},{46,44},{46,54},{54,54}},          color = {28, 108, 200}));
  connect(penstock.o, turbine.i) annotation (
    Line(points={{12,64},{16.95,64},{16.95,44},{22,44}},                         color = {28, 108, 200}));
  connect(reservoir.o, intake.i) annotation (
    Line(points={{-78,64},{-68,64}},                                              color = {28, 108, 200}));
  connect(intake.o, surgeTank.i) annotation (
    Line(points={{-48,64},{-38,64}},                                              color = {28, 108, 200}));
  connect(surgeTank.o, penstock.i) annotation (
    Line(points={{-18,64},{-8,64}},                                               color = {28, 108, 200}));
  connect(discharge.o, tail.o) annotation (Line(points={{74,54},{80,54}},
                                                                        color={28,108,200}));
  connect(turbine.u_t, control.y)
    annotation (Line(points={{32,56},{32,67}}, color={0,0,127}));
  connect(penstock1.o, turbine1.i) annotation (Line(points={{12,6},{16.95,6},{
          16.95,-14},{22,-14}},  color={28,108,200}));
  connect(reservoir1.o, intake1.i)
    annotation (Line(points={{-78,6},{-68,6}},     color={28,108,200}));
  connect(intake1.o, surgeTank1.i)
    annotation (Line(points={{-48,6},{-38,6}},     color={28,108,200}));
  connect(surgeTank1.o, penstock1.i)
    annotation (Line(points={{-18,6},{-8,6}},     color={28,108,200}));
  connect(turbine1.u_t, control1.y)
    annotation (Line(points={{32,-2},{32,9}},    color={0,0,127}));
  connect(turbine1.o, draftTube.i) annotation (Line(points={{42,-14},{48,-14},{
          48,-8},{54,-8}},   color={28,108,200}));
  connect(tail1.o, draftTube.o) annotation (Line(points={{80,-4},{78,-4},{78,-8},
          {74,-8}},       color={28,108,200}));
  connect(penstock2.o,turbine2. i) annotation (Line(points={{12,-50},{16.95,-50},
          {16.95,-70},{22,-70}}, color={28,108,200}));
  connect(reservoir2.o,intake2. i)
    annotation (Line(points={{-78,-50},{-68,-50}}, color={28,108,200}));
  connect(intake2.o,surgeTank2. i)
    annotation (Line(points={{-48,-50},{-38,-50}}, color={28,108,200}));
  connect(surgeTank2.o,penstock2. i)
    annotation (Line(points={{-18,-50},{-8,-50}}, color={28,108,200}));
  connect(turbine2.u_t,control2. y)
    annotation (Line(points={{32,-58},{32,-47}}, color={0,0,127}));
  connect(turbine2.o, draftTube1.i) annotation (Line(points={{42,-70},{48,-70},
          {48,-62},{54,-62}}, color={28,108,200}));
  connect(tail2.o, draftTube1.o) annotation (Line(points={{80,-60},{78,-60},{78,
          -62},{74,-62}}, color={28,108,200}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPDraftTube;
