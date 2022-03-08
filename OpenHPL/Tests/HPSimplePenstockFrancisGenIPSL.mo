within OpenHPL.Tests;
model HPSimplePenstockFrancisGenIPSL "Synergy with OpenIPSL library(generator)"
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(h_0=48) annotation (Placement(visible=true, transformation(
        origin={-48,48},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe intake(H=23) annotation (Placement(visible=true, transformation(extent={{-34,38},{-14,58}}, rotation=0)));
  OpenHPL.Waterway.Pipe discharge(L=600, H=0.5) annotation (Placement(visible=true, transformation(extent={{50,22},{70,42}}, rotation=0)));
  OpenHPL.Waterway.Reservoir tail(h_0=5) annotation (Placement(visible=true, transformation(
        origin={86,28},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.PenstockKP penstock(
    L=600,
    H=428.5,
    D_i=3,
    D_o=3) annotation (Placement(visible=true, transformation(
        origin={12,40},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  OpenHPL.Waterway.SurgeTank surgeTank(h_0=70.939) annotation (Placement(visible=true, transformation(
        origin={0,54},
        extent={{-10,-10},{10,10}},
        rotation=0)));
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
    w_v_=0.2) annotation (Placement(visible=true, transformation(
        origin={28,28},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner OpenHPL.Data data(Vdot_0=4.49) annotation (Placement(visible=true, transformation(
        origin={-90,92},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenIPSL.Electrical.Machines.PSAT.Order2 order2_1(D = 0, M = 10, P_0 = 16.0352698692006, Q_0 = 11.859436505981, Sn = 20, Vn = 400, ra = 0.001, w(fixed = true), x1d = 0.302) annotation (
    Placement(visible = true, transformation(extent = {{-14, -20}, {6, 0}}, rotation = 0)));
  Modelica.Blocks.Math.Gain Normilizer(k = 1 / 100e6) annotation (
    Placement(visible = true, transformation(origin = {-33, -15}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Math.Gain RealizerAng(k = 50 * Modelica.Constants.pi / 3) annotation (
    Placement(visible = true, transformation(origin = {49, 11}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
  inner OpenIPSL.Electrical.SystemBase SysData annotation (
    Placement(visible = true, transformation(extent = {{-60, -60}, {-36, -40}}, rotation = 0)));
  OpenHPL.Controllers.Governor governor annotation (Placement(visible=true, transformation(extent={{54,42},{34,62}}, rotation=0)));
  //(a = 7.862E-25, c = 1.108E-08, d = -5.344E-02, b = -1.010E-16)
  Modelica.Blocks.Math.Gain Frequency(k = 50) annotation (
    Placement(visible = true, transformation(origin = {60, 70}, extent = {{-8, -8}, {8, 8}}, rotation = 180)));
  Modelica.Blocks.Sources.Ramp power(duration = 1, height = +1e6, offset = 12e6, startTime = 15000) annotation (
    Placement(visible = true, transformation(origin = {78, 52}, extent = {{8, -8}, {-8, 8}}, rotation = 0)));
  OpenIPSL.Electrical.Branches.PwLine pwLine1(X = 0.1, R = 0.01, G = 0, B = 0.0005) annotation (
    Placement(visible = true, transformation(origin = {16, -58}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OpenIPSL.Electrical.Branches.PwLine pwLinewithOpening1(B = 0.0005, G = 0, R = 0.01, X = 0.1, opening = 1, t1 = 600, t2 = 600.15) annotation (
    Placement(visible = true, transformation(origin = {56, -34}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OpenIPSL.Electrical.Branches.PwLine pwLine2(G = 0, R = 0.01, X = 0.1, B = 0.0005) annotation (
    Placement(visible = true, transformation(origin = {14, -34}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OpenIPSL.Electrical.Branches.PwLine pwLine3(G = 0, R = 0.01, X = 0.1, B = 0.0005) annotation (
    Placement(visible = true, transformation(origin = {58, -60}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OpenIPSL.Electrical.Branches.PwLine pwLine4(G = 0, R = 0.01, X = 0.1, B = 0.0005) annotation (
    Placement(visible = true, transformation(origin = {56, -10}, extent = {{-5.99999, -5.99998}, {5.99999, 6}}, rotation = 0)));
  OpenIPSL.Electrical.Loads.PSAT.LOADPQ pwLoadPQ1(V_0 = 1, angle_0 = 0, P_0 = 8, Q_0 = 6) annotation (
    Placement(visible = true, transformation(origin = {90, -22}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
  OpenIPSL.Electrical.Loads.PSAT.LOADPQ_variation pwLoadPQ2(V_0 = 1, angle_0 = 0, P_0 = 8, Q_0 = 6, dQ1 = 0, t_start_2 = 1e10, t_end_2 = 1e10, dP2 = 0, dQ2 = 0, t_start_1 = 1e3, t_end_1 = 1.1e3, dP1 = 1) annotation (
    Placement(visible = true, transformation(origin = {90.0335, -60.2889}, extent = {{-6.2889, -6.0335}, {6.2889, 6.0335}}, rotation = 90)));
  OpenIPSL.Electrical.Buses.Bus bus annotation (
    Placement(visible = true, transformation(extent = {{-14, -56}, {6, -36}}, rotation = 0)));
  OpenIPSL.Electrical.Buses.Bus bus1 annotation (
    Placement(visible = true, transformation(extent = {{26, -56}, {46, -36}}, rotation = 0)));
  OpenIPSL.Electrical.Buses.Bus bus2 annotation (
    Placement(visible = true, transformation(extent = {{66, -32}, {86, -12}}, rotation = 0)));
  OpenIPSL.Electrical.Buses.Bus bus3 annotation (
    Placement(visible = true, transformation(extent = {{66, -70}, {86, -50}}, rotation = 0)));
equation
  connect(pwLine2.p, bus.p) annotation (
    Line(points = {{9, -34}, {2, -34}, {2, -46}, {-4, -46}}, color = {0, 0, 255}));
  connect(pwLine2.n, bus1.p) annotation (
    Line(points = {{19, -34}, {30, -34}, {30, -46}, {36, -46}}, color = {0, 0, 255}));
  connect(surgeTank.n, penstock.p) annotation (
    Line(points = {{10.1, 53.9}, {12.1, 53.9}, {12.1, 49.9}}, color = {28, 108, 200}));
  connect(surgeTank.p, intake.n) annotation (
    Line(points = {{-9.9, 53.9}, {-11.8, 53.9}, {-11.8, 48}, {-14, 48}}, color = {28, 108, 200}));
  connect(penstock.n, turbine.p) annotation (
    Line(points = {{12, 30}, {12.85, 30}, {12.85, 27.8}, {18, 27.8}}, color = {28, 108, 200}));
  connect(reservoir.n, intake.p) annotation (
    Line(points = {{-37.9, 47.9}, {-36.8, 47.9}, {-36.8, 47.8}, {-33.8, 47.8}}, color = {28, 108, 200}));
  connect(bus1.p, pwLinewithOpening1.p) annotation (
    Line(points = {{36, -46}, {40, -46}, {40, -22}, {44, -22}, {44, -34}, {50.6, -34}}, color = {0, 0, 255}));
  connect(pwLine4.p, bus1.p) annotation (
    Line(points = {{50, -10}, {44, -10}, {44, -22}, {40, -22}, {40, -46}, {36, -46}}, color = {0, 0, 255}));
  connect(pwLine3.p, bus1.p) annotation (
    Line(points = {{52, -60}, {40, -60}, {40, -46}, {36, -46}, {36, -46}}, color = {0, 0, 255}));
  connect(pwLine1.n, bus1.p) annotation (
    Line(points = {{22, -58}, {30, -58}, {30, -46}, {34, -46}, {34, -46}, {36, -46}}, color = {0, 0, 255}));
  connect(pwLine4.n, bus2.p) annotation (
    Line(points = {{62, -10}, {68, -10}, {68, -22}, {76, -22}, {76, -22}}, color = {0, 0, 255}));
  connect(order2_1.p, bus.p) annotation (
    Line(points = {{6, -10}, {10, -10}, {10, -26}, {-10, -26}, {-10, -46}, {-4, -46}}, color = {0, 0, 255}));
  connect(pwLine3.n, bus3.p) annotation (
    Line(points = {{63.4, -60}, {76, -60}}, color = {0, 0, 255}));
  connect(bus3.p, pwLoadPQ2.p) annotation (
    Line(points = {{76, -60}, {80, -60}, {80, -60}, {84, -60}, {84, -59.1445}, {84, -59.1445}, {84, -60.2889}}, color = {0, 0, 255}));
  connect(bus2.p, pwLinewithOpening1.n) annotation (
    Line(points = {{76, -22}, {74, -22}, {74, -22}, {72, -22}, {72, -22}, {68, -22}, {68, -34}, {61.4, -34}}, color = {0, 0, 255}));
  connect(bus2.p, pwLoadPQ1.p) annotation (
    Line(points = {{76, -22}, {84, -22}}, color = {0, 0, 255}));
  connect(bus.p, pwLine1.p) annotation (
    Line(points = {{-4, -46}, {-2.5, -46}, {-2.5, -46}, {-1, -46}, {-1, -46}, {2, -46}, {2, -58}, {6.3, -58}, {6.3, -58}, {8.45, -58}, {8.45, -58}, {10.6, -58}}, color = {0, 0, 255}));
  connect(Frequency.u, RealizerAng.u) annotation (
    Line(points = {{70, 70}, {100, 70}, {100, 0}, {72, 0}, {72, 11}, {57, 11}}, color = {0, 0, 127}));
  connect(order2_1.w, RealizerAng.u) annotation (
    Line(points = {{7, -1}, {72, -1}, {72, 11}, {57, 11}}, color = {0, 0, 127}));
  connect(Normilizer.u, turbine.P_out) annotation (
    Line(points = {{-41, -15}, {-48, -15}, {-48, 12}, {24, 12}, {24, 17}}, color = {0, 0, 127}));
  connect(Normilizer.y, order2_1.pm) annotation (
    Line(points = {{-25.3, -15}, {-16.3, -15}}, color = {0, 0, 127}));
  connect(order2_1.vf, order2_1.vf0) annotation (
    Line(points = {{-16, -5}, {-24, -5}, {-24, 4}, {-12, 4}, {-12, 1}}, color = {0, 0, 127}));
  connect(RealizerAng.y, turbine.w_in) annotation (
    Line(points = {{41, 11}, {32, 11}, {32, 18}}, color = {0, 0, 127}));
  connect(Frequency.y, governor.f) annotation (
    Line(points = {{51, 70}, {44, 70}, {44, 62}}, color = {0, 0, 127}));
  connect(governor.P_ref, power.y) annotation (
    Line(points = {{54, 52}, {69, 52}}, color = {0, 0, 127}));
  connect(governor.Y_gv, turbine.u_t) annotation (
    Line(points = {{34, 52}, {28, 52}, {28, 39}}, color = {0, 0, 127}));
  connect(turbine.n, discharge.p) annotation (
    Line(points = {{38.1, 27.9}, {41.05, 27.9}, {41.05, 27.9}, {44, 27.9}, {44, 31.9}, {50.1, 31.9}}, color = {28, 108, 200}));
  connect(tail.n, discharge.n) annotation (
    Line(points = {{75.9, 27.9}, {75.9, 31.8}, {72.95, 31.8}, {72.95, 31.8}, {70, 31.8}}, color = {28, 108, 200}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPSimplePenstockFrancisGenIPSL;
