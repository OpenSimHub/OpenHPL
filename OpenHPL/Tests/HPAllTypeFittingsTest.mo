within OpenHPL.Tests;
model HPAllTypeFittingsTest "Test for comparing fitting behaviour"
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir Resorvoir1(H_r=10)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  OpenHPL.Waterway.Fitting SquareExpansion(
    fit_type=OpenHPL.Types.Fitting.Square,
    D_i=2,
    D_o=4,
    L=4) annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  OpenHPL.Waterway.Pipe pipe1(
    H=5,
    L=100,
    D_i=2) annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  OpenHPL.Waterway.Pipe tail1(
    H=0,
    L=100,
    D_i=4) annotation (Placement(transformation(extent={{40,60},{60,80}})));
  OpenHPL.Waterway.Reservoir tailwater1(H_r=10)
    annotation (Placement(transformation(extent={{100,60},{80,80}})));
  inner OpenHPL.Data data(Steady=true) annotation (Placement(transformation(extent={{-100,80},
            {-80,100}})));
  Waterway.Reservoir         Resorvoir2(H_r=10)
    annotation (Placement(transformation(extent={{-100,36},{-80,56}})));
  Waterway.Fitting SquareReduction(
    fit_type=OpenHPL.Types.Fitting.Square,
    D_i=4,
    D_o=2,
    L=4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={2,46})));
  Waterway.Pipe         pipe2(
    H=5,
    L=100,
    D_i=4) annotation (Placement(transformation(extent={{-60,36},{-40,56}})));
  Waterway.Pipe         tail2(
    H=0,
    L=100,
    D_i=2) annotation (Placement(transformation(extent={{40,36},{60,56}})));
  Waterway.Reservoir         tailwater2(H_r=10)
    annotation (Placement(transformation(extent={{100,36},{80,56}})));
  Waterway.Reservoir         Resorvoir3(H_r=10)
    annotation (Placement(transformation(extent={{-100,12},{-80,32}})));
  Waterway.Fitting TaperedExpansion(
    fit_type=OpenHPL.Types.Fitting.Tapered,
    D_i=2,
    D_o=4,
    L=4) annotation (Placement(transformation(extent={{-10,12},{10,32}})));
  Waterway.Pipe         pipe3(
    H=5,
    L=100,
    D_i=2) annotation (Placement(transformation(extent={{-60,12},{-40,32}})));
  Waterway.Pipe         tail3(
    H=0,
    L=100,
    D_i=4) annotation (Placement(transformation(extent={{40,12},{60,32}})));
  Waterway.Reservoir         tailwater3(H_r=10)
    annotation (Placement(transformation(extent={{100,12},{80,32}})));
  Waterway.Reservoir         Resorvoir4(H_r=10)
    annotation (Placement(transformation(extent={{-100,-12},{-80,8}})));
  Waterway.Fitting TaperedReduction(
    fit_type=OpenHPL.Types.Fitting.Tapered,
    D_i=4,
    D_o=2,
    L=4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={2,-2})));
  Waterway.Pipe         pipe4(
    H=5,
    L=100,
    D_i=4) annotation (Placement(transformation(extent={{-60,-12},{-40,8}})));
  Waterway.Pipe         tail4(
    H=0,
    L=100,
    D_i=2) annotation (Placement(transformation(extent={{40,-12},{60,8}})));
  Waterway.Reservoir         tailwater4(H_r=10)
    annotation (Placement(transformation(extent={{100,-12},{80,8}})));
  Waterway.Reservoir         Resorvoir5(H_r=10)
    annotation (Placement(transformation(extent={{-100,-36},{-80,-16}})));
  Waterway.Fitting RoundedExpansion(
    fit_type=OpenHPL.Types.Fitting.Rounded,
    D_i=2,
    D_o=4,
    L=4) annotation (Placement(transformation(extent={{-10,-36},{10,-16}})));
  Waterway.Pipe         pipe5(
    H=5,
    L=100,
    D_i=2) annotation (Placement(transformation(extent={{-60,-36},{-40,-16}})));
  Waterway.Pipe         tail5(
    H=0,
    L=100,
    D_i=4) annotation (Placement(transformation(extent={{40,-36},{60,-16}})));
  Waterway.Reservoir         tailwater5(H_r=10)
    annotation (Placement(transformation(extent={{100,-36},{80,-16}})));
  Waterway.Reservoir         Resorvoir6(H_r=10)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Waterway.Fitting RoundedReduction(
    fit_type=OpenHPL.Types.Fitting.Rounded,
    D_i=4,
    D_o=2,
    L=4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={2,-50})));
  Waterway.Pipe         pipe6(
    vertical=false,
    H=5,
    L=100,
    D_i=4) annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Waterway.Pipe         tail6(
    H=0,
    L=100,
    D_i=2) annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  Waterway.Reservoir         tailwater6(H_r=10)
    annotation (Placement(transformation(extent={{100,-60},{80,-40}})));
  Waterway.Reservoir         Resorvoir7(H_r=10)
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
  Waterway.Fitting SharpOrifice(
    fit_type=OpenHPL.Types.Fitting.SharpOrifice,
    D_i=4,
    D_o=2,
    L=4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={2,-70})));
  Waterway.Pipe         pipe7(
    H=5,
    L=100,
    D_i=4) annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  Waterway.Pipe         tail7(
    H=0,
    L=100,
    D_i=2) annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
  Waterway.Reservoir         tailwater7(H_r=10)
    annotation (Placement(transformation(extent={{100,-80},{80,-60}})));
  Waterway.Reservoir         Resorvoir8(H_r=10)
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Waterway.Fitting ThickOrifice(
    fit_type=OpenHPL.Types.Fitting.ThickOrifice,
    D_i=4,
    D_o=2,
    L=4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={2,-90})));
  Waterway.Pipe         pipe8(
    H=5,
    L=100,
    D_i=4) annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
  Waterway.Pipe         tail8(
    H=0,
    L=100,
    D_i=2) annotation (Placement(transformation(extent={{40,-100},{60,-80}})));
  Waterway.Reservoir         tailwater8(H_r=10)
    annotation (Placement(transformation(extent={{100,-100},{80,-80}})));
equation
  connect(Resorvoir1.o, pipe1.i)
    annotation (Line(points={{-80,70},{-60,70}}, color={28,108,200}));
  connect(pipe1.o, SquareExpansion.i)
    annotation (Line(points={{-40,70},{-10,70}}, color={28,108,200}));
  connect(SquareExpansion.o, tail1.i)
    annotation (Line(points={{10,70},{40,70}}, color={28,108,200}));
  connect(tail1.o, tailwater1.o)
    annotation (Line(points={{60,70},{80,70}}, color={28,108,200}));
  connect(Resorvoir2.o,pipe2. i)
    annotation (Line(points={{-80,46},{-60,46}}, color={28,108,200}));
  connect(tail2.o,tailwater2. o)
    annotation (Line(points={{60,46},{80,46}}, color={28,108,200}));
  connect(tail2.i, SquareReduction.i)
    annotation (Line(points={{40,46},{12,46}}, color={28,108,200}));
  connect(pipe2.o, SquareReduction.o)
    annotation (Line(points={{-40,46},{-8,46}}, color={28,108,200}));
  connect(Resorvoir3.o,pipe3. i)
    annotation (Line(points={{-80,22},{-60,22}}, color={28,108,200}));
  connect(pipe3.o, TaperedExpansion.i)
    annotation (Line(points={{-40,22},{-10,22}}, color={28,108,200}));
  connect(TaperedExpansion.o, tail3.i)
    annotation (Line(points={{10,22},{40,22}}, color={28,108,200}));
  connect(tail3.o,tailwater3. o)
    annotation (Line(points={{60,22},{80,22}}, color={28,108,200}));
  connect(Resorvoir4.o,pipe4. i)
    annotation (Line(points={{-80,-2},{-60,-2}}, color={28,108,200}));
  connect(tail4.o,tailwater4. o)
    annotation (Line(points={{60,-2},{80,-2}}, color={28,108,200}));
  connect(tail4.i, TaperedReduction.i)
    annotation (Line(points={{40,-2},{12,-2}}, color={28,108,200}));
  connect(pipe4.o, TaperedReduction.o)
    annotation (Line(points={{-40,-2},{-8,-2}}, color={28,108,200}));
  connect(Resorvoir5.o,pipe5. i)
    annotation (Line(points={{-80,-26},{-60,-26}},
                                                 color={28,108,200}));
  connect(pipe5.o, RoundedExpansion.i)
    annotation (Line(points={{-40,-26},{-10,-26}}, color={28,108,200}));
  connect(RoundedExpansion.o, tail5.i)
    annotation (Line(points={{10,-26},{40,-26}}, color={28,108,200}));
  connect(tail5.o,tailwater5. o)
    annotation (Line(points={{60,-26},{80,-26}},
                                               color={28,108,200}));
  connect(Resorvoir6.o,pipe6. i)
    annotation (Line(points={{-80,-50},{-60,-50}},
                                                 color={28,108,200}));
  connect(tail6.o,tailwater6. o)
    annotation (Line(points={{60,-50},{80,-50}},
                                               color={28,108,200}));
  connect(tail6.i, RoundedReduction.i)
    annotation (Line(points={{40,-50},{12,-50}}, color={28,108,200}));
  connect(pipe6.o, RoundedReduction.o)
    annotation (Line(points={{-40,-50},{-8,-50}}, color={28,108,200}));
  connect(Resorvoir7.o,pipe7. i)
    annotation (Line(points={{-80,-70},{-60,-70}},
                                                 color={28,108,200}));
  connect(tail7.o,tailwater7. o)
    annotation (Line(points={{60,-70},{80,-70}},
                                               color={28,108,200}));
  connect(tail7.i, SharpOrifice.i)
    annotation (Line(points={{40,-70},{12,-70}}, color={28,108,200}));
  connect(pipe7.o, SharpOrifice.o)
    annotation (Line(points={{-40,-70},{-8,-70}}, color={28,108,200}));
  connect(Resorvoir8.o,pipe8. i)
    annotation (Line(points={{-80,-90},{-60,-90}},
                                                 color={28,108,200}));
  connect(tail8.o,tailwater8. o)
    annotation (Line(points={{60,-90},{80,-90}},
                                               color={28,108,200}));
  connect(tail8.i, ThickOrifice.i)
    annotation (Line(points={{40,-90},{12,-90}}, color={28,108,200}));
  connect(pipe8.o, ThickOrifice.o)
    annotation (Line(points={{-40,-90},{-8,-90}}, color={28,108,200}));
  annotation (experiment(StopTime=100));
end HPAllTypeFittingsTest;
