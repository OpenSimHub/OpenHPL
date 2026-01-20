within OpenHPL.Examples.WithOpenIPSL;
model SimpleGenFrancisTG "Synergy with OpenIPSL library(generator)"
  extends Modelica.Icons.Example;
  extends OpenIPSL.Tests.BaseClasses.MachineTestBase(pwLine2(displayPF=true), pwLine1(displayPF=true));
  OpenHPL.Waterway.Reservoir reservoir(h_0=48) annotation (Placement(transformation(
        origin={-80,-50},
        extent={{-10,-10},{10,10}})));
  OpenHPL.Waterway.Pipe intake(H=23) annotation (Placement(transformation(extent={{-66,-60},{-46,-40}})));
  OpenHPL.Waterway.Pipe discharge(L=600, H=0.5) annotation (Placement(transformation(extent={{48,-60},{68,-40}})));
  OpenHPL.Waterway.Reservoir tail(h_0=5) annotation (Placement(transformation(
        origin={84,-50},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  replaceable
  Waterway.Pipe penstock(
    vertical=true,
    L=600,
    H=428.5,
    D_i=3) constrainedby Interfaces.TwoContacts
           annotation (Placement(transformation(
        origin={0,-50},
        extent={{-10,-10},{10,10}})));
  OpenHPL.Waterway.SurgeTank surgeTank(h_0=70.939) annotation (Placement(transformation(
        origin={-30,-50},
        extent={{-10,-10},{10,10}})));
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
        origin={32,-50},
        extent={{-10,10},{10,-10}})));
  inner OpenHPL.Data data(SteadyState=true, Vdot_0=4.49)
                                       annotation (Placement(transformation(
        origin={-90,70},
        extent={{-10,-10},{10,10}})));
  OpenIPSL.Electrical.Machines.PSAT.Order2 generator(
    D=0,
    M=10,
    P_0=16035269.869201,
    Q_0=11859436.505981,
    Sn=120000000,
    Vn=400000,
    ra=0.001,
    w(fixed=true),
    x1d=0.302) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Math.Gain PSI_to_Ppu(k=1/turbine.P_n)
                                                      annotation (
    Placement(transformation(origin={-59,-5}, extent={{-5,-5},{5,5}})));
  Modelica.Blocks.Math.Gain wpu_to_wSI(k=2*Modelica.Constants.pi/60*turbine.n_n) annotation (Placement(transformation(
        origin={-60,20},
        extent={{-6,6},{6,-6}},
        rotation=180)));
  //(a = 7.862E-25, c = 1.108E-08, d = -5.344E-02, b = -1.010E-16)
  OpenIPSL.Electrical.Controls.PSAT.TG.TGTypeI tGTypeI(
    R=0.1,
    T3=0.04,
    T4=5,
    T5=0.04,
    Tc=1,
    Ts=0.1,
    pmax=1,
    pmin=0,
    pref=0.1537,
    wref=1) annotation (
    Placement(transformation(extent={{-12,-92},{12,-68}})));
equation
  connect(generator.w, wpu_to_wSI.u) annotation (Line(points={{-19,9},{-16,9},{-16,20},{-52.8,20}}, color={0,0,127}));
  connect(PSI_to_Ppu.u, turbine.P_out) annotation (
    Line(points={{-65,-5},{-70,-5},{-70,-24},{36,-24},{36,-61}}, color = {0, 0, 127}));
  connect(PSI_to_Ppu.y, generator.pm) annotation (Line(points={{-53.5,-5},{-42,-5}}, color={0,0,127}));
  connect(generator.vf, generator.vf0) annotation (Line(points={{-42,5},{-46,5},{-46,14},{-38,14},{-38,11}}, color={0,0,127}));
  connect(wpu_to_wSI.y, turbine.w_in) annotation (Line(points={{-66.6,20},{-80,20},{-80,-32},{16,-32},{16,-42},{20,-42}}, color={0,0,127}));
  connect(generator.p, bus1.p) annotation (Line(points={{-20,0},{0,0}}, color={0,0,255}));
  connect(discharge.o, tail.o) annotation (Line(points={{68,-50},{74,-50}}, color={28,108,200}));
  connect(turbine.o, discharge.i) annotation (Line(points={{42,-50},{48,-50}}, color={28,108,200}));
  connect(turbine.i, penstock.o) annotation (Line(points={{22,-50},{10,-50}}, color={28,108,200}));
  connect(penstock.i, surgeTank.o) annotation (Line(points={{-10,-50},{-20,-50}},color={28,108,200}));
  connect(surgeTank.i, intake.o) annotation (Line(points={{-40,-50},{-46,-50}}, color={28,108,200}));
  connect(intake.i, reservoir.o) annotation (Line(points={{-66,-50},{-70,-50}}, color={28,108,200}));
  connect(tGTypeI.pm, turbine.u_t) annotation (Line(points={{13.2,-80},{24,-80},
          {24,-62}},                                                                       color={0,0,127}));
  connect(tGTypeI.w, wpu_to_wSI.u) annotation (Line(points={{-14.4,-80},{-92,-80},{-92,32},{-16,32},{-16,20},{-52.8,20}}, color={0,0,127}));
  annotation (experiment(StopTime = 2000));
end SimpleGenFrancisTG;
