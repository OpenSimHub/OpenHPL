within OpenHPL.Examples.WithOpenIPSL;
model SimpleGen "Synergy with OpenIPSL library(generator)"
  extends Modelica.Icons.Example;
  extends OpenIPSL.Tests.BaseClasses.MachineTestBase(pwLine2(displayPF=true), pwLine1(displayPF=true));
  OpenHPL.Waterway.Reservoir reservoir(h_0=48,
    fixElevation=true,
    z_0=500)                                   annotation (Placement(transformation(
        origin={-80,-80},
        extent={{-10,-10},{10,10}})));
  OpenHPL.Waterway.Pipe intake(H=23, D_i=3)
                                     annotation (Placement(transformation(extent={{-66,-90},{-46,-70}})));
  OpenHPL.Waterway.Pipe discharge(L=600, H=0.5) annotation (Placement(transformation(extent={{48,-90},{68,-70}})));
  OpenHPL.Waterway.Reservoir tail(h_0=5) annotation (Placement(transformation(
        origin={84,-80},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  replaceable
  Waterway.Pipe penstock(
    vertical=true,
    L=600,
    H=428.5,
    D_i=3) constrainedby Interfaces.TwoContacts
           annotation (Placement(transformation(
        origin={0,-80},
        extent={{-10,-10},{10,10}})));
  OpenHPL.Waterway.SurgeTank surgeTank(h_0=70.939) annotation (Placement(transformation(
        origin={-30,-80},
        extent={{-10,-10},{10,10}})));
  ElectroMech.Turbines.Turbine         turbine(
    H_n=460,
    Vdot_n=24.3,
    Pmax(displayUnit="MW") = 125000000,
    enable_P_out=true)
              annotation (Placement(transformation(
        origin={32,-80},
        extent={{-10,-10},{10,10}})));
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
  OpenHPL.Controllers.Governor governor(Pn=103,           Y_gv_ref = 0.1)
                                       annotation (Placement(transformation(origin={0,-40},  extent = {{-10, -10}, {10, 10}})));
  //(a = 7.862E-25, c = 1.108E-08, d = -5.344E-02, b = -1.010E-16)
  Modelica.Blocks.Math.Gain fpu_to_fSI(k=SysData.fn) annotation (Placement(transformation(
        origin={-60,-52},
        extent={{6,6},{-6,-6}},
        rotation=180)));
  Modelica.Blocks.Sources.Ramp power(duration = 1, height = +1e6, offset = 12e6,
    startTime=200) annotation (
    Placement(transformation(origin={-36,-36}, extent={{-8,-8},{8,8}})));
equation
  connect(fpu_to_fSI.y, governor.f) annotation (
    Line(points={{-53.4,-52},{-22,-52},{-22,-44},{-12,-44}},
                                                           color = {0, 0, 127}));
  connect(governor.Y_gv, turbine.u_t) annotation (
    Line(points={{11,-40},{24,-40},{24,-68}}, color = {0, 0, 127}));
  connect(governor.P_ref, power.y) annotation (
    Line(points={{-12,-36},{-27.2,-36}},                   color = {0, 0, 127}));
  connect(generator.vf, generator.vf0) annotation (Line(points={{-42,5},{-46,5},{-46,14},{-38,14},{-38,11}}, color={0,0,127}));
  connect(generator.p, bus1.p) annotation (Line(points={{-20,0},{0,0}}, color={0,0,255}));
  connect(discharge.o, tail.o) annotation (Line(points={{68,-80},{74,-80}}, color={28,108,200}));
  connect(turbine.o, discharge.i) annotation (Line(points={{42,-80},{48,-80}}, color={28,108,200}));
  connect(turbine.i, penstock.o) annotation (Line(points={{22,-80},{10,-80}}, color={28,108,200}));
  connect(penstock.i, surgeTank.o) annotation (Line(points={{-10,-80},{-20,-80}},color={28,108,200}));
  connect(surgeTank.i, intake.o) annotation (Line(points={{-40,-80},{-46,-80}}, color={28,108,200}));
  connect(intake.i, reservoir.o) annotation (Line(points={{-66,-80},{-70,-80}}, color={28,108,200}));
  connect(turbine.P_out, generator.pm) annotation (Line(points={{36,-69},{36,-22},{-52,-22},{-52,-5},{-42,-5}}, color={0,0,127}));
  connect(generator.w, fpu_to_fSI.u) annotation (Line(points={{-19,9},{-14,9},{-14,20},{-72,20},{-72,-52},{-67.2,-52}}, color={0,0,127}));
annotation (experiment(StopTime = 2000));
end SimpleGen;
