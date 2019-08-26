within OpenHPL.Tests;
model HPElasticKPPenstockFrancisGov "HP system model with Francis turbine and elastic penstock and governor"
  extends Modelica.Icons.Example;
  Waterway.Reservoir reservoir(H_r=48) annotation (Placement(visible=true, transformation(
        origin={-92,66},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(startTime = 600, height = -0.4615, duration = 10, offset = 0.6) annotation (
    Placement(visible = true, transformation(origin = {18, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner OpenHPL.Constants Const annotation (
    Placement(visible = true, transformation(origin = {-90, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe intake(H=23) annotation (Placement(visible=true, transformation(extent={{-76,54},{-56,74}}, rotation=0)));
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
    GivenData=true,
    R_1_=2.63/2,
    R_2_=1.55/2,
    beta1_=110,
    k_ft2_=1,
    k_ft3_=1.57e4,
    r_Y=1.2,
    r_v=1.1,
    w_1_=0.2,
    R_v_=2.89/2,
    w_v_=0.2,
    D_i=1.632,
    k_ft1_=7e5,
    WaterCompress=true) annotation (Placement(visible=true, transformation(
        origin={40,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.ElectroMech.Generators.SynchGen generator(P_op=100e6, Q_op=62.5e6) annotation (Placement(visible=true, transformation(
        origin={40,10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Controllers.Governor govenor(
    a=7.862E-25,
    c=1.108E-08,
    d=-5.344E-02,
    b=-1.010E-16) annotation (Placement(transformation(extent={{74,68},{54,88}})));
  Modelica.Blocks.Sources.Ramp Power(startTime = 600, height = -81e6, duration = 10, offset = 81e6) annotation (
    Placement(visible = true, transformation(origin = {90, 78}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Waterway.Fitting fitting(D_1=3, D_2=1.632) annotation (Placement(transformation(extent={{4,30},{24,50}})));
equation
  connect(govenor.f, generator.f) annotation (
    Line(points = {{64, 88}, {64, 98}, {78, 98}, {78, 10}, {50, 10}}, color = {0, 0, 127}));
  connect(generator.P_in, francis.P_out) annotation (
    Line(points = {{34, 20}, {36, 20}, {36, 30}}, color = {0, 0, 127}));
  connect(generator.w_out, francis.w_in) annotation (
    Line(points = {{46, 20}, {44, 20}, {44, 30}}, color = {0, 0, 127}));
  connect(reservoir.n, intake.p) annotation (
    Line(points = {{-81.9, 65.9}, {-78, 65.9}, {-78, 64}, {-76, 64}}, color = {28, 108, 200}));
  connect(intake.n, surgeTank.p) annotation (
    Line(points = {{-56, 64}, {-48, 64}, {-48, 69.9}, {-43.9, 69.9}}, color = {28, 108, 200}));
  connect(francis.n, discharge.p) annotation (
    Line(points = {{50.1, 39.9}, {50.1, 39.9}, {56.1, 39.9}}, color = {28, 108, 200}));
  connect(discharge.n, tail.n) annotation (
    Line(points = {{76.1, 39.9}, {80, 39.9}, {80, 45.9}, {83.9, 45.9}}, color = {28, 108, 200}));
  connect(surgeTank.n, penstockKP.p) annotation (
    Line(points = {{-23.9, 69.9}, {-21.9, 69.9}, {-21.9, 53.9}}, color = {28, 108, 200}));
  connect(govenor.Y_gv, francis.u_t) annotation (
    Line(points = {{54, 78}, {54, 78}, {40, 78}, {40, 50.8}}, color = {0, 0, 127}));
  connect(Power.y, govenor.P_ref) annotation (
    Line(points = {{79, 78}, {74, 78}}, color = {0, 0, 127}));
  connect(penstockKP.n, fitting.p) annotation (
    Line(points = {{-1.9, 53.9}, {2, 53.9}, {2, 39.9}, {4.1, 39.9}}, color = {28, 108, 200}));
  connect(francis.p, fitting.n) annotation (
    Line(points = {{30.1, 39.9}, {28, 39.9}, {24.1, 39.9}}, color = {28, 108, 200}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPElasticKPPenstockFrancisGov;
