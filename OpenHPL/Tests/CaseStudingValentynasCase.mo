within OpenHPL.Tests;
model CaseStudingValentynasCase "HP system model for Valentyna's Master case"
  extends Modelica.Icons.Example;
  Real coef2, coef3;
  OpenHPL.Waterway.Reservoir reservoir(H_r=48) annotation (Placement(visible=true, transformation(
        origin={-92,68},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(duration = 1980, height = 0.75, offset = 0.04, startTime = 10) annotation (
    Placement(visible = true, transformation(origin = {10, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe intake(
    D_i=5,
    D_o=5,
    H=15.5,
    L=3000) annotation (Placement(visible=true, transformation(extent={{-78,58},{-58,78}}, rotation=0)));
  OpenHPL.Waterway.Pipe discharge(
    D_i=5,
    D_o=5,
    H=0.5,
    L=600) annotation (Placement(visible=true, transformation(extent={{50,4},{70,24}}, rotation=0)));
  Waterway.Reservoir tail(H_r=5) annotation (Placement(visible=true, transformation(
        origin={94,18},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.ElectroMech.Generators.SynchGen generator(UseFrequencyOutput=false) annotation (Placement(visible=true, transformation(extent={{24,-18},{44,2}}, rotation=0)));
  Waterway.Pipe penstock(
    D_i=4,
    D_o=4,
    H=133,
    L=300) annotation (Placement(visible=true, transformation(
        origin={-26,62},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  OpenHPL.ElectroMech.Turbines.Francis turbine(
    D_i=1.73,
    H_n=270,
    P_n=52e6,
    R_1_=2.02/2,
    R_2_=0.773,
    R_Y=2.5,
    R_v_=2.23/2,
    Reduction=0.1,
    V_dot_n=20.76,
    beta1_=107,
    beta2_=163.2,
    dp_v_condition=false,
    k_ft1_=120e3,
    k_ft2_=0e3,
    k_ft3_=6e3,
    n_n=500,
    r_Y=1,
    r_v=0.9,
    u_end=2.11,
    u_start=2,
    w_1_=0.26,
    w_v_=0.259) annotation (Placement(visible=true, transformation(
        origin={34,20},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner OpenHPL.Parameters para(V_0=5.2) annotation (Placement(visible=true, transformation(
        origin={-90,92},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Fitting fitting(D_1=3, D_2=1.73) annotation (Placement(visible=true, transformation(extent={{0,-4},{20,16}}, rotation=0)));
  OpenHPL.Waterway.Pipe penstock1(
    D_i=3,
    D_o=3,
    H=89,
    L=200) annotation (Placement(visible=true, transformation(
        origin={-10,18},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  Waterway.Fitting fitting1(D_1=4, D_2=3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-16,40})));
  Waterway.SurgeTank surgeTank(D=4.5, h_0=48 + 45.5) annotation (Placement(visible=true, transformation(
        origin={-42,74},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  connect(generator.w_out, turbine.w_in) annotation (
    Line(points={{40,2},{38,2},{38,10},{38,9.8},{38,9.8}},          color = {0, 0, 127}));
  connect(turbine.P_out, generator.P_in) annotation (
    Line(points={{34,9},{28,9},{28,2},{28,2}},            color = {0, 0, 127}));
  connect(intake.n, surgeTank.p) annotation (
    Line(points={{-58,68},{-54,68},{-54,74},{-52,74}},                      color = {28, 108, 200}));
  connect(reservoir.n, intake.p) annotation (
    Line(points={{-82,68},{-80,68},{-80,68},{-80,67.6},{-80,68},{-78,68}},                          color = {28, 108, 200}));
  connect(control.y, turbine.u_t) annotation (
    Line(points={{21,80},{34,80},{34,32}},          color = {0, 0, 127}));
  connect(turbine.p, fitting.n) annotation (
    Line(points={{24,20},{20,20},{20,6}},                    color = {28, 108, 200}));
  connect(turbine.n, discharge.p) annotation (
    Line(points={{44,20},{47,20},{47,14},{50,14}},                      color = {28, 108, 200}));
  connect(fitting.p, penstock1.n) annotation (
    Line(points={{0,6},{-6,6},{-6,8},{-10,8}},                      color = {28, 108, 200}));
  connect(discharge.n, tail.n) annotation (
    Line(points={{70,14},{76,14},{76,18},{84,18},{84,18}},                        color = {28, 108, 200}));
  connect(penstock1.p, fitting1.n) annotation (
    Line(points={{-10,28},{-14,28},{-14,30},{-16,30}},                      color = {28, 108, 200}));
  coef2 = turbine.W_s_dot / turbine.V_dot / turbine.dp_tr;
  coef3 = turbine.W_s_dot / turbine.V_dot / turbine.dp_r;
  connect(penstock.n, fitting1.p) annotation (
    Line(points={{-26,52},{-26,49.9},{-16,49.9},{-16,50}},                    color = {28, 108, 200}));
  connect(penstock.p, surgeTank.n) annotation (
    Line(points={{-26,72},{-30,72},{-30,74},{-32,74}},                      color = {28, 108, 200}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end CaseStudingValentynasCase;
