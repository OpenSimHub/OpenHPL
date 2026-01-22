within OpenHPLTest;
model HPAllTypeFittingsTest "Test for comparing fitting behaviour"
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir headWater(h_0=10) annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  OpenHPL.Waterway.Fitting SquareExpansion(
    fit_type=OpenHPL.Types.Fitting.Square,
    D_i=2,
    D_o=4,
    L=4) annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  OpenHPL.Waterway.Pipe pipe1(
    H=5,
    L=100,
    D_i=2) annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  OpenHPL.Waterway.Pipe tail1(
    H=0,
    L=100,
    D_i=4) annotation (Placement(transformation(extent={{40,70},{60,90}})));
  OpenHPL.Waterway.Reservoir tailWater(h_0=10) annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  inner OpenHPL.Data data(SteadyState=true) annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  OpenHPL.Waterway.Pipe pipe2(
    H=5,
    L=100,
    D_i=4) annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  OpenHPL.Waterway.Pipe tail2(
    H=0,
    L=100,
    D_i=2) annotation (Placement(transformation(extent={{40,50},{60,70}})));
  OpenHPL.Waterway.Fitting TaperedExpansion(
    fit_type=OpenHPL.Types.Fitting.Tapered,
    D_i=2,
    D_o=4,
    L=4) annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  OpenHPL.Waterway.Pipe pipe3(
    H=5,
    L=100,
    D_i=2) annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  OpenHPL.Waterway.Pipe tail3(
    H=0,
    L=100,
    D_i=4) annotation (Placement(transformation(extent={{40,30},{60,50}})));
  OpenHPL.Waterway.Pipe pipe4(
    H=5,
    L=100,
    D_i=4) annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  OpenHPL.Waterway.Pipe tail4(
    H=0,
    L=100,
    D_i=2) annotation (Placement(transformation(extent={{40,10},{60,30}})));
  OpenHPL.Waterway.Fitting RoundedExpansion(
    fit_type=OpenHPL.Types.Fitting.Rounded,
    D_i=2,
    D_o=4,
    L=4) annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  OpenHPL.Waterway.Pipe pipe5(
    H=5,
    L=100,
    D_i=2) annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  OpenHPL.Waterway.Pipe tail5(
    H=0,
    L=100,
    D_i=4) annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
  OpenHPL.Waterway.Pipe pipe6(
    vertical=false,
    H=5,
    L=100,
    D_i=4) annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  OpenHPL.Waterway.Pipe tail6(
    H=0,
    L=100,
    D_i=2) annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  OpenHPL.Waterway.Fitting SharpOrifice(
    fit_type=OpenHPL.Types.Fitting.SharpOrifice,
    D_i=4,
    D_o=2,
    L=4) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={0,-60})));
  OpenHPL.Waterway.Pipe pipe7(
    H=5,
    L=100,
    D_i=4) annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  OpenHPL.Waterway.Pipe tail7(
    H=0,
    L=100,
    D_i=2) annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
  OpenHPL.Waterway.Fitting ThickOrifice(
    fit_type=OpenHPL.Types.Fitting.ThickOrifice,
    D_i=4,
    D_o=2,
    L=4) annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
  OpenHPL.Waterway.Pipe pipe8(
    H=5,
    L=100,
    D_i=4) annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
  OpenHPL.Waterway.Pipe tail8(
    H=0,
    L=100,
    D_i=2) annotation (Placement(transformation(extent={{40,-90},{60,-70}})));
  OpenHPL.Waterway.Fitting SquareReduction(
    fit_type=OpenHPL.Types.Fitting.Square,
    D_i=4,
    D_o=2,
    L=4) annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  OpenHPL.Waterway.Fitting TaperedReduction(
    fit_type=OpenHPL.Types.Fitting.Tapered,
    D_i=4,
    D_o=2,
    L=4) annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  OpenHPL.Waterway.Fitting RoundedReduction(
    fit_type=OpenHPL.Types.Fitting.Rounded,
    D_i=4,
    D_o=2,
    L=4) annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
equation
  connect(headWater.o, pipe1.i) annotation (Line(points={{-80,0},{-70,0},{-70,80},{-60,80}}, color={28,108,200}));
  connect(pipe1.o, SquareExpansion.i)
    annotation (Line(points={{-40,80},{-10,80}}, color={28,108,200}));
  connect(SquareExpansion.o, tail1.i)
    annotation (Line(points={{10,80},{40,80}}, color={28,108,200}));
  connect(tail1.o, tailWater.o) annotation (Line(points={{60,80},{70,80},{70,0},{80,0}}, color={28,108,200}));
  connect(pipe3.o, TaperedExpansion.i)
    annotation (Line(points={{-40,40},{-10,40}}, color={28,108,200}));
  connect(TaperedExpansion.o, tail3.i)
    annotation (Line(points={{10,40},{40,40}}, color={28,108,200}));
  connect(pipe5.o, RoundedExpansion.i)
    annotation (Line(points={{-40,-20},{-10,-20}}, color={28,108,200}));
  connect(RoundedExpansion.o, tail5.i)
    annotation (Line(points={{10,-20},{40,-20}}, color={28,108,200}));
  connect(pipe2.o, SquareReduction.i) annotation (Line(points={{-40,60},{-10,60}}, color={0,128,255}));
  connect(SquareReduction.o, tail2.i) annotation (Line(points={{10,60},{40,60}}, color={0,128,255}));
  connect(tail2.o, tailWater.o) annotation (Line(points={{60,60},{70,60},{70,0},{80,0}}, color={0,128,255}));
  connect(pipe4.o, TaperedReduction.i) annotation (Line(points={{-40,20},{-10,20}}, color={0,128,255}));
  connect(pipe4.i, headWater.o) annotation (Line(points={{-60,20},{-70,20},{-70,0},{-80,0}}, color={0,128,255}));
  connect(TaperedReduction.o, tail4.i) annotation (Line(points={{10,20},{40,20}}, color={0,128,255}));
  connect(tail4.o, tailWater.o) annotation (Line(points={{60,20},{70,20},{70,0},{80,0}}, color={0,128,255}));
  connect(tail3.o, tailWater.o) annotation (Line(points={{60,40},{70,40},{70,0},{80,0}}, color={0,128,255}));
  connect(pipe3.i, headWater.o) annotation (Line(points={{-60,40},{-70,40},{-70,0},{-80,0}}, color={0,128,255}));
  connect(pipe2.i, headWater.o) annotation (Line(points={{-60,60},{-70,60},{-70,0},{-80,0}}, color={0,128,255}));
  connect(pipe6.o, RoundedReduction.i) annotation (Line(points={{-40,-40},{-10,-40}}, color={0,128,255}));
  connect(RoundedReduction.o, tail6.i) annotation (Line(points={{10,-40},{40,-40}}, color={0,128,255}));
  connect(pipe7.o, SharpOrifice.i) annotation (Line(points={{-40,-60},{-10,-60}}, color={0,128,255}));
  connect(SharpOrifice.o, tail7.i) annotation (Line(points={{10,-60},{40,-60}}, color={0,128,255}));
  connect(pipe8.o, ThickOrifice.i) annotation (Line(points={{-40,-80},{-10,-80}}, color={0,128,255}));
  connect(ThickOrifice.o, tail8.i) annotation (Line(points={{10,-80},{40,-80}}, color={0,128,255}));
  connect(pipe5.i, headWater.o) annotation (Line(points={{-60,-20},{-70,-20},{-70,0},{-80,0}}, color={0,128,255}));
  connect(pipe6.i, headWater.o) annotation (Line(points={{-60,-40},{-70,-40},{-70,0},{-80,0}}, color={0,128,255}));
  connect(pipe7.i, headWater.o) annotation (Line(points={{-60,-60},{-70,-60},{-70,0},{-80,0}}, color={0,128,255}));
  connect(pipe8.i, headWater.o) annotation (Line(points={{-60,-80},{-70,-80},{-70,0},{-80,0}}, color={0,128,255}));
  connect(tail5.o, tailWater.o) annotation (Line(points={{60,-20},{70,-20},{70,0},{80,0}}, color={0,128,255}));
  connect(tail6.o, tailWater.o) annotation (Line(points={{60,-40},{70,-40},{70,0},{80,0}}, color={0,128,255}));
  connect(tail7.o, tailWater.o) annotation (Line(points={{60,-60},{70,-60},{70,0},{80,0}}, color={0,128,255}));
  connect(tail8.o, tailWater.o) annotation (Line(points={{60,-80},{70,-80},{70,0},{80,0}}, color={0,128,255}));
  annotation (experiment(StopTime=100));
end HPAllTypeFittingsTest;
