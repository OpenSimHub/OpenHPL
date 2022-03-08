within OpenHPL.Examples;
model BranchingPipes "Model of branching pipes"
  extends Modelica.Icons.Example;
  Waterway.Reservoir reservoir(H_0=50)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Waterway.Pipe mainPipe(
    H=5,
    L=100,
    D_i=6,
    Vdot_0=20) annotation (Placement(transformation(extent={{-52,-10},{-32,10}})));
  Waterway.Reservoir reservoir1(H_0=35) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={70,0})));
  Waterway.Pipe branch1(
    H=5,
    L=100,
    D_i=3,
    Vdot_0=10) annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Waterway.Pipe branch2(
    H=5,
    L=100,
    D_i=3,
    Vdot_0=10) annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  Waterway.Pipe mainPipeOut(
    H=5,
    L=100,
    D_i=5,
    Vdot_0=20) annotation (Placement(transformation(extent={{30,-10},{50,10}})));
equation
  connect(reservoir.o, mainPipe.i) annotation (Line(points={{-60,0},{-52,0}},
                             color={28,108,200}));
  connect(branch1.i, mainPipe.o) annotation (Line(points={{-10,20},{-20,20},{-20,0},{-32,0}},
                             color={28,108,200}));
  connect(mainPipe.o, branch2.i) annotation (Line(points={{-32,0},{-20,0},{-20,-20},{-10,-20}},
                           color={28,108,200}));
  connect(branch2.o, mainPipeOut.i) annotation (Line(points={{10,-20},{20,-20},{20,0},{30,0}},
                        color={28,108,200}));
  connect(reservoir1.o, mainPipeOut.o)
    annotation (Line(points={{60,8.88178e-16},{48,8.88178e-16},{48,0},{50,0}},
                                               color={28,108,200}));
  connect(branch1.o, mainPipeOut.i) annotation (Line(points={{10,20},{20,20},{20,0},{30,0}},
                        color={28,108,200}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end BranchingPipes;
