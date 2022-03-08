within OpenHPL.Tests;
model HPTaperedFittingsTest "Test for comparing fitting behaviour"
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir headWater(H_0=10) annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  OpenHPL.Waterway.Fitting TaperedExpansion(
    fit_type=OpenHPL.Types.Fitting.Tapered,
    D_i=2,
    D_o=4,
    L=4) annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  OpenHPL.Waterway.Pipe pipe1(
    vertical=false,
    H=5,
    L=100,
    D_i=2) annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  OpenHPL.Waterway.Pipe tail1(
    H=0,
    L=100,
    D_i=4) annotation (Placement(transformation(extent={{40,50},{60,70}})));
  OpenHPL.Waterway.Reservoir tailWater(H_0=10) annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  inner OpenHPL.Data data(Steady=true) annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Waterway.Pipe         pipe2(
    H=5,
    L=100,
    D_i=4)                          annotation (Placement(transformation(extent={{-60,12},
            {-40,32}})));
  Waterway.Pipe         tail2(
    H=0,
    L=100,
    D_i=2)                          annotation (Placement(transformation(extent={{40,12},
            {60,32}})));
  Waterway.Fitting TaperedReductionRev(
    fit_type=OpenHPL.Types.Fitting.Tapered,
    D_i=4,
    D_o=2,
    L=4) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={0,22})));
  Waterway.Pipe         pipe3(
    H=0,
    L=100,
    D_i=2)                          annotation (Placement(transformation(extent={{-60,-30},
            {-40,-10}})));
  Waterway.Pipe         tail3(
    H=5,
    L=100,
    D_i=4)                          annotation (Placement(transformation(extent={{40,-30},
            {60,-10}})));
  Waterway.Fitting TaperedReduction(
    fit_type=OpenHPL.Types.Fitting.Tapered,
    D_i=4,
    D_o=2,
    L=4) annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  Waterway.Pipe         pipe4(
    H=0,
    L=100,
    D_i=4)                          annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Waterway.Pipe         tail4(
    H=5,
    L=100,
    D_i=2)                          annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
  Waterway.Fitting TaperedExpansionRev(
    fit_type=OpenHPL.Types.Fitting.Tapered,
    D_i=2,
    D_o=4,
    L=4) "dp = p_i - p_o; So, dp should be positive when the type is expansion." annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={0,-60})));
equation
  connect(pipe1.o, TaperedExpansion.i) annotation (Line(points={{-40,60},{-10,60}}, color={28,108,200}));
  connect(TaperedExpansion.o, tail1.i) annotation (Line(points={{10,60},{40,60}}, color={28,108,200}));
  connect(tail1.o, tailWater.o) annotation (Line(points={{60,60},{70,60},{70,0},{80,0}}, color={28,108,200}));
  connect(pipe2.o, TaperedReductionRev.o) annotation (Line(points={{-40,22},{-10,22}}, color={28,108,200}));
  connect(tail2.i, TaperedReductionRev.i) annotation (Line(points={{40,22},{10,22}}, color={28,108,200}));
  connect(pipe3.o, TaperedReduction.i) annotation (Line(points={{-40,-20},{-10,-20}}, color={28,108,200}));
  connect(tail3.i, TaperedReduction.o) annotation (Line(points={{40,-20},{10,-20}}, color={28,108,200}));
  connect(pipe4.o, TaperedExpansionRev.o) annotation (Line(points={{-40,-60},{-10,-60}}, color={28,108,200}));
  connect(tail4.i, TaperedExpansionRev.i) annotation (Line(points={{40,-60},{10,-60}}, color={28,108,200}));
  connect(headWater.o, pipe1.i) annotation (Line(points={{-80,0},{-70,0},{-70,60},{-60,60}}, color={0,128,255}));
  connect(pipe3.i, headWater.o) annotation (Line(points={{-60,-20},{-70,-20},{-70,0},{-80,0}}, color={0,128,255}));
  connect(pipe4.i, headWater.o) annotation (Line(points={{-60,-60},{-70,-60},{-70,0},{-80,0}}, color={0,128,255}));
  connect(pipe2.i, headWater.o) annotation (Line(points={{-60,22},{-70,22},{-70,0},{-80,0}}, color={0,128,255}));
  connect(tail2.o, tailWater.o) annotation (Line(points={{60,22},{70,22},{70,0},{80,0}}, color={0,128,255}));
  connect(tail3.o, tailWater.o) annotation (Line(points={{60,-20},{70,-20},{70,0},{80,0}}, color={0,128,255}));
  connect(tail4.o, tailWater.o) annotation (Line(points={{60,-60},{70,-60},{70,0},{80,0}}, color={0,128,255}));
  annotation (experiment(StopTime=100));
end HPTaperedFittingsTest;
