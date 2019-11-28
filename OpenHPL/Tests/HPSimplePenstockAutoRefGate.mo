within OpenHPL.Tests;
model HPSimplePenstockAutoRefGate
  extends Modelica.Icons.Example;
  Waterway.Reservoir reservoir annotation (Placement(visible=true, transformation(
        origin={-92,62},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner OpenHPL.Data data annotation (Placement(visible=true, transformation(
        origin={-90,92},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp load(duration = 1, height = -3e6, offset = 80e6, startTime = 1200) annotation (
    Placement(visible = true, transformation(extent = {{-12, -4}, {8, 16}}, rotation = 0)));
  Waterway.Pipe intake(Vdot0=19) annotation (Placement(visible=true, transformation(extent={{-64,52},{-44,72}}, rotation=0)));
  Waterway.Pipe discharge(
    H=5,
    L=600,
    Vdot0=19) annotation (Placement(visible=true, transformation(extent={{48,26},{68,46}}, rotation=0)));
  Waterway.Reservoir tail(H_r=10) annotation (Placement(visible=true, transformation(
        origin={90,42},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  ElectroMech.Generators.SimpleGen aggregate(w_0=52.4) annotation (Placement(visible=true, transformation(extent={{16,-4},{36,16}}, rotation=0)));
  Waterway.Pipe penstock(
    H=420,
    L=600,
    D_i=3.3,
    D_o=3.3,
    Vdot0=19) annotation (Placement(visible=true, transformation(
        origin={-2,46},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  Waterway.SurgeTank surgeTank annotation (Placement(visible=true, transformation(
        origin={-22,66},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Turbines.Turbine turbine(C_v=3.7) annotation (Placement(visible=true, transformation(
        origin={26,36},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Math.Gain gain(k = 9.21104e-09) annotation (
    Placement(transformation(extent = {{20, -28}, {40, -8}})));
  Modelica.Blocks.Math.Add add annotation (
    Placement(transformation(extent = {{58, -34}, {78, -14}})));
  Modelica.Blocks.Sources.Constant const1(k = 0.0124905) annotation (
    Placement(transformation(extent = {{20, -56}, {40, -36}})));
equation
  connect(turbine.P_out, aggregate.P_in) annotation (
    Line(points = {{26, 26}, {26, 26}, {26, 16}, {26, 16}}, color = {0, 0, 127}));
  connect(turbine.n, discharge.p) annotation (
    Line(points = {{36.1, 35.9}, {48.1, 35.9}}));
  connect(turbine.p, penstock.n) annotation (
    Line(points = {{16.1, 35.9}, {-2.1, 35.9}}));
  connect(discharge.n, tail.n) annotation (
    Line(points = {{68.1, 35.9}, {76, 35.9}, {76, 41.9}, {79.9, 41.9}}));
  connect(intake.p, reservoir.n) annotation (
    Line(points = {{-63.9, 61.9}, {-66, 61.9}, {-66, 62}, {-67.9, 62}, {-67.9, 61.9}, {-81.9, 61.9}}));
  connect(intake.n, surgeTank.p) annotation (
    Line(points = {{-43.9, 61.9}, {-40, 61.9}, {-40, 65.9}, {-31.9, 65.9}}));
  connect(surgeTank.n, penstock.p) annotation (
    Line(points = {{-11.9, 65.9}, {-2.1, 65.9}, {-2.1, 55.9}}));
  connect(gain.y, add.u1) annotation (
    Line(points = {{41, -18}, {56, -18}}, color = {0, 0, 127}));
  connect(add.u2, const1.y) annotation (
    Line(points = {{56, -30}, {48, -30}, {48, -46}, {41, -46}}, color = {0, 0, 127}));
  connect(load.y, aggregate.u) annotation (
    Line(points = {{9, 6}, {12.5, 6}, {16, 6}}, color = {0, 0, 127}));
  connect(gain.u, aggregate.u) annotation (
    Line(points = {{18, -18}, {12, -18}, {12, 6}, {16, 6}}, color = {0, 0, 127}));
  connect(add.y, turbine.u_t) annotation (
    Line(points = {{79, -24}, {88, -24}, {100, -24}, {100, 56}, {26, 56}, {26, 46.8}}, color = {0, 0, 127}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 4));
end HPSimplePenstockAutoRefGate;
