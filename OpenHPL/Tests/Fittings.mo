within OpenHPL.Tests;
model Fittings "Test for comparing fitting behaviour"
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir Resorvoir1(H_r=10)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  OpenHPL.Waterway.Fitting fittingSquareExpansion(
    fit_type=OpenHPL.Types.Fitting.Square,
    D_i=2,
    D_o=4,
    L=4)
    "dp = p_i - p_o; So, dp should be positive when the type is expansion."
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  OpenHPL.Waterway.Pipe pipe1(
    H=5,
    L=100,
    D_i=2) annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  OpenHPL.Waterway.Pipe tail1(
    H=0,
    L=100,
    D_i=4) annotation (Placement(transformation(extent={{40,40},{60,60}})));
  OpenHPL.Waterway.Reservoir tailwater1(H_r=10)
    annotation (Placement(transformation(extent={{100,40},{80,60}})));
  inner OpenHPL.Data data(Steady=true) annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Waterway.Reservoir Resorvoir2(H_r=10)
    annotation (Placement(transformation(extent={{-100,12},{-80,32}})));
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
  Waterway.Reservoir tailwater2(H_r=10)
    annotation (Placement(transformation(extent={{100,12},{80,32}})));
  Waterway.Fitting         fittingSquareExpansion1(
    fit_type=OpenHPL.Types.Fitting.Square,
    D_i=4,
    D_o=2,
    L=4)
    "dp = p_i - p_o; So, dp should be positive when the type is expansion."
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,22})));
  Waterway.Reservoir Resorvoir3(H_r=10)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,-20})));
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
  Waterway.Reservoir tailwater3(H_r=10)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-90,-20})));
  Waterway.Fitting         fittingSquareExpansion3(
    fit_type=OpenHPL.Types.Fitting.Square,
    D_i=2,
    D_o=4,
    L=4)
    "dp = p_i - p_o; So, dp should be positive when the type is expansion."
    annotation (Placement(transformation(extent={{-12,-30},{8,-10}})));
  Waterway.Reservoir Resorvoir4(H_r=10)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,-58})));
  Waterway.Pipe         pipe4(
    H=0,
    L=100,
    D_i=4)                          annotation (Placement(transformation(extent={{-60,-68},
            {-40,-48}})));
  Waterway.Pipe         tail4(
    H=5,
    L=100,
    D_i=2)                          annotation (Placement(transformation(extent={{40,-68},
            {60,-48}})));
  Waterway.Reservoir tailwater4(H_r=10)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-90,-58})));
  Waterway.Fitting         fittingSquareExpansion2(
    fit_type=OpenHPL.Types.Fitting.Square,
    D_i=4,
    D_o=2,
    L=4)
    "dp = p_i - p_o; So, dp should be positive when the type is expansion."
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,-58})));
equation
  connect(Resorvoir1.o, pipe1.i)
    annotation (Line(points={{-80,50},{-60,50}}, color={28,108,200}));
  connect(pipe1.o, fittingSquareExpansion.i)
    annotation (Line(points={{-40,50},{-10,50}}, color={28,108,200}));
  connect(fittingSquareExpansion.o, tail1.i)
    annotation (Line(points={{10,50},{40,50}}, color={28,108,200}));
  connect(tail1.o, tailwater1.o)
    annotation (Line(points={{60,50},{80,50}}, color={28,108,200}));
  connect(Resorvoir2.o, pipe2.i)
    annotation (Line(points={{-80,22},{-60,22}}, color={28,108,200}));
  connect(tail2.o, tailwater2.o)
    annotation (Line(points={{60,22},{80,22}}, color={28,108,200}));
  connect(tail3.o, Resorvoir3.o)
    annotation (Line(points={{60,-20},{80,-20}}, color={28,108,200}));
  connect(pipe3.i, tailwater3.o)
    annotation (Line(points={{-60,-20},{-80,-20}}, color={28,108,200}));
  connect(pipe2.o, fittingSquareExpansion1.o)
    annotation (Line(points={{-40,22},{-10,22}}, color={28,108,200}));
  connect(tail2.i, fittingSquareExpansion1.i)
    annotation (Line(points={{40,22},{10,22}}, color={28,108,200}));
  connect(pipe3.o, fittingSquareExpansion3.i)
    annotation (Line(points={{-40,-20},{-12,-20}}, color={28,108,200}));
  connect(tail3.i, fittingSquareExpansion3.o)
    annotation (Line(points={{40,-20},{8,-20}}, color={28,108,200}));
  connect(tail4.o, Resorvoir4.o)
    annotation (Line(points={{60,-58},{80,-58}}, color={28,108,200}));
  connect(pipe4.i, tailwater4.o)
    annotation (Line(points={{-60,-58},{-80,-58}}, color={28,108,200}));
  connect(pipe4.o, fittingSquareExpansion2.o)
    annotation (Line(points={{-40,-58},{-10,-58}}, color={28,108,200}));
  connect(tail4.i, fittingSquareExpansion2.i)
    annotation (Line(points={{40,-58},{10,-58}}, color={28,108,200}));
  annotation (experiment(StopTime=100));
end Fittings;
