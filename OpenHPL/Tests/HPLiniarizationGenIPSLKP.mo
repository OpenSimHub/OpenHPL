within OpenHPL.Tests;
model HPLiniarizationGenIPSLKP "Synergy with OpenIPSL library(generator + governor)"
  extends Modelica.Icons.Example;
  input Real u = 0.574;
  output Real w, dotV, P;
  //, P;
  OpenHPL.Waterway.Reservoir reservoir(h_0=48) annotation (Placement(visible=true, transformation(
        origin={-92,46},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe intake(H=23, Vdot_0=18.536) annotation (Placement(visible=true, transformation(extent={{-76,36},{-56,56}}, rotation=0)));
  OpenHPL.Waterway.Pipe discharge(
    H=0.5,
    L=600,
    Vdot_0=18.5359) annotation (Placement(visible=true, transformation(extent={{50,38},{70,58}}, rotation=0)));
  OpenHPL.Waterway.Reservoir tail(h_0=5) annotation (Placement(visible=true, transformation(
        origin={92,52},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.SurgeTank surgeTank(h_0=69.9695) annotation (Placement(visible=true, transformation(
        origin={-36,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
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
    WaterCompress=false,
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
        origin={26,42},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner OpenHPL.Data data(Vdot_0=4.49) annotation (Placement(visible=true, transformation(
        origin={-90,92},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenIPSL.Electrical.Machines.PSAT.Order2 order2_1(D = 0, M = 10, P_0 = 16.0352698692006 * 5, Q_0 = 11.859436505981 * 5, Sn = 20 * 5, Vn = 400, ra = 0.001, w(fixed = true), x1d = 0.302) annotation (
    Placement(visible = true, transformation(extent = {{8, 0}, {28, 20}}, rotation = 0)));
  Modelica.Blocks.Math.Gain Normilizer(k = 1 / 100e6) annotation (
    Placement(visible = true, transformation(origin = {-9, 3}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Math.Gain RealizerAng(k = 50 * Modelica.Constants.pi / 3) annotation (
    Placement(visible = true, transformation(origin = {46, 28}, extent = {{-8, -8}, {8, 8}}, rotation = 180)));
  inner OpenIPSL.Electrical.SystemBase SysData annotation (
    Placement(visible = true, transformation(extent = {{-100, 0}, {-76, 20}}, rotation = 0)));
  OpenIPSL.Electrical.Branches.PwLine pwLine1(X = 0.1, R = 0.01, G = 0, B = 0.0005) annotation (
    Placement(visible = true, transformation(origin = {16, -40}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OpenIPSL.Electrical.Branches.PwLine pwLinewithOpening1(G = 0, R = 0.01, X = 0.1, opening = 1, B = 0.0005) annotation (
    Placement(visible = true, transformation(origin = {56, -12}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OpenIPSL.Electrical.Branches.PwLine pwLine2(G = 0, R = 0.01, X = 0.1, B = 0.0005) annotation (
    Placement(visible = true, transformation(origin = {16, -16}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OpenIPSL.Electrical.Branches.PwLine pwLine3(G = 0, R = 0.01, X = 0.1, B = 0.0005) annotation (
    Placement(visible = true, transformation(origin = {58, -38}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OpenIPSL.Electrical.Branches.PwLine pwLine4(G = 0, R = 0.01, X = 0.1, B = 0.0005) annotation (
    Placement(visible = true, transformation(origin = {56, -2}, extent = {{-5.99999, -5.99998}, {5.99999, 6}}, rotation = 0)));
  OpenIPSL.Electrical.Loads.PSAT.LOADPQ pwLoadPQ1(P_0 = 8 * 5, Q_0 = 6 * 5, V_0 = 1, angle_0 = 0) annotation (
    Placement(visible = true, transformation(origin = {90, -6}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
  OpenIPSL.Electrical.Loads.PSAT.LOADPQ_variation pwLoadPQ2(P_0 = 8 * 5, Q_0 = 6 * 5, V_0 = 1, angle_0 = 0, dP1 = 1, dP2 = 0, dQ1 = 0, dQ2 = 0, t_end_1 = 1.1e10, t_end_2 = 1e10, t_start_1 = 1e10, t_start_2 = 1e10) annotation (
    Placement(visible = true, transformation(origin = {90.0335, -38.2889}, extent = {{-6.2889, -6.0335}, {6.2889, 6.0335}}, rotation = 90)));
  OpenIPSL.Electrical.Buses.Bus bus annotation (
    Placement(visible = true, transformation(extent = {{-14, -38}, {6, -18}}, rotation = 0)));
  OpenIPSL.Electrical.Buses.Bus bus1 annotation (
    Placement(visible = true, transformation(extent = {{26, -38}, {46, -18}}, rotation = 0)));
  OpenIPSL.Electrical.Buses.Bus bus2(displayPF = true) annotation (
    Placement(visible = true, transformation(extent = {{66, -16}, {86, 4}}, rotation = 0)));
  OpenIPSL.Electrical.Buses.Bus bus3 annotation (
    Placement(visible = true, transformation(extent = {{66, -48}, {86, -28}}, rotation = 0)));
  OpenIPSL.Electrical.Buses.InfiniteBus infiniteBus annotation (
    Placement(visible = true, transformation(extent = {{-54, -38}, {-34, -18}}, rotation = 0)));
  OpenHPL.Waterway.PenstockKP penstockKP(
    D_i=3,
    D_o=3,
    H=428.5,
    N=10,
    PipeElasticity=true,
    Vdot_0={18.5285,18.5251,18.5216,18.5181,18.5147,18.5112,18.5077,18.5043,18.5008,18.4973},
    h_s0=69.9694,
    p_p0={9.93615,14.0954,18.2545,22.4134,26.5723,30.7309,34.8895,39.0479,43.2061,47.3643}*1e5) annotation (Placement(visible=true, transformation(
        origin={-4,42},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  connect(order2_1.vf, order2_1.vf0) annotation (
    Line(points = {{6, 15}, {2, 15}, {2, 15}, {-2, 15}, {-2, 24}, {10, 24}, {10, 22.5}, {10, 22.5}, {10, 21}}, color = {0, 0, 127}));
  connect(order2_1.w, RealizerAng.u) annotation (
    Line(points = {{29, 19}, {60, 19}, {60, 28}, {56, 28}}, color = {0, 0, 127}));
  connect(Normilizer.y, order2_1.pm) annotation (
    Line(points = {{-1.3, 3}, {7.7, 3}, {7.7, 5}, {6, 5}}, color = {0, 0, 127}));
  connect(order2_1.p, bus.p) annotation (
    Line(points = {{28, 10}, {42, 10}, {42, -6}, {28, -6}, {28, -12}, {-12, -12}, {-12, -28}, {-4, -28}}, color = {0, 0, 255}));
  connect(infiniteBus.p, bus.p) annotation (
    Line(points = {{-34, -28}, {-4, -28}}, color = {0, 0, 255}));
  connect(bus3.p, pwLoadPQ2.p) annotation (
    Line(points = {{76, -38}, {78, -38}, {78, -38}, {80, -38}, {80, -38}, {84, -38}, {84, -38.2889}}, color = {0, 0, 255}));
  connect(pwLine3.n, bus3.p) annotation (
    Line(points = {{63.4, -38}, {63.4, -38}, {63.4, -38}, {63.4, -38}, {63.4, -38}, {63.4, -38}, {63.4, -38}, {63.4, -38}, {69.7, -38}, {69.7, -38}, {72.85, -38}, {72.85, -38}, {76, -38}}, color = {0, 0, 255}));
  connect(pwLine3.p, bus1.p) annotation (
    Line(points = {{53, -38}, {42, -38}, {42, -28}, {36, -28}}, color = {0, 0, 255}));
  connect(bus2.p, pwLoadPQ1.p) annotation (
    Line(points = {{76, -6}, {84, -6}}, color = {0, 0, 255}));
  connect(pwLinewithOpening1.n, bus2.p) annotation (
    Line(points = {{61.4, -12}, {67.4, -12}, {67.4, -6}, {76, -6}}, color = {0, 0, 255}));
  connect(pwLine4.p, pwLinewithOpening1.p) annotation (
    Line(points = {{50, -2}, {48, -2}, {48, -12}, {50, -12}, {50, -12}}, color = {0, 0, 255}));
  connect(bus1.p, pwLinewithOpening1.p) annotation (
    Line(points = {{36, -28}, {42, -28}, {42, -8}, {48, -8}, {48, -12}, {50, -12}, {50, -12}}, color = {0, 0, 255}));
  connect(bus1.p, pwLine1.n) annotation (
    Line(points = {{36, -28}, {34.5, -28}, {34.5, -28}, {35, -28}, {35, -28}, {32, -28}, {32, -40}, {27.7, -40}, {27.7, -40}, {23.55, -40}, {23.55, -40}, {21.4, -40}}, color = {0, 0, 255}));
  connect(bus.p, pwLine1.p) annotation (
    Line(points = {{-4, -28}, {-3.25, -28}, {-3.25, -28}, {-2.5, -28}, {-2.5, -28}, {-1, -28}, {-1, -28}, {2, -28}, {2, -40}, {6.3, -40}, {6.3, -40}, {8.45, -40}, {8.45, -40}, {9.525, -40}, {9.525, -40}, {10.6, -40}}, color = {0, 0, 255}));
  connect(pwLinewithOpening1.n, pwLine4.n) annotation (
    Line(points = {{61.4, -12}, {67.4, -12}, {67.4, -2}, {61.4, -2}, {61.4, -2}, {61.4, -2}, {61.4, -2}}, color = {0, 0, 255}));
  connect(pwLine2.n, pwLine1.n) annotation (
    Line(points = {{21.4, -16}, {21.9375, -16}, {21.9375, -16}, {24.475, -16}, {24.475, -16}, {25.55, -16}, {25.55, -16}, {27.7, -16}, {27.7, -16}, {30, -16}, {30, -40}, {27.7, -40}, {27.7, -40}, {23.55, -40}, {23.55, -40}, {21.4, -40}}, color = {0, 0, 255}));
  connect(pwLine2.p, pwLine1.p) annotation (
    Line(points = {{10.6, -16}, {9.525, -16}, {9.525, -16}, {10.45, -16}, {10.45, -16}, {8.3, -16}, {8.3, -16}, {2, -16}, {2, -40}, {8.3, -40}, {8.3, -40}, {10.45, -40}, {10.45, -40}, {9.525, -40}, {9.525, -40}, {10.6, -40}}, color = {0, 0, 255}));
  connect(Normilizer.u, turbine.P_out) annotation (
    Line(points = {{-17, 3}, {-28, 3}, {-28, 28}, {22, 28}, {22, 31}}, color = {0, 0, 127}));
  connect(RealizerAng.y, turbine.w_in) annotation (
    Line(points = {{37, 28}, {30, 28}, {30, 32}}, color = {0, 0, 127}));
  connect(surgeTank.p, intake.n) annotation (
    Line(points = {{-45.9, 49.9}, {-46.95, 49.9}, {-46.95, 47.9}, {-48, 47.9}, {-48, 45.9}, {-55.9, 45.9}}, color = {28, 108, 200}));
  connect(surgeTank.n, penstockKP.p) annotation (
    Line(points = {{-26, 50}, {-14, 50}, {-14, 41.9}, {-13.9, 41.9}}, color = {28, 108, 200}));
  connect(reservoir.n, intake.p) annotation (
    Line(points = {{-81.9, 45.9}, {-78, 45.9}, {-75.9, 45.9}}, color = {28, 108, 200}));
  connect(tail.n, discharge.n) annotation (
    Line(points = {{82, 52}, {76, 52}, {76, 48}, {70, 48}}, color = {28, 108, 200}));
  connect(turbine.n, discharge.p) annotation (
    Line(points = {{36, 42}, {43, 42}, {43, 48}, {50, 48}}, color = {28, 108, 200}));
  connect(penstockKP.n, turbine.p) annotation (
    Line(points = {{6.1, 41.9}, {16, 41.9}, {16, 42}}, color = {28, 108, 200}));
  turbine.u_t = u;
  dotV = turbine.Vdot;
  P = order2_1.P;
  w = turbine.w;
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.08));
end HPLiniarizationGenIPSLKP;
