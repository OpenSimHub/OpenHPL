within OpenHPL.Tests;
model HPElasticKPPenstockFrancis "HP system model with Francis turbine and elastic penstock"
  extends Modelica.Icons.Example;
  Waterway.Reservoir reservoir(H_r=48) annotation (Placement(visible=true, transformation(
        origin={-92,66},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = -0.04615, offset = 0.6, startTime = 600) annotation (
    Placement(visible = true, transformation(origin = {18, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner OpenHPL.Constants Const annotation (
    Placement(visible = true, transformation(origin = {-90, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Waterway.Pipe intake(H=23) annotation (Placement(visible=true, transformation(extent={{-74,54},{-54,74}}, rotation=0)));
  Waterway.Pipe discharge(L=600, H=0.5) annotation (Placement(visible=true, transformation(extent={{56,30},{76,50}}, rotation=0)));
  Waterway.Reservoir tail(H_r=5) annotation (Placement(visible=true, transformation(
        origin={94,46},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Waterway.SurgeTank surgeTank(h_0=69.9) annotation (Placement(visible=true, transformation(extent={{-44,60},{-24,80}}, rotation=0)));
  Waterway.PenstockKP penstockKP(
    D_i=3,
    D_o=3,
    H=428.5) annotation (Placement(transformation(extent={{-22,44},{-2,64}})));
  OpenHPL.ElectroMech.Turbines.Francis francis(
    D_i=1.632,
    GivenData=true,
    R_1_=2.63/2,
    R_2_=1.55/2,
    R_v_=2.89/2,
    WaterCompress=true,
    beta1_=110,
    k_ft1_=7e5,
    k_ft2_=1,
    k_ft3_=1.57e4,
    r_Y=1.2,
    r_v=1.1,
    w_1_=0.2,
    w_v_=0.2) annotation (Placement(visible=true, transformation(
        origin={42,38},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.ElectroMech.Generators.SynchGen generator(
    P_op=100e6,
    Q_op=62.5e6,
    UseFrequencyOutput=false) annotation (Placement(visible=true, transformation(
        origin={40,4},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  connect(generator.w_out, francis.w_in) annotation (
    Line(points = {{46, 14}, {46, 14}, {46, 28}, {46, 28}, {46, 28}}, color = {0, 0, 127}));
  connect(francis.P_out, generator.P_in) annotation (
    Line(points = {{38, 28}, {34, 28}, {34, 14}, {34, 14}}, color = {0, 0, 127}));
  connect(francis.n, discharge.p) annotation (
    Line(points = {{52.1, 37.9}, {53.1, 37.9}, {53.1, 39.9}, {56.1, 39.9}}, color = {28, 108, 200}));
  connect(control.y, francis.u_t) annotation (
    Line(points = {{29, 84}, {42, 84}, {42, 48.8}}, color = {0, 0, 127}));
  connect(penstockKP.n, francis.p) annotation (
    Line(points = {{-1.9, 53.9}, {32.1, 53.9}, {32.1, 37.9}}, color = {28, 108, 200}));
  connect(discharge.n, tail.n) annotation (
    Line(points = {{76.1, 39.9}, {80, 39.9}, {80, 45.9}, {83.9, 45.9}}, color = {28, 108, 200}));
  connect(surgeTank.n, penstockKP.p) annotation (
    Line(points = {{-23.9, 69.9}, {-21.9, 69.9}, {-21.9, 53.9}}, color = {28, 108, 200}));
  connect(intake.n, surgeTank.p) annotation (
    Line(points = {{-53.9, 63.9}, {-48, 63.9}, {-48, 69.9}, {-43.9, 69.9}}, color = {28, 108, 200}));
  connect(reservoir.n, intake.p) annotation (
    Line(points = {{-81.9, 65.9}, {-78, 65.9}, {-78, 63.9}, {-73.9, 63.9}}, color = {28, 108, 200}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPElasticKPPenstockFrancis;
