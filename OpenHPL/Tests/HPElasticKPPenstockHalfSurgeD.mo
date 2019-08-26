within OpenHPL.Tests;
model HPElasticKPPenstockHalfSurgeD "Similar to previous HP system, but with twice reduced surge tank diameter"
  extends Modelica.Icons.Example;
  Waterway.Reservoir reservoir annotation (Placement(visible=true, transformation(
        origin={-92,66},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = -0.04615, offset = 0.7493, startTime = 1200) annotation (
    Placement(visible = true, transformation(origin = {0, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner OpenHPL.Constants Const annotation (
    Placement(visible = true, transformation(origin = {-90, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp load(duration = 1, height = -5e6, offset = 80e6, startTime = 1200) annotation (
    Placement(visible = true, transformation(extent = {{-20, 2}, {0, 22}}, rotation = 0)));
  Waterway.Pipe intake(V_dot0=19) annotation (Placement(visible=true, transformation(extent={{-74,56},{-54,76}}, rotation=0)));
  Waterway.Pipe discharge(
    H=5,
    L=600,
    V_dot0=19) annotation (Placement(visible=true, transformation(extent={{38,28},{58,48}}, rotation=0)));
  Waterway.Reservoir tail(H_r=10) annotation (Placement(visible=true, transformation(
        origin={78,38},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  ElectroMech.Generators.SimpleGen aggregate(w_0=52) annotation (Placement(visible=true, transformation(extent={{8,2},{28,22}}, rotation=0)));
  ElectroMech.Turbines.Turbine turbine(C_v=3.7, WaterCompress=true) annotation (Placement(visible=true, transformation(extent={{8,32},{28,52}}, rotation=0)));
  Waterway.PenstockKP penstockKP(N=20, V_dot0=19*ones(20)) annotation (Placement(visible=true, transformation(extent={{-18,42},{2,62}}, rotation=0)));
  Waterway.SurgeTank surgeTank(D=1.7) annotation (Placement(visible=true, transformation(extent={{-44,60},{-24,80}}, rotation=0)));
equation
  connect(turbine.P_out, aggregate.P_in) annotation (
    Line(points = {{18, 32}, {18, 32}, {18, 22}, {18, 22}}, color = {0, 0, 127}));
  connect(load.y, aggregate.u) annotation (
    Line(points = {{1, 12}, {8, 12}}, color = {0, 0, 127}));
  connect(discharge.p, turbine.n) annotation (
    Line(points = {{38.1, 37.9}, {31, 37.9}, {31, 41.9}, {28.1, 41.9}}));
  connect(discharge.n, tail.n) annotation (
    Line(points = {{58.1, 37.9}, {62, 37.9}, {62, 38}, {63.9, 38}, {63.9, 37.9}, {67.9, 37.9}}));
  connect(control.y, turbine.u_t) annotation (
    Line(points = {{11, 84}, {18, 84}, {18, 52.8}}, color = {0, 0, 127}));
  connect(intake.n, surgeTank.p) annotation (
    Line(points = {{-53.9, 65.9}, {-49, 65.9}, {-49, 69.9}, {-43.9, 69.9}}));
  connect(intake.p, reservoir.n) annotation (
    Line(points = {{-73.9, 65.9}, {-76, 65.9}, {-76, 66}, {-77.9, 66}, {-77.9, 65.9}, {-81.9, 65.9}}));
  connect(surgeTank.n, penstockKP.p) annotation (
    Line(points = {{-23.9, 69.9}, {-17.9, 69.9}, {-17.9, 51.9}}, color = {0, 0, 0}));
  connect(penstockKP.n, turbine.p) annotation (
    Line(points = {{2.1, 51.9}, {2.1, 41.9}, {8.1, 41.9}}, color = {0, 0, 0}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPElasticKPPenstockHalfSurgeD;
