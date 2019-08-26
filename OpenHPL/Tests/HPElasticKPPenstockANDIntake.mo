within OpenHPL.Tests;
model HPElasticKPPenstockANDIntake "Model of HP system with elastic penctock and intake (KP), but simplified models for turbine, etc."
  extends Modelica.Icons.Example;
  Waterway.Reservoir reservoir(H_r=48) annotation (Placement(visible=true, transformation(
        origin={-92,66},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(height = -0.04615, duration = 1, offset = 0.7493, startTime = 600) annotation (
    Placement(visible = true, transformation(origin = {0, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner OpenHPL.Constants Const annotation (
    Placement(visible = true, transformation(origin = {-90, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Waterway.Reservoir tail(H_r=5) annotation (Placement(visible=true, transformation(
        origin={78,38},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  ElectroMech.Turbines.Turbine turbine(
    C_v=3.7,
    WaterCompress=true) annotation (Placement(visible=true, transformation(extent={{8,32},{28,52}}, rotation=0)));
  Waterway.PenstockKP penstockKP(
    D_i=3,
    D_o=3,
    H=428.5,
    N=10,
    PipeElasticity=true) annotation (Placement(transformation(extent={{-18,44},{2,64}})));
  Waterway.PenstockKP Intake(
    D_i=5.8,
    D_o=5.8,
    H=23,
    L=6600,
    N=110,
    PipeElasticity=true,
    h_s0=48,
    p_p0=997*9.81*(48 + 23/110/2):997*9.81*23/110:997*9.81*(48 + 23/110*(110 - 1/2))) annotation (Placement(visible=true, transformation(
        origin={-62,68},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.Pipe discharge(
    D_i=5.8,
    D_o=5.8,
    H=0.5,
    L=600) annotation (Placement(visible=true, transformation(
        origin={48,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  connect(reservoir.n, Intake.p) annotation (
    Line(points = {{-81.9, 65.9}, {-72, 65.9}, {-72, 67.9}, {-71.9, 67.9}}, color = {28, 108, 200}));
  connect(control.y, turbine.u_t) annotation (
    Line(points = {{11, 84}, {18, 84}, {18, 52.8}}, color = {0, 0, 127}));
  connect(penstockKP.n, turbine.p) annotation (
    Line(points = {{2.1, 53.9}, {2.1, 41.9}, {8.1, 41.9}}, color = {0, 0, 0}));
  connect(turbine.n, discharge.p) annotation (
    Line(points = {{28.1, 41.9}, {38.1, 41.9}, {38.1, 39.9}}, color = {28, 108, 200}));
  connect(tail.n, discharge.n) annotation (
    Line(points = {{67.9, 37.9}, {64, 37.9}, {64, 39.9}, {58.1, 39.9}}, color = {28, 108, 200}));
  connect(Intake.n, penstockKP.p) annotation (
    Line(points = {{-51.9, 67.9}, {-34.95, 67.9}, {-34.95, 53.9}, {-17.9, 53.9}}, color = {28, 108, 200}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPElasticKPPenstockANDIntake;
