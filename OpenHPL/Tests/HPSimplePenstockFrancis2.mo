within OpenHPL.Tests;
model HPSimplePenstockFrancis2 "HP system model with Francis turbine and generator"
  extends Modelica.Icons.Example;
  Waterway.Reservoir reservoir(h_0=48) annotation (Placement(transformation(
        origin={-92,62},
        extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp control(duration = 1980, height = 0.87, offset = 0.09, startTime = 10) annotation (
    Placement(transformation(origin = {10, 84}, extent = {{-10, -10}, {10, 10}})));
  OpenHPL.Waterway.Pipe intake(H=23) annotation (Placement(transformation(extent={{-76,52},{-56,72}})));
  Waterway.Pipe discharge(L=600, H=0.5) annotation (Placement(transformation(extent={{54,30},{74,50}})));
  OpenHPL.Waterway.Reservoir tail(h_0=5) annotation (Placement(transformation(
        origin={94,44},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  ElectroMech.Generators.SynchGen generator(P_op=100e6, UseFrequencyOutput=false) annotation (Placement(transformation(extent={{16,-4},{40,20}})));
  Waterway.Pipe penstock(
    L=600,
    H=428.5,
    D_i=3,
    D_o=3) annotation (Placement(transformation(
        origin={-10,48},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  OpenHPL.Waterway.SurgeTank surgeTank(h_0=71) annotation (Placement(transformation(
        origin={-36,66},
        extent={{-10,-10},{10,10}})));
  OpenHPL.ElectroMech.Turbines.Francis turbine(
    D_i=1.632,
    GivenData=true,
    H_n=460,
    P_n=103e6,
    R_1_=2.63/2,
    R_2_=1.55/2,
    R_v_=2.89/2,
    Reduction=0.1,
    Vdot_n=24.3,
    beta1_=110,
    beta2_=162.5,
    dp_v_condition=false,
    k_ft1_=7e5,
    k_ft2_=0e3,
    k_ft3_=1.63e4,
    k_fv=0e3,
    n_n=500,
    w_1_=0.2,
    w_v_=0.2) annotation (Placement(transformation(
        origin={28,36},
        extent={{-10,-10},{10,10}})));
  inner OpenHPL.Data data(Vdot_0=4.54) annotation (Placement(transformation(
        origin={-90,92},
        extent={{-10,-10},{10,10}})));
  Waterway.Fitting fitting(D_1=3, D_2=1.63) annotation (Placement(transformation(extent={{-4,20},{16,40}})));
equation
  connect(generator.w_out, turbine.w_in) annotation (
    Line(points = {{36, 20}, {32, 20}, {32, 26}, {32, 26}}, color = {0, 0, 127}));
  connect(turbine.P_out, generator.P_in) annotation (
    Line(points = {{24, 26}, {22, 26}, {22, 20}, {20, 20}}, color = {0, 0, 127}));
  connect(reservoir.n, intake.p) annotation (
    Line(points = {{-81.9, 61.9}, {-78, 61.9}, {-78, 61.9}, {-75.9, 61.9}}, color = {28, 108, 200}));
  connect(surgeTank.p, intake.n) annotation (
    Line(points = {{-45.9, 65.9}, {-48, 65.9}, {-48, 61.9}, {-55.9, 61.9}}, color = {28, 108, 200}));
  connect(surgeTank.n, penstock.p) annotation (
    Line(points = {{-25.9, 65.9}, {-16.95, 65.9}, {-16.95, 57.9}, {-10.1, 57.9}}, color = {28, 108, 200}));
  connect(turbine.n, discharge.p) annotation (
    Line(points = {{38.1, 35.9}, {48, 35.9}, {48, 39.9}, {54.1, 39.9}}, color = {28, 108, 200}));
  connect(control.y, turbine.u_t) annotation (
    Line(points = {{21, 84}, {28, 84}, {28, 46.8}}, color = {0, 0, 127}));
  connect(turbine.p, fitting.n) annotation (
    Line(points = {{18.1, 35.9}, {18.1, 29.9}, {16.1, 29.9}}, color = {28, 108, 200}));
  connect(tail.n, discharge.n) annotation (
    Line(points = {{83.9, 43.9}, {83.9, 41.95}, {80, 41.95}, {80, 39.9}, {74.1, 39.9}}, color = {28, 108, 200}));
  connect(penstock.n, fitting.p) annotation (
    Line(points = {{-10.1, 37.9}, {-6, 37.9}, {-6, 29.9}, {-3.9, 29.9}}, color = {28, 108, 200}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4),
    Diagram);
end HPSimplePenstockFrancis2;
