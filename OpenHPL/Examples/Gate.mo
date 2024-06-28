within OpenHPL.Examples;
model Gate "Usage of the tainter gate"
  extends Modelica.Icons.Example;
  inner Data data(SteadyState = true, Vdot_0 = 75) annotation (
    Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
  Modelica.Blocks.Sources.Ramp gateOpening(
    height=0,
    duration=1000,
    offset=1,
    startTime=500) annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Waterway.Reservoir upstream(
    h_0=5,
    constantLevel=true,
    L=10,
    W=10) annotation (Placement(transformation(extent={{-40,38},{-20,58}})));
  Waterway.Reservoir downstream(
    h_0=4,
    constantLevel=false,
    useLevel=true,
    L=10,
    W=10) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={30,48})));
  Waterway.Gate_HR gate_HR(W=16.5, T=5.6) annotation (Placement(transformation(extent={{-10,38},{10,58}})));
  Modelica.Blocks.Sources.Ramp level(
    height=4.89,
    duration=1000,
    offset=0.01,
    startTime=500)                            annotation (Placement(transformation(extent={{80,38},{60,58}})));
  Waterway.Reservoir upstream1(
    h_0=5,
    constantLevel=true,
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
        origin={32,0})));
  Waterway.Gate gate(
    sluice=false,
    b=16.5,
    r=8.5,
    h_h=5.6) annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  Modelica.Blocks.Sources.Ramp level1(
    height=4.89,
    duration=1000,
    offset=0.01,
    startTime=500)                            annotation (Placement(transformation(extent={{82,-10},{62,10}})));
  Waterway.Reservoir upstream2(
    h_0=5,
    constantLevel=true,
    L=10,
    W=10) annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Waterway.Reservoir downstream2(
    h_0=4,
    constantLevel=false,
    useLevel=true,
    L=10,
    W=10) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={30,-40})));
  Waterway.Gate gate_sluice(
    sluice=true,
    b=16.5,
    r=8.5,
    h_h=5.6) annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Modelica.Blocks.Sources.Ramp level2(
    height=4.89,
    duration=1000,
    offset=0.01,
    startTime=500)                            annotation (Placement(transformation(extent={{80,-50},{60,-30}})));
equation
  connect(upstream.o, gate_HR.i) annotation (Line(points={{-20,48},{-10,48}}, color={0,128,255}));
  connect(gate_HR.o, downstream.o) annotation (Line(points={{10,48},{20,48}}, color={0,128,255}));
  connect(gateOpening.y, gate_HR.B) annotation (Line(points={{-69,0},{-44,0},{-44,70},{0,70},{0,60}}, color={0,0,127}));
  connect(level.y, downstream.level) annotation (Line(points={{59,48},{50,48},{50,54},{42,54}},   color={0,0,127}));
  connect(upstream1.o, gate.i) annotation (Line(points={{-20,0},{-8,0}}, color={0,128,255}));
  connect(gate.o, downstream1.o) annotation (Line(points={{12,0},{22,0}}, color={0,128,255}));
  connect(level1.y, downstream1.level) annotation (Line(points={{61,0},{52,0},{52,6},{44,6}}, color={0,0,127}));
  connect(gateOpening.y, gate.a) annotation (Line(points={{-69,0},{-44,0},{-44,22},{2,22},{2,12}}, color={0,0,127}));
  connect(upstream2.o, gate_sluice.i) annotation (Line(points={{-20,-40},{-10,-40}}, color={0,128,255}));
  connect(gate_sluice.o, downstream2.o) annotation (Line(points={{10,-40},{20,-40}}, color={0,128,255}));
  connect(level2.y, downstream2.level) annotation (Line(points={{59,-40},{50,-40},{50,-34},{42,-34}}, color={0,0,127}));
  connect(gateOpening.y, gate_sluice.a) annotation (Line(points={{-69,0},{-44,0},{-44,-18},{0,-18},{0,-28}}, color={0,0,127}));
  annotation (
    experiment(StopTime=2000, Interval=0.4));
end Gate;
