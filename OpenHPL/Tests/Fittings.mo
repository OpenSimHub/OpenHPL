within OpenHPL.Tests;
model Fittings "Test for comparing fitting behaviour"
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir headw(H_r=10) annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  OpenHPL.Waterway.Fitting fitting(fit_type=OpenHPL.Types.Fitting.Square, L=4) annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  OpenHPL.Waterway.Pipe head(D_i=2) annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  OpenHPL.Waterway.Pipe tail(D_i=1) annotation (Placement(transformation(extent={{40,40},{60,60}})));
  OpenHPL.Waterway.Reservoir tailw(H_r=10) annotation (Placement(transformation(extent={{100,40},{80,60}})));
  inner OpenHPL.Parameters Const(Steady=true) annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  OpenHPL.Waterway.Reservoir headw1(H_r=10) annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  OpenHPL.Waterway.Fitting fitting1(fit_type=OpenHPL.Types.Fitting.Rounded, L=5) annotation (Placement(transformation(extent={{10,-10},{-10,10}})));
  OpenHPL.Waterway.Pipe head1(D_i=2) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  OpenHPL.Waterway.Pipe tail1(D_i=1) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  OpenHPL.Waterway.Reservoir tailw1(H_r=10) annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  OpenHPL.Waterway.Reservoir headw2(H_r=10) annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  OpenHPL.Waterway.Pipe head2(D_i=2) annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  OpenHPL.Waterway.Pipe tail2(D_i=1) annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  OpenHPL.Waterway.Reservoir tailw2(H_r=10) annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
  OpenHPL.Waterway.Pipe fitting2(
    H=0,
    L=5,
    D_i=2,
    D_o=1) annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
equation
  connect(headw.o, head.i) annotation (Line(points={{-80,50},{-60,50}}, color={28,108,200}));
  connect(head.o, fitting.i) annotation (Line(points={{-40,50},{-10,50}}, color={28,108,200}));
  connect(fitting.o, tail.i) annotation (Line(points={{10,50},{40,50}}, color={28,108,200}));
  connect(tail.o, tailw.o) annotation (Line(points={{60,50},{80,50}}, color={28,108,200}));
  connect(headw1.o, head1.i) annotation (Line(points={{-80,0},{-60,0}}, color={28,108,200}));
  connect(head1.o, fitting1.o) annotation (Line(points={{-40,0},{-10,0}}, color={28,108,200}));
  connect(fitting1.i, tail1.i) annotation (Line(points={{10,0},{40,0}}, color={28,108,200}));
  connect(tail1.o, tailw1.o) annotation (Line(points={{60,0},{80,0}}, color={28,108,200}));
  connect(headw2.o, head2.i) annotation (Line(points={{-80,-30},{-60,-30}}, color={28,108,200}));
  connect(head2.o, fitting2.i) annotation (Line(points={{-40,-30},{-10,-30}}, color={28,108,200}));
  connect(fitting2.o, tail2.i) annotation (Line(points={{10,-30},{40,-30}}, color={28,108,200}));
  connect(tail2.o, tailw2.o) annotation (Line(points={{60,-30},{80,-30}}, color={28,108,200}));
  annotation (experiment(StopTime=100));
end Fittings;
