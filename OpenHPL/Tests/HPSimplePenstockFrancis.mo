within OpenHPL.Tests;
model HPSimplePenstockFrancis "HP system model with Francis turbine"
  extends Modelica.Icons.Example;
  Waterway.Reservoir reservoir annotation (Placement(visible=true, transformation(
        origin={-92,62},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(duration = 10, height = -0.0287, offset = 0.9, startTime = 600) annotation (
    Placement(visible = true, transformation(origin = {10, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp load(offset = 103e6, height = -13e6, duration = 10, startTime = 600) annotation (
    Placement(visible = true, transformation(extent = {{-14, -4}, {6, 16}}, rotation = 0)));
  Waterway.Pipe intake annotation (Placement(visible=true, transformation(extent={{-64,52},{-44,72}}, rotation=0)));
  Waterway.Pipe discharge(H=5, L=600) annotation (Placement(visible=true, transformation(extent={{46,26},{66,46}}, rotation=0)));
  Waterway.Reservoir tail(H_r=10) annotation (Placement(visible=true, transformation(
        origin={92,42},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  ElectroMech.Generators.SimpleGen aggregate(SteadyState=false, k_b=0) annotation (Placement(visible=true, transformation(extent={{18,-4},{38,16}}, rotation=0)));
  Waterway.Pipe penstock(
    H=420,
    L=600,
    D_i=3.3,
    D_o=3.3) annotation (Placement(visible=true, transformation(
        origin={-2,46},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  Waterway.SurgeTank surgeTank annotation (Placement(visible=true, transformation(
        origin={-22,66},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Turbines.Francis turbine(
    D_i=1.632,
    GivenData=true,
    H_n=460,
    P_n=103e6,
    R_1_=2.63/2,
    R_2_=1.55/2,
    R_v_=2.89/2,
    Reduction=0.1,
    V_dot_n=24.3,
    beta1_=110,
    beta2_=162.5,
    dp_v_condition=false,
    k_ft1_=7e5,
    k_ft2_=0e3,
    k_ft3_=1.63e4,
    k_fv=0e3,
    n_n=500,
    r_Y=1.2,
    r_v=1.1,
    w_1_=0.2,
    w_v_=0.2) annotation (Placement(visible=true, transformation(
        origin={28,38},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner OpenHPL.Parameters para annotation (Placement(visible=true, transformation(
        origin={-90,92},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  connect(aggregate.w_out, turbine.w_in) annotation (
    Line(points = {{32, 16}, {32, 16}, {32, 28}, {32, 28}}, color = {0, 0, 127}));
  connect(turbine.P_out, aggregate.P_in) annotation (
    Line(points = {{24, 28}, {24, 28}, {24, 16}, {24, 16}}, color = {0, 0, 127}));
  connect(discharge.n, tail.n) annotation (
    Line(points = {{66.1, 35.9}, {76, 35.9}, {76, 41.9}, {81.9, 41.9}}));
  connect(turbine.n, discharge.p) annotation (
    Line(points = {{38.1, 37.9}, {38.1, 35.9}, {46.1, 35.9}}));
  connect(turbine.p, penstock.n) annotation (
    Line(points = {{18.1, 37.9}, {18.1, 35.9}, {-2.1, 35.9}}));
  connect(intake.p, reservoir.n) annotation (
    Line(points = {{-63.9, 61.9}, {-66, 61.9}, {-66, 62}, {-67.9, 62}, {-67.9, 61.9}, {-81.9, 61.9}}));
  connect(intake.n, surgeTank.p) annotation (
    Line(points = {{-43.9, 61.9}, {-40, 61.9}, {-40, 65.9}, {-31.9, 65.9}}));
  connect(surgeTank.n, penstock.p) annotation (
    Line(points = {{-11.9, 65.9}, {-2.1, 65.9}, {-2.1, 55.9}}));
  connect(load.y, aggregate.u) annotation (
    Line(points = {{7, 6}, {7, 6}, {18, 6}}, color = {0, 0, 127}));
  connect(control.y, turbine.u_t) annotation (
    Line(points = {{21, 86}, {28, 86}, {28, 48.8}}, color = {0, 0, 127}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPSimplePenstockFrancis;
