within OpenHPL.Examples;
model HPSimpleBranching "Model of branching pipes"
  extends Modelica.Icons.Example;
  Waterway.Reservoir reservoir(H_r=50)
    annotation (Placement(transformation(extent={{-80,4},{-60,24}})));
  Waterway.Pipe mainPipe(
    H=5,
    L=100,
    D_i=6,
    Vdot_0=20) annotation (Placement(transformation(extent={{-52,2},{-32,22}})));
  Waterway.Reservoir reservoir1(H_r=35) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={60,14})));
  Waterway.Pipe branch1(
    H=5,
    L=100,
    D_i=3,
    Vdot_0=10) annotation (Placement(transformation(extent={{-12,16},{8,36}})));
  Waterway.Pipe branch2(
    H=5,
    L=100,
    D_i=3,
    Vdot_0=10) annotation (Placement(transformation(extent={{-12,-6},{8,14}})));
  Waterway.Pipe mainPipeOut(
    H=5,
    L=100,
    D_i=5,
    Vdot_0=20) annotation (Placement(transformation(extent={{22,4},{42,24}})));
equation
  connect(reservoir.o, mainPipe.i) annotation (Line(points={{-60,14},{-56,14},{
          -56,12},{-52,12}}, color={28,108,200}));
  connect(branch1.i, mainPipe.o) annotation (Line(points={{-12,26},{-20,26},{
          -20,12},{-32,12}}, color={28,108,200}));
  connect(mainPipe.o, branch2.i) annotation (Line(points={{-32,12},{-20,12},{
          -20,4},{-12,4}}, color={28,108,200}));
  connect(branch2.o, mainPipeOut.i) annotation (Line(points={{8,4},{14,4},{14,
          14},{22,14}}, color={28,108,200}));
  connect(reservoir1.o, mainPipeOut.o)
    annotation (Line(points={{50,14},{42,14}}, color={28,108,200}));
  connect(branch1.o, mainPipeOut.i) annotation (Line(points={{8,26},{14,26},{14,
          14},{22,14}}, color={28,108,200}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPSimpleBranching;
