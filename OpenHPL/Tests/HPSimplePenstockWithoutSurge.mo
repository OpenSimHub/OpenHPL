within OpenHPL.Tests;
model HPSimplePenstockWithoutSurge "Model of HP system without surge tank and with simplified models for penstock, turbine, etc."
  extends Modelica.Icons.Example;
  Waterway.Reservoir reservoir(H_r=48) annotation (Placement(visible=true, transformation(
        origin={-54,66},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = 0.2, offset = 0.7493, startTime = 600) annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {10, 84})));
  inner OpenHPL.Data data annotation (Placement(visible=true, transformation(
        origin={-90,92},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.Pipe intake(H=23) annotation (Placement(visible=true, transformation(extent={{-34,56},{-14,76}}, rotation=0)));
  Waterway.Pipe discharge(H=0.5, L=2000) annotation (Placement(visible=true, transformation(extent={{50,28},{70,48}}, rotation=0)));
  Waterway.Reservoir tail(H_r=5) annotation (Placement(visible=true, transformation(
        origin={94,42},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Waterway.Pipe penstock(
    D_i=3,
    D_o=3,
    H=428.5,
    L=600) annotation (Placement(visible=true, transformation(
        origin={0,52},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  ElectroMech.Turbines.Turbine turbine1(C_v=3.7) annotation (Placement(visible=true, transformation(
        origin={28,42},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp load(duration = 1, height = -5e6, offset = 80e6, startTime = 600) annotation (
    Placement(visible = true, transformation(extent = {{-12, 0}, {8, 20}}, rotation = 0)));
  ElectroMech.Generators.SimpleGen aggregate(UseFrequencyOutput=true) annotation (Placement(visible=true, transformation(extent={{18,0},{38,20}}, rotation=0)));
equation
  connect(turbine1.P_out, aggregate.P_in) annotation (
    Line(points = {{28, 32}, {28, 32}, {28, 20}, {28, 20}}, color = {0, 0, 127}));
  connect(turbine1.u_t, control.y) annotation (
    Line(points = {{28, 52.8}, {28, 84}, {21, 84}}, color = {0, 0, 127}));
  connect(reservoir.n, intake.p) annotation (
    Line(points = {{-43.9, 65.9}, {-38.95, 65.9}, {-33.9, 65.9}}, color = {28, 108, 200}));
  connect(intake.n, penstock.p) annotation (
    Line(points = {{-13.9, 65.9}, {-5.95, 65.9}, {-5.95, 61.9}, {-0.1, 61.9}}, color = {28, 108, 200}));
  connect(penstock.n, turbine1.p) annotation (
    Line(points = {{-0.1, 41.9}, {9.95, 41.9}, {18.1, 41.9}}, color = {28, 108, 200}));
  connect(turbine1.n, discharge.p) annotation (
    Line(points = {{38.1, 41.9}, {44.05, 41.9}, {44.05, 37.9}, {50.1, 37.9}}, color = {28, 108, 200}));
  connect(discharge.n, tail.n) annotation (
    Line(points = {{70.1, 37.9}, {77.05, 37.9}, {77.05, 41.9}, {83.9, 41.9}}, color = {28, 108, 200}));
  connect(load.y, aggregate.u) annotation (
    Line(points = {{9, 10}, {9, 10}, {18, 10}}, color = {0, 0, 127}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPSimplePenstockWithoutSurge;
