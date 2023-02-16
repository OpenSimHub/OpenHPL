within OpenHPL.Tests;
model HPElasticKPPenstock "Model of HP system with elastic penctock (KP), but simplified models for turbine, etc."
  extends Modelica.Icons.Example;
  Waterway.Reservoir reservoir(h_0=48) annotation (Placement(transformation(
        origin={-92,66},
        extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = -0.04615, offset = 0.7493, startTime = 600) annotation (
    Placement(transformation(origin={0,84}, extent = {{-10, -10}, {10, 10}})));
  inner OpenHPL.Data data(Vdot_0=19.12, rho(displayUnit="kg/m3") = 997) annotation (Placement(transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}})));
  Waterway.Pipe intake(H=23) annotation (Placement(transformation(extent={{-72,54},{-52,74}})));
  Waterway.Pipe discharge(H=0.5, L=600) annotation (Placement(transformation(extent={{38,30},{58,50}})));
  Waterway.Reservoir tail(h_0=5) annotation (Placement(transformation(
        origin={90,46},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  ElectroMech.Turbines.Turbine turbine(C_v=3.7, WaterCompress=true) annotation (Placement(transformation(extent={{8,32},{28,52}})));
  Waterway.SurgeTank surgeTank(h_0=69.9) annotation (Placement(transformation(extent={{-42,60},{-22,80}})));
  Waterway.PenstockKP penstockKP(
    D_i=3,
    D_o=3,
    H=428.5,
    N=10,
    PipeElasticity=false,
    h_s0=69.9,
    p_p0=997*data.g*(penstockKP.h_s0 + penstockKP.H/penstockKP.N/2):997*data.g*penstockKP.H/penstockKP.N:997*data.g*(penstockKP.h_s0 + penstockKP.H/penstockKP.N*(penstockKP.N - 1/2))) annotation (Placement(transformation(extent={{-20,44},{0,64}})));
  Modelica.Blocks.Sources.Ramp load(duration = 1, height = -5e6, offset = 80e6, startTime = 600) annotation (
    Placement(transformation(extent = {{-22, 0}, {-2, 20}})));
  ElectroMech.Generators.SimpleGen aggregate annotation (Placement(transformation(extent={{8,0},{28,20}})));
equation
  //19.077 * ones(10)
  //, H = 428.5, h_s0 = 69.9, N = 10, p_p0 = 997 * 9.81 * (69.9 + 428.5 / 10 / 2):997 * 9.81 * 428.5 / 10:9.81 * 997 * (69.9 + 428.5 / 10 * (10 - 1 / 2))
  //997 * data.g
  connect(turbine.P_out, aggregate.P_in) annotation (
    Line(points = {{18, 32}, {18, 32}, {18, 22}, {18, 22}, {18, 20}}, color = {0, 0, 127}));
  connect(control.y, turbine.u_t) annotation (
    Line(points={{11,84},{10,84},{10,54}}, color = {0, 0, 127}));
  connect(discharge.n, tail.n) annotation (
    Line(points = {{58.1, 39.9}, {70, 39.9}, {70, 45.9}, {79.9, 45.9}}, color = {28, 108, 200}));
  connect(turbine.n, discharge.p) annotation (
    Line(points = {{28.1, 41.9}, {34, 41.9}, {34, 39.9}, {38.1, 39.9}}, color = {28, 108, 200}));
  connect(turbine.p, penstockKP.n) annotation (
    Line(points = {{8.1, 41.9}, {4, 41.9}, {4, 53.9}, {0.1, 53.9}}, color = {28, 108, 200}));
  connect(surgeTank.n, penstockKP.p) annotation (
    Line(points = {{-21.9, 69.9}, {-19.9, 69.9}, {-19.9, 53.9}}, color = {28, 108, 200}));
  connect(intake.n, surgeTank.p) annotation (
    Line(points = {{-51.9, 63.9}, {-46, 63.9}, {-46, 69.9}, {-41.9, 69.9}}, color = {28, 108, 200}));
  connect(reservoir.n, intake.p) annotation (
    Line(points = {{-81.9, 65.9}, {-76, 65.9}, {-76, 63.9}, {-71.9, 63.9}}, color = {28, 108, 200}));
  connect(load.y, aggregate.u) annotation (
    Line(points = {{-1, 10}, {-1, 10}, {8, 10}}, color = {0, 0, 127}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPElasticKPPenstock;
