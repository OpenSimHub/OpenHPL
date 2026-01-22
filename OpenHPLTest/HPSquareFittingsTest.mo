within OpenHPLTest;
model HPSquareFittingsTest "Test for comparing fitting behaviour"
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir headWater(h_0=10) annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  OpenHPL.Waterway.Fitting SquareExpansion(
    fit_type=OpenHPL.Types.Fitting.Square,
    D_i=2,
    D_o=4,
    L=4) annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  OpenHPL.Waterway.Pipe pipe1(
    H=5,
    L=100,
    D_i=2) annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  OpenHPL.Waterway.Pipe tail1(
    H=0,
    L=100,
    D_i=4) annotation (Placement(transformation(extent={{40,50},{60,70}})));
  OpenHPL.Waterway.Reservoir tailWater(h_0=10) annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  inner OpenHPL.Data data(SteadyState=true) annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  OpenHPL.Waterway.Pipe pipe2(
    H=5,
    L=100,
    D_i=4) annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  OpenHPL.Waterway.Pipe tail2(
    H=0,
    L=100,
    D_i=2) annotation (Placement(transformation(extent={{40,10},{60,30}})));
  OpenHPL.Waterway.Fitting SquareReductionRev(
    fit_type=OpenHPL.Types.Fitting.Square,
    D_i=4,
    D_o=2,
    L=4) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={0,20})));
  OpenHPL.Waterway.Pipe pipe3(
    H=0,
    L=100,
    D_i=2) annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  OpenHPL.Waterway.Pipe tail3(
    H=5,
    L=100,
    D_i=4) annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
  OpenHPL.Waterway.Fitting SquareReduction(
    fit_type=OpenHPL.Types.Fitting.Square,
    D_i=4,
    D_o=2,
    L=4) annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  OpenHPL.Waterway.Pipe pipe4(
    H=0,
    L=100,
    D_i=4) annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  OpenHPL.Waterway.Pipe tail4(
    H=5,
    L=100,
    D_i=2) annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
  OpenHPL.Waterway.Fitting SquareExpansionRev(
    fit_type=OpenHPL.Types.Fitting.Square,
    D_i=2,
    D_o=4,
    L=4) "dp = p_i - p_o; So, dp should be positive when the type is expansion." annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,-60})));
equation
  connect(headWater.o, pipe1.i) annotation (Line(points={{-80,0},{-70,0},{-70,60},{-60,60}}, color={28,108,200}));
  connect(pipe1.o, SquareExpansion.i) annotation (Line(points={{-40,60},{-10,60}}, color={28,108,200}));
  connect(SquareExpansion.o, tail1.i) annotation (Line(points={{10,60},{40,60}}, color={28,108,200}));
  connect(tail1.o, tailWater.o) annotation (Line(points={{60,60},{70,60},{70,0},{80,0}}, color={28,108,200}));
  connect(pipe2.o, SquareReductionRev.o) annotation (Line(points={{-40,20},{-10,20}}, color={28,108,200}));
  connect(tail2.i, SquareReductionRev.i) annotation (Line(points={{40,20},{10,20}}, color={28,108,200}));
  connect(pipe3.o, SquareReduction.i) annotation (Line(points={{-40,-20},{-10,-20}}, color={28,108,200}));
  connect(tail3.i, SquareReduction.o) annotation (Line(points={{40,-20},{10,-20}}, color={28,108,200}));
  connect(pipe4.o, SquareExpansionRev.o) annotation (Line(points={{-40,-60},{-10,-60}}, color={28,108,200}));
  connect(tail4.i, SquareExpansionRev.i) annotation (Line(points={{40,-60},{10,-60}}, color={28,108,200}));
  connect(pipe2.i, headWater.o) annotation (Line(points={{-60,20},{-70,20},{-70,0},{-80,0}}, color={0,128,255}));
  connect(pipe3.i, headWater.o) annotation (Line(points={{-60,-20},{-70,-20},{-70,0},{-80,0}}, color={0,128,255}));
  connect(pipe4.i, headWater.o) annotation (Line(points={{-60,-60},{-70,-60},{-70,0},{-80,0}}, color={0,128,255}));
  connect(tail2.o, tailWater.o) annotation (Line(points={{60,20},{70,20},{70,0},{80,0}}, color={0,128,255}));
  connect(tail3.o, tailWater.o) annotation (Line(points={{60,-20},{70,-20},{70,0},{80,0}}, color={0,128,255}));
  connect(tail4.o, tailWater.o) annotation (Line(points={{60,-60},{70,-60},{70,0},{80,0}}, color={0,128,255}));
  annotation (experiment(StopTime=100));
end HPSquareFittingsTest;
