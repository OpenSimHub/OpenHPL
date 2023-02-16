within OpenHPL.Tests;
model HPSimpleElasticPenstockWithoutSurge "Model of HP system without surge tank and with elastic penctock (StagardGrid), but simplified models for turbine, etc."
  extends Modelica.Icons.Example;
  Waterway.Reservoir reservoir annotation (Placement(transformation(
        origin={-90,62},
        extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = -0.03, offset = 0.5, startTime = 500) annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, origin = {10, 84})));
  inner OpenHPL.Data data annotation (Placement(transformation(
        origin={-90,92},
        extent={{-10,-10},{10,10}})));
  Waterway.Pipe intake(Vdot_0=20.6) annotation (Placement(transformation(extent={{-58,52},{-38,72}})));
  Waterway.Pipe discharge(
    H=5,
    L=600,
    Vdot_0=20.6) annotation (Placement(transformation(extent={{48,26},{68,46}})));
  Waterway.Reservoir tail(h_0=10) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={92,42})));
  Waterway.Penstock penstock1(N=10, Vdot_0=20.6) annotation (Placement(transformation(
        origin={-6,48},
        extent={{-10,-10},{10,10}})));
  ElectroMech.Turbines.Turbine turbine1(WaterCompress=true) annotation (Placement(transformation(
        origin={24,36},
        extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp load(duration = 1, height = -5e6, offset = 80e6, startTime = 600) annotation (
    Placement(transformation(extent = {{-16, 0}, {4, 20}})));
  OpenHPL.ElectroMech.Generators.SimpleGen aggregate annotation (Placement(transformation(extent={{14,2},{34,22}})));
equation
  connect(load.y, aggregate.u) annotation (
    Line(points = {{5, 10}, {9.5, 10}, {9.5, 12}, {14, 12}}, color = {0, 0, 127}));
  connect(turbine1.P_out, aggregate.P_in) annotation (
    Line(points = {{20, 25}, {20, 22}}, color = {0, 0, 127}));
  connect(turbine1.u_t, control.y) annotation (
    Line(points={{16,48},{27,48},{27,48.8},{24,48.8},{24,84},{21,84}}, color = {0, 0, 127}));
  connect(reservoir.n, intake.p) annotation (
    Line(points = {{-79.9, 61.9}, {-68, 61.9}, {-68, 61.9}, {-57.9, 61.9}}, color = {28, 108, 200}));
  connect(penstock1.p, intake.n) annotation (
    Line(points = {{-15.9, 47.9}, {-26, 47.9}, {-26, 61.9}, {-37.9, 61.9}}, color = {28, 108, 200}));
  connect(tail.n, discharge.n) annotation (
    Line(points = {{81.9, 41.9}, {76, 41.9}, {76, 35.9}, {68.1, 35.9}}, color = {28, 108, 200}));
  connect(turbine1.n, discharge.p) annotation (
    Line(points = {{34.1, 35.9}, {40, 35.9}, {48.1, 35.9}}, color = {28, 108, 200}));
  connect(turbine1.p, penstock1.n) annotation (
    Line(points = {{14.1, 35.9}, {10, 35.9}, {10, 47.9}, {4.1, 47.9}}, color = {28, 108, 200}));
  annotation (
    experiment(StopTime = 1000, StartTime = 0, Tolerance = 0.0001, Interval = 2));
end HPSimpleElasticPenstockWithoutSurge;
