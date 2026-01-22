within OpenHPLTest;
model HPElasticKPPenstockWithoutSurge "Model of HP system without surge tank and with elastic penctock (KP), but simplified models for turbine, etc."
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(h_0=48) annotation (Placement(transformation(origin={-90,62}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = -0.04615, offset = 0.7493, startTime = 600) annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, origin = {10, 84})));
  inner OpenHPL.Data data annotation (Placement(transformation(
        origin={-90,92},
        extent={{-10,-10},{10,10}})));
  OpenHPL.Waterway.Pipe discharge(
    H=0.5,
    L=600,
    Vdot_0=19.06) annotation (Placement(transformation(extent={{56,24},{76,44}})));
  OpenHPL.Waterway.Reservoir tail(h_0=5) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={92,42})));
  OpenHPL.Waterway.PenstockKP penstockKP1(
    D_i=3,
    D_o=3,
    H=428.5,
    N=10,
    PipeElasticity=true,
    Vdot_0=19.06*ones(10)) annotation (Placement(transformation(origin={-6,50}, extent={{-10,-10},{10,10}})));
  OpenHPL.ElectroMech.Turbines.Turbine turbine(C_v=3.7, WaterCompres=true) annotation (Placement(transformation(extent={{22,26},{42,46}})));
  OpenHPL.Waterway.Pipe condiut(H=23, Vdot_0=19.06) annotation (Placement(transformation(origin={-48,64}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp load(duration = 1, height = -5e6, offset = 80e6, startTime = 600) annotation (
    Placement(transformation(extent = {{-8, -2}, {12, 18}})));
  OpenHPL.ElectroMech.Generators.SimpleGen unit annotation (Placement(transformation(extent={{22,-2},{42,18}})));
equation
  connect(turbine.P_out, unit.P_in) annotation (
    Line(points = {{32, 26}, {32, 26}, {32, 18}, {32, 18}}, color = {0, 0, 127}));
  connect(condiut.n, penstockKP1.p) annotation (
    Line(points = {{-37.9, 63.9}, {-26, 63.9}, {-26, 49.9}, {-15.9, 49.9}}, color = {28, 108, 200}));
  connect(reservoir.n, condiut.p) annotation (
    Line(points = {{-79.9, 61.9}, {-58, 61.9}, {-58, 63.9}, {-57.9, 63.9}}, color = {28, 108, 200}));
  connect(control.y, turbine.u_t) annotation (
    Line(points = {{21, 84}, {32, 84}, {32, 46.8}}, color = {0, 0, 127}));
  connect(turbine.n, discharge.p) annotation (
    Line(points = {{42.1, 35.9}, {50, 35.9}, {50, 33.9}, {56.1, 33.9}}, color = {28, 108, 200}));
  connect(tail.n, discharge.n) annotation (
    Line(points = {{81.9, 41.9}, {80, 41.9}, {80, 33.9}, {76.1, 33.9}}, color = {28, 108, 200}));
  connect(turbine.p, penstockKP1.n) annotation (
    Line(points = {{22.1, 35.9}, {14, 35.9}, {14, 49.9}, {4.1, 49.9}}, color = {28, 108, 200}));
  connect(load.y, unit.u) annotation (
    Line(points = {{13, 8}, {13, 8}, {22, 8}}, color = {0, 0, 127}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPElasticKPPenstockWithoutSurge;
