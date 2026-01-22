within OpenHPLTest;
model Reservoir
 extends Modelica.Icons.Example;

  OpenHPL.Waterway.Reservoir head1_constlevel(h_0=10) annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  OpenHPL.Waterway.Reservoir tail(h_0=12) annotation (Placement(transformation(extent={{60,-10},{40,10}})));
  OpenHPL.Waterway.Pipe pipe1(H=0, M(fixed=true)) annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  inner OpenHPL.Data data annotation (Placement(transformation(extent={{-92,76},{-72,96}})));
  OpenHPL.Waterway.Reservoir head2_level(useLevel=true, h_0=10) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  OpenHPL.Waterway.Pipe pipe2(H=0, M(fixed=true)) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp ramp2(
    height=1,
    duration=1,
    offset=10,
    startTime=50) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  OpenHPL.Waterway.Reservoir head3_flow(
    useLevel=true,
    useInflow=false,
    h_0=10) annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  OpenHPL.Waterway.Pipe pipe3(H=0, M(fixed=true)) annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Modelica.Blocks.Sources.Ramp ramp3(
    height=-30,
    duration=1,
    offset=10,
    startTime=50) annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
equation
  connect(pipe1.o, tail.o) annotation (Line(points={{10,40},{26,40},{26,0},{40,0}}, color={0,128,255}));
  connect(head1_constlevel.o, pipe1.i) annotation (Line(points={{-20,40},{-10,40}}, color={0,128,255}));
  connect(head2_level.o, pipe2.i) annotation (Line(points={{-20,0},{-10,0}}, color={0,128,255}));
  connect(head2_level.level, ramp2.y) annotation (Line(points={{-42,6},{-52,6},{-52,0},{-59,0}}, color={0,0,127}));
  connect(head3_flow.o, pipe3.i) annotation (Line(points={{-20,-40},{-10,-40}}, color={0,128,255}));
  connect(pipe2.o, tail.o) annotation (Line(points={{10,0},{40,0}}, color={0,128,255}));
  connect(pipe3.o, tail.o) annotation (Line(points={{10,-40},{26,-40},{26,0},{40,0}}, color={0,128,255}));
  connect(ramp3.y, head3_flow.level) annotation (Line(points={{-59,-40},{-52,-40},{-52,-34},{-42,-34}}, color={0,0,127}));
  annotation (experiment(StopTime=1000));
end Reservoir;
