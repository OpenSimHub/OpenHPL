within OpenHPL.Examples;
model TainterGate3 "Usage of the tainter gate"
  extends Modelica.Icons.Example;
  inner Data data(SteadyState = true, Vdot_0 = 75) annotation (
    Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
  Modelica.Blocks.Sources.Ramp gateOpening(
    height=0,
    duration=1000,
    offset=0.4,
    startTime=500) annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Waterway.Reservoir upstream(
    h_0=5.6,
    constantLevel=true,
    L=10,
    W=10) annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Waterway.Reservoir downstream(
    h_0=2.8,
    constantLevel=false,
    useLevel=true,
    L=10,
    W=10) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={30,-10})));
  Waterway.Gate tainterGate3_1(
    sluice=true,
    r=8.5,
    h_h=5.55,
    b=5.9) annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  Modelica.Blocks.Sources.Ramp downstream_level(
    height=4,
    duration=1000,
    offset=0,
    startTime=500) annotation (Placement(transformation(extent={{80,-20},{60,0}})));
equation
  connect(upstream.o, tainterGate3_1.i) annotation (Line(points={{-20,-10},{-10,-10}}, color={0,128,255}));
  connect(tainterGate3_1.o, downstream.o) annotation (Line(points={{10,-10},{20,-10}}, color={0,128,255}));
  connect(tainterGate3_1.a, gateOpening.y) annotation (Line(points={{0,2},{-2,2},{-2,42},{-19,42},{-19,40}}, color={0,0,127}));
  connect(downstream.level, downstream_level.y) annotation (Line(points={{42,-4},{54,-4},{54,-10},{59,-10}}, color={0,0,127}));
  annotation (
    experiment(StopTime=2000, Interval=0.4));
end TainterGate3;
