within OpenHPL.Examples.WithOpenIPSL;
model HPSimple_Francis_IPSLGenGov "Synergy with OpenIPSL library(generator + governor)"
  //input Real u;
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(h_0=48) annotation (Placement(transformation(
        origin={-86,60},
        extent={{-10,-10},{10,10}})));
  OpenHPL.Waterway.Pipe intake(H=23) annotation (Placement(transformation(extent={{-70,50},{-50,70}})));
  Waterway.Pipe discharge(H=0.5, L=600) annotation (Placement(transformation(extent={{50,30},{70,50}})));
  OpenHPL.Waterway.Reservoir tail(h_0=5) annotation (Placement(transformation(
        origin={88,40},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Waterway.Pipe penstock(
    vertical=true,
    D_i=3,
    D_o=3,
    H=428.5,
    L=600) annotation (Placement(transformation(
        origin={0,52},
        extent={{-10,-10},{10,10}})));
  OpenHPL.Waterway.SurgeTank surgeTank(h_0=70.9392) annotation (Placement(transformation(
        origin={-30,60},
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
    u_end_=2.36,
    u_start_=2.23,
    w_1_=0.2,
    w_v_=0.2) annotation (Placement(transformation(
        origin={30,40},
        extent={{-10,-10},{10,10}})));
  inner OpenHPL.Data data(Vdot_0=4.49671) annotation (Placement(transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}})));
  OpenIPSL.Electrical.Machines.PSAT.Order2 order2_1(D = 0, M = 10,
    P_0=16035269.869201,
    Q_0=11859436.505981,
    Sn=20000000,
    Vn=400000,                                                                                                                           ra = 0.001, w(fixed = true), x1d = 0.302) annotation (
    Placement(transformation(extent = {{26, -30}, {46, -10}})));
  Modelica.Blocks.Math.Gain Normilizer(k = 1 / 100e6) annotation (
    Placement(transformation(extent = {{-12, -36}, {8, -16}})));
  Modelica.Blocks.Math.Gain RealizerAng(k = 50 * Modelica.Constants.pi / 3) annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {52, 10})));
  inner OpenIPSL.Electrical.SystemBase SysData annotation (
    Placement(transformation(extent = {{-96, -100}, {-72, -80}})));
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
  OpenIPSL.Electrical.Loads.PSAT.PQ     pwLoadPQ1(P_0=8000000, Q_0=6000000)               annotation (
    Placement(transformation(origin = {90, -52}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
  OpenIPSL.Electrical.Loads.PSAT.PQvar            pwLoadPQ2(
    P_0=8000000,
    Q_0=6000000,
    dP1(displayUnit="MW") = 1000000,                                                                                                    t_end_1 = 1100, t_end_2 = 1e10, t_start_1 = 1000, t_start_2 = 1e10) annotation (
    Placement(transformation(origin = {90.0335, -90.2889}, extent = {{-6.2889, -6.0335}, {6.2889, 6.0335}}, rotation = 90)));
  OpenIPSL.Electrical.Buses.Bus bus annotation (
    Placement(transformation(extent = {{-14, -86}, {6, -66}})));
  OpenIPSL.Electrical.Buses.Bus bus1 annotation (
    Placement(transformation(extent = {{26, -86}, {46, -66}})));
  OpenIPSL.Electrical.Buses.Bus bus2 annotation (
    Placement(transformation(extent = {{66, -62}, {86, -42}})));
  OpenIPSL.Electrical.Buses.Bus bus3 annotation (
    Placement(transformation(extent = {{66, -100}, {86, -80}})));
  OpenIPSL.Electrical.Controls.PSAT.TG.TGTypeI tGTypeI(R = 0.1, T3 = 0.04, T4 = 5, T5 = 0.04, Tc = 1, Ts = 0.1, pmax = 1, pmin = 0, pref = 0.1537, wref = 1) annotation (
    Placement(transformation(extent={{80,60},{60,80}})));
equation
  connect(order2_1.p, bus.p) annotation (
    Line(points = {{46, -20}, {52, -20}, {52, -38}, {14, -38}, {14, -58}, {-14, -58}, {-14, -76}, {-4, -76}, {-4, -76}, {-4, -76}}, color = {0, 0, 255}));
  connect(tGTypeI.pm, turbine.u_t) annotation (
    Line(points={{59,70},{30,70},{30,52}},                  color = {0, 0, 127}));
  connect(Normilizer.u, turbine.P_out) annotation (
    Line(points={{-14,-26},{-26,-26},{-26,22},{30,22},{30,29}},              color = {0, 0, 127}));
  //turbine.u_t = u;
  connect(order2_1.vf, order2_1.vf0) annotation (
    Line(points = {{24, -15}, {16, -15}, {16, -6}, {28, -6}, {28, -9}}, color = {0, 0, 127}));
  connect(Normilizer.y, order2_1.pm) annotation (
    Line(points = {{9, -26}, {24, -26}, {24, -25}}, color = {0, 0, 127}));
  connect(order2_1.w, RealizerAng.u) annotation (
    Line(points={{47,-11},{72,-11},{72,10},{64,10}},                              color = {0, 0, 127}));
  connect(pwLine2.p, pwLine1.p) annotation (
    Line(points = {{10.6, -64}, {2, -64}, {2, -88}, {10.6, -88}}, color = {0, 0, 255}));
  connect(pwLine2.n, pwLine1.n) annotation (
    Line(points = {{21.4, -64}, {30, -64}, {30, -88}, {21.4, -88}}, color = {0, 0, 255}));
  connect(pwLine4.p, pwLinewithOpening1.p) annotation (
    Line(points={{50.6,-40},{44,-40},{44,-64},{50.6,-64}},          color = {0, 0, 255}));
  connect(pwLine4.n, pwLinewithOpening1.n) annotation (
    Line(points={{61.4,-40},{68,-40},{68,-64},{61.4,-64}},          color = {0, 0, 255}));
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
  connect(tGTypeI.w, order2_1.w) annotation (
    Line(points={{82,70},{100,70},{100,-11},{47,-11}},                                      color = {0, 0, 127}));
  connect(RealizerAng.y, turbine.w_in) annotation (
    Line(points={{41,10},{6,10},{6,32},{18,32}},              color = {0, 0, 127}));
  connect(discharge.o, tail.o) annotation (Line(points={{70,40},{78,40}}, color={28,108,200}));
  connect(discharge.i, turbine.o) annotation (Line(points={{50,40},{40,40}}, color={28,108,200}));
  connect(penstock.o, turbine.i) annotation (Line(points={{10,52},{14,52},{14,40},{20,40}}, color={28,108,200}));
  connect(penstock.i, surgeTank.o) annotation (Line(points={{-10,52},{-14,52},{-14,60},{-20,60}}, color={28,108,200}));
  connect(surgeTank.i, intake.o) annotation (Line(points={{-40,60},{-50,60}}, color={28,108,200}));
  connect(reservoir.o, intake.i) annotation (Line(points={{-76,60},{-70,60}}, color={28,108,200}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPSimple_Francis_IPSLGenGov;
