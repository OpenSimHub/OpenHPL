within OpenHPL.Examples;
model HPSimpleBranching "Model of branching pipes"
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir headrace(H_r=48) annotation (Placement(visible=
          true, transformation(
        origin={-90,30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe mainUpstream(
    H=50,
    L=100,
    D_i=6,
    V_dot0=20) annotation (Placement(visible=true, transformation(extent={{-70,
            20},{-50,40}}, rotation=0)));
  inner OpenHPL.Parameters para annotation (Placement(visible=true, transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.Pipe         branch2(
    H=5,
    L=100,
    D_i=4,
    V_dot0=10)                       annotation (Placement(visible=true, transformation(extent={{-38,2},
            {-18,22}},                                                                                              rotation=0)));
  Waterway.Pipe         branch1(
    H=5,
    L=100,
    D_i=2,
    V_dot0=10)                       annotation (Placement(visible=true, transformation(extent={{-36,28},
            {-16,48}},                                                                                              rotation=0)));
  Waterway.Pipe mainDownstream(
    H=5,
    L=100,
    D_i=6,
    V_dot0=20) annotation (Placement(visible=true, transformation(extent={{4,16},
            {24,36}}, rotation=0)));
  Waterway.Reservoir tailrace(H_r=35) annotation (Placement(visible=true,
        transformation(
        origin={50,26},
        extent={{-10,-10},{10,10}},
        rotation=180)));
equation
  connect(headrace.o, mainUpstream.i)
    annotation (Line(points={{-80,30},{-70,30}}, color={28,108,200}));
  connect(mainUpstream.o, branch1.i) annotation (Line(points={{-50,30},{-44,30},
          {-44,38},{-36,38}}, color={28,108,200}));
  connect(mainUpstream.o, branch2.i) annotation (Line(points={{-50,30},{-44,30},
          {-44,12},{-38,12}}, color={28,108,200}));
  connect(branch2.o, mainDownstream.i) annotation (Line(points={{-18,12},{-8,12},
          {-8,26},{4,26}}, color={28,108,200}));
  connect(branch1.o, mainDownstream.i) annotation (Line(points={{-16,38},{-8,38},
          {-8,26},{4,26}}, color={28,108,200}));
  connect(mainDownstream.o, tailrace.o)
    annotation (Line(points={{24,26},{40,26}}, color={28,108,200}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPSimpleBranching;
