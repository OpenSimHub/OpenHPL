within OpenHPL.Examples;
model HPSimple_Francis_GridGen "Synergy with OpenIPSL library(generator)"
  extends OpenIPSL.Examples.BaseTest(pwLine2(displayPF=true), pwLine1(displayPF=true));
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(H_r=48) annotation (Placement(visible=true, transformation(
        origin={-80,-50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe intake(H=23) annotation (Placement(visible=true, transformation(extent={{-64,-60},{-44,-40}},
                                                                                                                    rotation=0)));
  OpenHPL.Waterway.Pipe discharge(L=600, H=0.5) annotation (Placement(visible=true, transformation(extent={{48,-60},{68,-40}},
                                                                                                                             rotation=0)));
  OpenHPL.Waterway.Reservoir tail(H_r=5) annotation (Placement(visible=true, transformation(
        origin={84,-50},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.PenstockKP penstock(
    L=600,
    H=428.5,
    D_i=3,
    D_o=3) annotation (Placement(visible=true, transformation(
        origin={4,-50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.SurgeTank surgeTank(h_0=70.939) annotation (Placement(visible=true, transformation(
        origin={-26,-50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.ElectroMech.Turbines.Francis turbine(
    D_i=1.632,
    GivenData=true,
    GivenServoData=false,
    Given_losses=true,
    H_n=460,
    P_n(displayUnit="MW") = 103000000,
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
    r_Y_=1.2,
    r_v_=1.1,
    w_1_=0.2,
    w_v_=0.2) annotation (Placement(visible=true, transformation(
        origin={32,-50},
        extent={{-10,10},{10,-10}},
        rotation=0)));
  inner OpenHPL.Constants Const(V_0 = 4.49) annotation (
    Placement(visible = true, transformation(origin={-90,70},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Machines.PSAT.Order2 order2_1(D = 0, M = 10,
    P_0=16035269.869201,
    Q_0=11859436.505981,
    Sn=120000000,
    Vn=400000,                                                                                                                       ra = 0.001, w(fixed = true), x1d = 0.302) annotation (
    Placement(visible = true, transformation(extent={{-40,-10},{-20,10}},   rotation = 0)));
  Modelica.Blocks.Math.Gain PSI_to_Ppu(k=1/turbine.P_n)
                                                      annotation (
    Placement(visible = true, transformation(origin={-59,-5},     extent={{-5,-5},{5,5}},      rotation = 0)));
  Modelica.Blocks.Math.Gain wpu_to_wSI(k=2*Modelica.Constants.pi/60*turbine.n_n) annotation (Placement(visible=true, transformation(
        origin={-60,20},
        extent={{-6,6},{6,-6}},
        rotation=180)));
  OpenHPL.Controllers.Governor governor(Pn = turbine.P_n, Y_gv_ref = 0.1)
                                       annotation (Placement(visible=true, transformation(origin = {20, -72}, extent = {{-10, -10}, {10, 10}},
                                                                                                                    rotation=0)));
  //(a = 7.862E-25, c = 1.108E-08, d = -5.344E-02, b = -1.010E-16)
  Modelica.Blocks.Math.Gain fpu_to_fSI(k=SysData.fn) annotation (Placement(visible=true, transformation(
        origin={-50,-90},
        extent={{6,6},{-6,-6}},
        rotation=180)));
  Modelica.Blocks.Sources.Ramp power(duration = 1, height = +1e6, offset = 12e6,
    startTime=200)                                                                                  annotation (
    Placement(visible = true, transformation(origin={-10,-72},  extent={{-8,-8},{8,8}},      rotation = 0)));
equation
  connect(fpu_to_fSI.y, governor.f) annotation (
    Line(points={{-43.4,-90},{4,-90},{4,-76},{8,-76},{8,-76}},          color = {0, 0, 127}));
  connect(governor.Y_gv, turbine.u_t) annotation (
    Line(points = {{31, -72}, {32, -72}, {32, -62}}, color = {0, 0, 127}));
  connect(governor.P_ref, power.y) annotation (
    Line(points = {{8, -68}, {4.4, -68}, {4.4, -72}, {-1.2, -72}}, color = {0, 0, 127}));
  connect(surgeTank.n, penstock.p) annotation (
    Line(points={{-16,-50},{-6,-50}},                         color = {28, 108, 200}));
  connect(surgeTank.p, intake.n) annotation (
    Line(points={{-36,-50},{-44,-50}},                                   color = {28, 108, 200}));
  connect(penstock.n, turbine.p) annotation (
    Line(points={{14,-50},{22,-50}},                                  color = {28, 108, 200}));
  connect(reservoir.n, intake.p) annotation (
    Line(points={{-70,-50},{-64,-50}},                                          color = {28, 108, 200}));
  connect(fpu_to_fSI.u, wpu_to_wSI.u) annotation (Line(points={{-57.2,-90},{-94,-90},{-94,30},{-48,30},{-48,20},{-52.8,20}}, color={0,0,127}));
  connect(order2_1.w, wpu_to_wSI.u) annotation (Line(points={{-19,9},{-14,9},{-14,20},{-52.8,20}}, color={0,0,127}));
  connect(PSI_to_Ppu.u, turbine.P_out) annotation (
    Line(points={{-65,-5},{-70,-5},{-70,-24},{32,-24},{32,-39}},           color = {0, 0, 127}));
  connect(PSI_to_Ppu.y, order2_1.pm) annotation (
    Line(points={{-53.5,-5},{-42,-5}},          color = {0, 0, 127}));
  connect(order2_1.vf, order2_1.vf0) annotation (
    Line(points={{-42,5},{-46,5},{-46,14},{-38,14},{-38,11}},           color = {0, 0, 127}));
  connect(wpu_to_wSI.y, turbine.w_in) annotation (Line(points={{-66.6,20},{-80,20},{-80,-32},{16,-32},{16,-42},{20,-42}}, color={0,0,127}));
  connect(order2_1.p, bus1.p) annotation (Line(points={{-20,0},{0,0}}, color={0,0,255}));
  connect(discharge.n, tail.n) annotation (Line(points={{68,-50},{74,-50}}, color={28,108,200}));
  connect(turbine.n, discharge.p) annotation (Line(points={{42,-50},{48,-50}}, color={28,108,200}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPSimple_Francis_GridGen;
