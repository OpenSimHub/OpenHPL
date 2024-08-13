within OpenHPL.Examples;
model Gate "Usage of the tainter gate"
  extends Modelica.Icons.Example;
  inner Data data(SteadyState = true, Vdot_0 = 75) annotation (
    Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
  Modelica.Blocks.Sources.Ramp gateOpening(
    height=0,
    duration=1000,
    offset=1,
    startTime=500) annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Waterway.Reservoir upstream(
    constantLevel=false,
    useLevel=true,
    L=10,
    W=10) annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Waterway.Reservoir downstream(
    h_0=4,
    constantLevel=false,
    useLevel=true,
    L=10,
    W=10) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={30,50})));
  Waterway.Gate_HR gate_HR(W=16.5, T=5.6) annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Blocks.Sources.Ramp down_level(
    height=0,
    duration=1000,
    offset=3,
    startTime=500) annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Waterway.Reservoir upstream1(
    constantLevel=false,
    useLevel=true,
    L=10,
    W=10) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Waterway.Reservoir downstream1(
    h_0=4,
    constantLevel=false,
    useLevel=true,
    L=10,
    W=10) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={30,0})));
  Waterway.Gate gate(
    sluice=false,
    b=16.5,
    r=8.5,
    h_h=5.6) annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  Waterway.Reservoir upstream2(
    constantLevel=false,
    useLevel=true,
    L=10,
    W=10) annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Waterway.Reservoir downstream2(
    h_0=4,
    constantLevel=false,
    useLevel=true,
    L=10,
    W=10) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={30,-50})));
  Waterway.Gate gate_sluice(
    sluice=true,
    b=16.5,
    r=8.5,
    h_h=5.6) annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  Modelica.Blocks.Sources.Ramp up_level(
    height=0,
    duration=1000,
    offset=5,
    startTime=500) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(upstream.o, gate_HR.i) annotation (Line(points={{-20,50},{-10,50}}, color={0,128,255}));
  connect(gate_HR.o, downstream.o) annotation (Line(points={{10,50},{20,50}}, color={0,128,255}));
  connect(gateOpening.y, gate_HR.B) annotation (Line(points={{-19,80},{0,80},{0,62}},                 color={0,0,127}));
  connect(down_level.y, downstream.level) annotation (Line(points={{59,0},{54,0},{54,56},{42,56}}, color={0,0,127}));
  connect(upstream1.o, gate.i) annotation (Line(points={{-20,0},{-8,0}}, color={0,128,255}));
  connect(gate.o, downstream1.o) annotation (Line(points={{12,0},{20,0}}, color={0,128,255}));
  connect(gateOpening.y, gate.a) annotation (Line(points={{-19,80},{-14,80},{-14,22},{2,22},{2,12}},
                                                                                                   color={0,0,127}));
  connect(upstream2.o, gate_sluice.i) annotation (Line(points={{-20,-50},{-10,-50}}, color={0,128,255}));
  connect(gate_sluice.o, downstream2.o) annotation (Line(points={{10,-50},{20,-50}}, color={0,128,255}));
  connect(gateOpening.y, gate_sluice.a) annotation (Line(points={{-19,80},{-14,80},{-14,-28},{0,-28},{0,-38}},
                                                                                                             color={0,0,127}));
  connect(downstream1.level, down_level.y) annotation (Line(points={{42,6},{54,6},{54,0},{59,0}}, color={0,0,127}));
  connect(downstream2.level, down_level.y) annotation (Line(points={{42,-44},{54,-44},{54,0},{59,0}}, color={0,0,127}));
  connect(up_level.y, upstream.level) annotation (Line(points={{-59,0},{-52,0},{-52,56},{-42,56}}, color={0,0,127}));
  connect(upstream1.level, up_level.y) annotation (Line(points={{-42,6},{-52,6},{-52,0},{-59,0}}, color={0,0,127}));
  connect(upstream2.level, up_level.y) annotation (Line(points={{-42,-44},{-52,-44},{-52,0},{-59,0}}, color={0,0,127}));
  annotation (
    experiment(StopTime=2000, Interval=0.4));
end Gate;
