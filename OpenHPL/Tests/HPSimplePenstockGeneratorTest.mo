within OpenHPL.Tests;
model HPSimplePenstockGeneratorTest "Generator testing for HP"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  Waterway.Reservoir reservoir(h_0=48) annotation (Placement(visible=true, transformation(
        origin={-92,62},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(startTime = 600, duration = 1, height = -0.14615, offset = 0.6493) annotation (
    Placement(visible = true, transformation(origin = {12, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp load(offset = 80e6, height = -40e6, startTime = 600, duration = 1) annotation (
    Placement(visible = true, transformation(extent = {{52, -28}, {72, -8}}, rotation = 0)));
  Waterway.Pipe intake(H=23) annotation (Placement(visible=true, transformation(extent={{-64,52},{-44,72}}, rotation=0)));
  Waterway.Pipe discharge(L=600, H=0.5) annotation (Placement(visible=true, transformation(extent={{46,26},{66,46}}, rotation=0)));
  Waterway.Reservoir tail(h_0=5) annotation (Placement(visible=true, transformation(
        origin={92,42},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Waterway.PenstockKP penstock(
    L=600,
    H=428.5,
    D_i=3,
    D_o=3,
    N=10) annotation (Placement(visible=true, transformation(
        origin={0,46},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  Waterway.SurgeTank surgeTank(h_0=71) annotation (Placement(visible=true, transformation(
        origin={-22,66},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.ElectroMech.Turbines.Turbine turbine(C_v=3.7) annotation (Placement(visible=true, transformation(
        origin={26,36},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner OpenHPL.Data data annotation (Placement(visible=true, transformation(
        origin={-90,92},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Generators.SynchGen generator(k_b=1000, J=850000) annotation (Placement(transformation(extent={{18,-4},{38,16}})));
  Controllers.Governor governor(
    delta=0.04,
    droop=0.1,
    T_g=0.2,
    T_r=1.75) annotation (Placement(transformation(extent={{64,96},{44,76}})));
  Modelica.Blocks.Sources.RealExpression frequency(y = generator.w * generator.np / 4 / pi) annotation (
    Placement(transformation(extent = {{84, 54}, {64, 74}})));
  Modelica.Blocks.Sources.RealExpression Power(y = generator.Pe) annotation (
    Placement(transformation(extent = {{92, 70}, {72, 90}})));
equation
  connect(governor.Y_gv, turbine.u_t) annotation (
    Line(points = {{44, 86}, {36, 86}, {36, 78}, {26, 78}, {26, 47}}, color = {0, 0, 127}));
  connect(turbine.p, penstock.n) annotation (
    Line(points = {{16, 36}, {9, 36}, {9, 35.9}, {-0.1, 35.9}}));
  connect(turbine.n, discharge.p) annotation (
    Line(points = {{36, 36}, {42.1, 36}, {42.1, 35.9}, {46.1, 35.9}}));
  connect(turbine.P_out, generator.P_in) annotation (
    Line(points = {{22, 25}, {22, 16}}, color = {0, 0, 127}));
  connect(discharge.n, tail.n) annotation (
    Line(points = {{66.1, 35.9}, {76, 35.9}, {76, 41.9}, {81.9, 41.9}}));
  connect(intake.p, reservoir.n) annotation (
    Line(points = {{-63.9, 61.9}, {-66, 61.9}, {-66, 62}, {-67.9, 62}, {-67.9, 61.9}, {-81.9, 61.9}}));
  connect(intake.n, surgeTank.p) annotation (
    Line(points = {{-43.9, 61.9}, {-40, 61.9}, {-40, 65.9}, {-31.9, 65.9}}));
  connect(surgeTank.n, penstock.p) annotation (
    Line(points = {{-11.9, 65.9}, {-0.1, 65.9}, {-0.1, 55.9}}));
  connect(governor.P_ref, load.y) annotation (
    Line(points = {{64, 86}, {82, 86}, {100, 86}, {100, -18}, {73, -18}}, color = {0, 0, 127}));
  connect(governor.f, frequency.y) annotation (
    Line(points = {{54, 76}, {54, 64}, {63, 64}}, color = {0, 0, 127}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPSimplePenstockGeneratorTest;
