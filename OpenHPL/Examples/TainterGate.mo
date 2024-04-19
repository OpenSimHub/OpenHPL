within OpenHPL.Examples;
model TainterGate "Usage of the tainter gate"
  extends Modelica.Icons.Example;
  inner Data data(SteadyState = true, Vdot_0 = 75) annotation (
    Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
  Modelica.Blocks.Sources.Ramp gateOpening(
    height=5,
    duration=1000,
    offset=0.1,
    startTime=500) annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Waterway.Reservoir upstream(
    h_0=5,
    constantLevel=true,
    L=10,
    W=10) annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Waterway.Reservoir downstream(
    h_0=4,
    constantLevel=false,
    useLevel=true,
    L=10,
    W=10) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={30,-10})));
  Waterway.TainterGate tainterGate(W=16.5, T=5.6) annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  Modelica.Blocks.Sources.Ramp level(
    height=4.89,
    duration=1000,
    offset=0.1,
    startTime=500)                            annotation (Placement(transformation(extent={{80,-20},{60,0}})));
equation
  connect(upstream.o, tainterGate.i) annotation (Line(points={{-20,-10},{-10,-10}}, color={0,128,255}));
  connect(tainterGate.o, downstream.o) annotation (Line(points={{10,-10},{20,-10}}, color={0,128,255}));
  connect(gateOpening.y, tainterGate.B) annotation (Line(points={{-19,40},{0,40},{0,2}}, color={0,0,127}));
  connect(level.y, downstream.level) annotation (Line(points={{59,-10},{50,-10},{50,-4},{42,-4}}, color={0,0,127}));
  annotation (
    experiment(StopTime=2000, Interval=0.4));
end TainterGate;
