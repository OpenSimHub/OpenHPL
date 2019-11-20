within OpenHPL.Tests;
model HPSimplePenstockPowerControl
  extends Modelica.Icons.Example;
  Waterway.Reservoir reservoir annotation (Placement(visible=true, transformation(
        origin={-92,62},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner OpenHPL.Parameters para annotation (Placement(visible=true, transformation(
        origin={-90,92},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.Pipe intake(V_dot0=19) annotation (Placement(visible=true, transformation(extent={{-64,52},{-44,72}}, rotation=0)));
  Waterway.Pipe discharge(
    H=5,
    L=600,
    V_dot0=19) annotation (Placement(visible=true, transformation(extent={{48,26},{68,46}}, rotation=0)));
  Waterway.Reservoir tail(H_r=10) annotation (Placement(visible=true, transformation(
        origin={86,42},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  ElectroMech.Generators.SimpleGen aggregate(w_0=52.4, J=1.25e5) annotation (Placement(visible=true, transformation(extent={{16,-4},{36,16}}, rotation=0)));
  Waterway.Pipe penstock(
    H=420,
    L=600,
    D_i=3.3,
    D_o=3.3,
    V_dot0=19) annotation (Placement(visible=true, transformation(
        origin={-2,46},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.SurgeTank surgeTank annotation (Placement(visible=true, transformation(
        origin={-22,66},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Turbines.Turbine turbine(C_v=3.7) annotation (Placement(visible=true, transformation(
        origin={26,36},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp load(duration = 1, height = -3e6, offset = 80e6, startTime = 400) annotation (
    Placement(visible = true, transformation(extent = {{-20, -4}, {0, 16}}, rotation = 0)));
  Controllers.GovernorPower govenorPower annotation (Placement(transformation(extent={{56,86},{36,66}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y = aggregate.W_ts_dot) annotation (
    Placement(transformation(extent = {{92, 72}, {72, 92}})));
equation
  connect(turbine.P_out, aggregate.P_in) annotation (
    Line(points = {{26, 26}, {26, 26}, {26, 16}, {26, 16}}, color = {0, 0, 127}));
  connect(discharge.n, tail.n) annotation (
    Line(points = {{68.1, 35.9}, {72, 35.9}, {72, 41.9}, {75.9, 41.9}}));
  connect(turbine.n, discharge.p) annotation (
    Line(points = {{36.1, 35.9}, {42.1, 35.9}, {48.1, 35.9}}));
  connect(turbine.p, penstock.n) annotation (
    Line(points = {{16.1, 35.9}, {12, 35.9}, {12, 45.9}, {8.1, 45.9}}));
  connect(intake.p, reservoir.n) annotation (
    Line(points = {{-63.9, 61.9}, {-66, 61.9}, {-66, 62}, {-67.9, 62}, {-67.9, 61.9}, {-81.9, 61.9}}));
  connect(intake.n, surgeTank.p) annotation (
    Line(points = {{-43.9, 61.9}, {-40, 61.9}, {-40, 65.9}, {-31.9, 65.9}}));
  connect(surgeTank.n, penstock.p) annotation (
    Line(points = {{-11.9, 65.9}, {-11.9, 65.9}, {-11.9, 45.9}}));
  connect(aggregate.u, load.y) annotation (
    Line(points = {{16, 6}, {10, 6}, {1, 6}}, color = {0, 0, 127}));
  connect(govenorPower.Y_gv, turbine.u_t) annotation (
    Line(points = {{36, 76}, {30, 76}, {30, 78}, {26, 78}, {26, 46.8}}, color = {0, 0, 127}));
  connect(govenorPower.f, aggregate.f) annotation (
    Line(points = {{46, 66}, {46, 66}, {46, 16}, {46, 6}, {36, 6}}, color = {0, 0, 127}));
  connect(govenorPower.P_ref, load.y) annotation (
    Line(points = {{56, 76}, {96, 76}, {96, -12}, {6, -12}, {6, 6}, {1, 6}}, color = {0, 0, 127}));
  connect(govenorPower.P, realExpression.y) annotation (
    Line(points = {{56, 82}, {71, 82}}, color = {0, 0, 127}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPSimplePenstockPowerControl;
