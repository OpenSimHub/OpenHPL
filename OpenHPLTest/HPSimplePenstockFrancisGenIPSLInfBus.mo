within OpenHPLTest;
model HPSimplePenstockFrancisGenIPSLInfBus "Synergy with OpenIPSL library(generator + infinitBus)"
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(h_0=48) annotation (Placement(transformation(origin={-92,62}, extent={{-10,-10},{10,10}})));
  OpenHPL.Waterway.Pipe intake(H=23) annotation (Placement(transformation(extent={{-76,52},{-56,72}})));
  OpenHPL.Waterway.Pipe discharge(H=0.5, L=600) annotation (Placement(transformation(extent={{50,30},{70,50}})));
  OpenHPL.Waterway.Reservoir tail(h_0=5) annotation (Placement(transformation(
        origin={90,36},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.Pipe penstock(
    D_i=3,
    D_o=3,
    H=428.5,
    L=600) annotation (Placement(transformation(
        origin={-10,48},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  OpenHPL.Waterway.SurgeTank surgeTank(h_0=70.939) annotation (Placement(transformation(
        origin={-36,66},
        extent={{-10,-10},{10,10}})));
  OpenHPL.ElectroMech.Turbines.Francis turbine(
    D_i=1.632,
    GivenData=true,
    GivenServoData=false,
    Given_losses=true,
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
    r_Y_=1.2,
    r_v_=1.1,
    w_1_=0.2,
    w_v_=0.2) annotation (Placement(transformation(
        origin={28,36},
        extent={{-10,-10},{10,10}})));
  inner OpenHPL.Data data(Vdot_0=4.49) annotation (Placement(transformation(
        origin={-90,92},
        extent={{-10,-10},{10,10}})));
  OpenIPSL.Electrical.Machines.PSAT.Order2 order2_1(D = 0, M = 10, P_0 = 16.0352698692006, Q_0 = 11.859436505981, Sn = 20, Vn = 400, ra = 0.001, w(fixed = true), x1d = 0.302) annotation (
    Placement(transformation(extent = {{26, -30}, {46, -10}})));
  Modelica.Blocks.Math.Gain Normilizer(k = 1 / 100e6) annotation (
    Placement(transformation(extent = {{-12, -36}, {8, -16}})));
  Modelica.Blocks.Math.Gain RealizerAng(k = 50 * Modelica.Constants.pi / 3) annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {52, 10})));
  inner OpenIPSL.Electrical.SystemBase SysData annotation (
    Placement(transformation(extent = {{-100, -100}, {-76, -80}})));
  OpenHPL.Controllers.Governor governor(droop=0.2) annotation (Placement(transformation(extent={{54,62},{34,82}})));
  Modelica.Blocks.Math.Gain Frequency(k = 50) annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {60, 86})));
  Modelica.Blocks.Sources.Ramp power(duration = 1, height = 1.3e6, offset = 12e6, startTime = 1500) annotation (
    Placement(transformation(extent = {{10, -10}, {-10, 10}}, origin = {86, 70})));
  OpenIPSL.Electrical.Branches.PwLine pwLine1(X = 0.1, R = 0.01, G = 0, B = 0.0005) annotation (
    Placement(transformation(origin = {16, -88}, extent = {{-6, -6}, {6, 6}})));
  OpenIPSL.Electrical.Branches.PwLine pwLinewithOpening1(G = 0, R = 0.01, X = 0.1, opening = 1, B = 0.0005, t1 = 600, t2 = 600.15) annotation (
    Placement(transformation(origin = {56, -64}, extent = {{-6, -6}, {6, 6}})));
  OpenIPSL.Electrical.Branches.PwLine pwLine2(G = 0, R = 0.01, X = 0.1, B = 0.0005) annotation (
    Placement(transformation(origin = {16, -64}, extent = {{-6, -6}, {6, 6}})));
  OpenIPSL.Electrical.Branches.PwLine pwLine3(G = 0, R = 0.01, X = 0.1, B = 0.0005) annotation (
    Placement(transformation(origin = {58, -90}, extent = {{-6, -6}, {6, 6}})));
  OpenIPSL.Electrical.Branches.PwLine pwLine4(G = 0, R = 0.01, X = 0.1, B = 0.0005) annotation (
    Placement(transformation(origin = {56, -40}, extent = {{-5.99999, -5.99998}, {5.99999, 6}})));
  OpenIPSL.Electrical.Loads.PSAT.LOADPQ pwLoadPQ1(P_0 = 8, Q_0 = 6, V_0 = 1, angle_0 = 0) annotation (
    Placement(transformation(origin = {90, -52}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
  OpenIPSL.Electrical.Loads.PSAT.LOADPQ_variation pwLoadPQ2(P_0 = 8, Q_0 = 6, V_0 = 1, angle_0 = 0, dP1 = 1, dP2 = 0, dQ1 = 0, dQ2 = 0, t_end_1 = 1.1e3, t_end_2 = 1e10, t_start_1 = 1e3, t_start_2 = 1e10) annotation (
    Placement(transformation(origin = {90.0335, -90.2889}, extent = {{-6.2889, -6.0335}, {6.2889, 6.0335}}, rotation = 90)));
  OpenIPSL.Electrical.Buses.Bus bus annotation (
    Placement(transformation(extent = {{-14, -86}, {6, -66}})));
  OpenIPSL.Electrical.Buses.Bus bus1 annotation (
    Placement(transformation(extent = {{26, -86}, {46, -66}})));
  OpenIPSL.Electrical.Buses.Bus bus2(displayPF = true) annotation (
    Placement(transformation(extent = {{66, -62}, {86, -42}})));
  OpenIPSL.Electrical.Buses.Bus bus3 annotation (
    Placement(transformation(extent = {{66, -100}, {86, -80}})));
  OpenIPSL.Electrical.Buses.InfiniteBus infiniteBus annotation (
    Placement(transformation(extent = {{-62, -64}, {-42, -44}})));
equation
  connect(infiniteBus.p, bus.p) annotation (
    Line(points = {{-42, -54}, {-28, -54}, {-28, -76}, {-4, -76}}, color = {0, 0, 255}));
  connect(reservoir.n, intake.p) annotation (
    Line(points = {{-81.9, 61.9}, {-78, 61.9}, {-75.9, 61.9}}, color = {28, 108, 200}));
  connect(surgeTank.p, intake.n) annotation (
    Line(points = {{-45.9, 65.9}, {-48, 65.9}, {-48, 61.9}, {-55.9, 61.9}}, color = {28, 108, 200}));
  connect(surgeTank.n, penstock.p) annotation (
    Line(points = {{-25.9, 65.9}, {-16.95, 65.9}, {-16.95, 57.9}, {-10.1, 57.9}}, color = {28, 108, 200}));
  connect(turbine.n, discharge.p) annotation (
    Line(points = {{38.1, 35.9}, {44, 35.9}, {44, 39.9}, {50.1, 39.9}}, color = {28, 108, 200}));
  connect(tail.n, discharge.n) annotation (
    Line(points = {{79.9, 35.9}, {79.9, 39.95}, {80, 39.95}, {80, 39.9}, {70.1, 39.9}}, color = {28, 108, 200}));
  connect(order2_1.vf, order2_1.vf0) annotation (
    Line(points = {{24, -15}, {16, -15}, {16, -6}, {28, -6}, {28, -9}}, color = {0, 0, 127}));
  connect(Normilizer.u, turbine.P_out) annotation (
    Line(points = {{-14, -26}, {-20, -26}, {-20, 8}, {-20, 12}, {24, 12}, {24, 26}, {24, 25.4}}, color = {0, 0, 127}));
  connect(Normilizer.y, order2_1.pm) annotation (
    Line(points = {{9, -26}, {24, -26}, {24, -25}}, color = {0, 0, 127}));
  connect(order2_1.w, RealizerAng.u) annotation (
    Line(points = {{47, -11}, {54, -11}, {54, -8}, {72, -8}, {72, 10}, {64, 10}}, color = {0, 0, 127}));
  connect(governor.Y_gv, turbine.u_t) annotation (
    Line(points = {{34, 72}, {34, 72}, {28, 72}, {28, 46.8}}, color = {0, 0, 127}));
  connect(Frequency.y, governor.f) annotation (
    Line(points = {{49, 86}, {49, 86}, {44, 86}, {44, 82}}, color = {0, 0, 127}));
  connect(Frequency.u, RealizerAng.u) annotation (
    Line(points = {{72, 86}, {100, 86}, {100, -8}, {72, -8}, {72, 10}, {64, 10}}, color = {0, 0, 127}));
  connect(governor.P_ref, power.y) annotation (
    Line(points = {{54, 72}, {64, 72}, {64, 70}, {75, 70}}, color = {0, 0, 127}));
  connect(penstock.n, turbine.p) annotation (
    Line(points = {{-10.1, 37.9}, {4.95, 37.9}, {4.95, 35.9}, {18.1, 35.9}}, color = {28, 108, 200}));
  connect(pwLine2.p, pwLine1.p) annotation (
    Line(points = {{10.6, -64}, {2, -64}, {2, -88}, {10.6, -88}}, color = {0, 0, 255}));
  connect(pwLine2.n, pwLine1.n) annotation (
    Line(points = {{21.4, -64}, {30, -64}, {30, -88}, {21.4, -88}}, color = {0, 0, 255}));
  connect(pwLine4.p, pwLinewithOpening1.p) annotation (
    Line(points = {{50.6, -40}, {44, -40}, {44, -64}, {50.6, -64}}, color = {0, 0, 255}));
  connect(pwLine4.n, pwLinewithOpening1.n) annotation (
    Line(points = {{61.4, -40}, {68, -40}, {68, -64}, {61.4, -64}}, color = {0, 0, 255}));
  connect(bus.p, pwLine1.p) annotation (
    Line(points = {{-4, -76}, {2, -76}, {2, -88}, {10.6, -88}}, color = {0, 0, 255}));
  connect(bus1.p, pwLine1.n) annotation (
    Line(points = {{36, -76}, {30, -76}, {30, -88}, {21.4, -88}}, color = {0, 0, 255}));
  connect(bus1.p, pwLinewithOpening1.p) annotation (
    Line(points = {{36, -76}, {40, -76}, {40, -56}, {44, -56}, {44, -64}, {50.6, -64}}, color = {0, 0, 255}));
  connect(pwLine3.p, pwLinewithOpening1.p) annotation (
    Line(points = {{52.6, -90}, {40, -90}, {40, -56}, {44, -56}, {44, -64}, {50.6, -64}}, color = {0, 0, 255}));
  connect(bus2.p, pwLoadPQ1.p) annotation (
    Line(points = {{76, -52}, {84, -52}}, color = {0, 0, 255}));
  connect(bus2.p, pwLinewithOpening1.n) annotation (
    Line(points = {{76, -52}, {68, -52}, {68, -64}, {61.4, -64}}, color = {0, 0, 255}));
  connect(bus3.p, pwLoadPQ2.p) annotation (
    Line(points = {{76, -90}, {84, -90}, {84, -90.2889}}, color = {0, 0, 255}));
  connect(pwLine3.n, bus3.p) annotation (
    Line(points = {{63.4, -90}, {63.4, -90}, {76, -90}}, color = {0, 0, 255}));
  connect(order2_1.p, bus.p) annotation (
    Line(points = {{46, -20}, {62, -20}, {62, -36}, {36, -36}, {36, -58}, {-12, -58}, {-12, -76}, {-4, -76}}, color = {0, 0, 255}));
  connect(RealizerAng.y, turbine.w_in) annotation (
    Line(points = {{41, 10}, {32, 10}, {32, 25.8}}, color = {0, 0, 127}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPSimplePenstockFrancisGenIPSLInfBus;
