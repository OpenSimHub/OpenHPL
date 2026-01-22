within OpenHPLTest;
model HPDraftTube "Testing the draft tube models."
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(h_0=48) annotation (Placement(transformation(
        origin={-88,50},
        extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = -0.04615, offset = 0.7493, startTime = 600) annotation (
    Placement(transformation(origin={22,70}, extent = {{-10, -10}, {10, 10}}, rotation=270)));
  OpenHPL.Waterway.Pipe intake(H=23) annotation (Placement(transformation(extent={{-68,40},{-48,60}})));
  OpenHPL.Waterway.Pipe discharge(
    H=4.92,
    L=5,
    D_i=3,
    D_o=4.73) annotation (Placement(transformation(extent={{54,30},{74,50}})));
  OpenHPL.Waterway.Reservoir tail(h_0=5) annotation (Placement(transformation(
        origin={90,40},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.Pipe penstock(
    D_i=3,
    D_o=3,
    H=428.5,
    L=600,
    vertical=true) annotation (Placement(transformation(
        origin={2,50},
        extent={{-10,-10},{10,10}})));
  OpenHPL.Waterway.SurgeTank surgeTank(h_0=69.9) annotation (Placement(transformation(
        origin={-28,50},
        extent={{-10,-10},{10,10}})));
  OpenHPL.ElectroMech.Turbines.Turbine turbine(C_v=3.7, ConstEfficiency=false) annotation (Placement(transformation(origin={30,40}, extent={{-10,-10},{10,10}})));
  inner OpenHPL.Data data annotation (Placement(transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}})));
  OpenHPL.Waterway.Reservoir reservoir1(h_0=48) annotation (Placement(transformation(origin={-90,-10}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp control1(
    duration=1,
    height=-0.04615,
    offset=0.7493,
    startTime=600) annotation (
    Placement(transformation(origin={22,10}, extent = {{-10, -10}, {10, 10}}, rotation=270)));
  OpenHPL.Waterway.Pipe intake1(H=23) annotation (Placement(transformation(extent={{-70,-20},{-50,0}})));
  OpenHPL.Waterway.Reservoir tail1(h_0=5) annotation (Placement(transformation(
        origin={90,-20},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.Pipe penstock1(
    D_i=3,
    D_o=3,
    H=428.5,
    L=600,
    vertical=true) annotation (Placement(transformation(origin={0,-10}, extent={{-10,-10},{10,10}})));
  OpenHPL.Waterway.SurgeTank surgeTank1(h_0=69.9) annotation (Placement(transformation(origin={-30,-10}, extent={{-10,-10},{10,10}})));
  OpenHPL.ElectroMech.Turbines.Turbine turbine1(C_v=3.7, ConstEfficiency=false) annotation (Placement(transformation(origin={30,-20}, extent={{-10,-10},{10,10}})));
  OpenHPL.Waterway.DraftTube draftTube1(
    DraftTubeType=OpenHPL.Types.DraftTube.MoodySpreadingPipe,
    H=4.92,
    L=5,
    D_i=3,
    D_o=4.73) annotation (Placement(transformation(extent={{54,-30},{74,-10}})));
  OpenHPL.Waterway.Reservoir reservoir2(h_0=48) annotation (Placement(transformation(origin={-90,-70}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp control2(
    duration=1,
    height=-0.04615,
    offset=0.7493,
    startTime=600) annotation (
    Placement(transformation(origin={24,-50}, extent = {{-10, -10}, {10, 10}}, rotation=270)));
  OpenHPL.Waterway.Pipe intake2(H=23) annotation (Placement(transformation(extent={{-68,-80},{-48,-60}})));
  OpenHPL.Waterway.Reservoir tail2(h_0=5) annotation (Placement(transformation(
        origin={90,-80},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.Pipe penstock2(
    D_i=3,
    D_o=3,
    H=428.5,
    L=600,
    vertical=true) annotation (Placement(transformation(origin={2,-70}, extent={{-10,-10},{10,10}})));
  OpenHPL.Waterway.SurgeTank surgeTank2(h_0=69.9) annotation (Placement(transformation(origin={-30,-70}, extent={{-10,-10},{10,10}})));
  OpenHPL.ElectroMech.Turbines.Turbine turbine2(C_v=3.7, ConstEfficiency=false) annotation (Placement(transformation(origin={32,-80}, extent={{-10,-10},{10,10}})));
  OpenHPL.Waterway.DraftTube draftTube2(
    DraftTubeType=OpenHPL.Types.DraftTube.MoodySpreadingPipe,
    H=4.92,
    L=5,
    D_i=3,
    D_o=4.73,
    L_m=5,
    theta_moody=90) annotation (Placement(transformation(extent={{54,-90},{74,-70}})));
equation
  connect(turbine.o, discharge.i) annotation (
    Line(points={{40,40},{54,40}}, color = {28, 108, 200}));
  connect(penstock.o, turbine.i) annotation (
    Line(points={{12,50},{16.95,50},{16.95,40},{20,40}}, color = {28, 108, 200}));
  connect(reservoir.o, intake.i) annotation (
    Line(points={{-78,50},{-68,50}}, color = {28, 108, 200}));
  connect(intake.o, surgeTank.i) annotation (
    Line(points={{-48,50},{-38,50}}, color = {28, 108, 200}));
  connect(surgeTank.o, penstock.i) annotation (
    Line(points={{-18,50},{-8,50}}, color = {28, 108, 200}));
  connect(discharge.o, tail.o) annotation (Line(points={{74,40},{80,40}},
                                                                        color={28,108,200}));
  connect(turbine.u_t, control.y)
    annotation (Line(points={{22,52},{22,59}}, color={0,0,127}));
  connect(penstock1.o, turbine1.i) annotation (Line(points={{10,-10},{16.95,-10},{16.95,-20},{20,-20}},
                                 color={28,108,200}));
  connect(reservoir1.o, intake1.i)
    annotation (Line(points={{-80,-10},{-70,-10}}, color={28,108,200}));
  connect(intake1.o, surgeTank1.i)
    annotation (Line(points={{-50,-10},{-40,-10}}, color={28,108,200}));
  connect(surgeTank1.o, penstock1.i)
    annotation (Line(points={{-20,-10},{-10,-10}},color={28,108,200}));
  connect(turbine1.u_t, control1.y)
    annotation (Line(points={{22,-8},{22,-1}}, color={0,0,127}));
  connect(turbine1.o, draftTube1.i) annotation (Line(points={{40,-20},{54,-20}}, color={28,108,200}));
  connect(tail1.o, draftTube1.o) annotation (Line(points={{80,-20},{74,-20}}, color={28,108,200}));
  connect(penstock2.o,turbine2. i) annotation (Line(points={{12,-70},{16.95,-70},{16.95,-80},{22,-80}},
                                 color={28,108,200}));
  connect(reservoir2.o,intake2. i)
    annotation (Line(points={{-80,-70},{-68,-70}}, color={28,108,200}));
  connect(intake2.o,surgeTank2. i)
    annotation (Line(points={{-48,-70},{-40,-70}}, color={28,108,200}));
  connect(surgeTank2.o,penstock2. i)
    annotation (Line(points={{-20,-70},{-8,-70}}, color={28,108,200}));
  connect(turbine2.u_t,control2. y)
    annotation (Line(points={{24,-68},{24,-61}}, color={0,0,127}));
  connect(turbine2.o,draftTube2. i) annotation (Line(points={{42,-80},{54,-80}},
                              color={28,108,200}));
  connect(tail2.o,draftTube2. o) annotation (Line(points={{80,-80},{74,-80}},
                          color={28,108,200}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPDraftTube;
