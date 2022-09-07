within OpenHPL.Tests;
model TestRunoff
  extends Modelica.Icons.Example;
  Waterway.Reservoir reservoir1(
    h_0=48,
    L=5000,
    UseInFlow=true,
    W=1000) annotation (Placement(transformation(
        origin={-58,40},
        extent={{-10,-10},{10,10}})));
  Waterway.RunOff_zones runOff annotation (Placement(transformation(extent={{-102,40},{-82,60}})));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = -0.04615, startTime = 600 * 1e10, offset = 0.3493) annotation (
    Placement(transformation(origin = {24, 62}, extent = {{-10, -10}, {10, 10}})));
  Waterway.Pipe intake(H=23) annotation (Placement(transformation(extent={{-36,26},{-16,46}})));
  Waterway.Pipe discharge(H=0.5, L=600) annotation (Placement(transformation(extent={{56,-2},{76,18}})));
  Waterway.Reservoir tail(h_0=5) annotation (Placement(transformation(
        origin={94,16},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Waterway.Pipe penstock(
    D_i=3,
    D_o=3,
    H=428.5,
    L=600) annotation (Placement(transformation(
        origin={24,26},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  Waterway.SurgeTank surgeTank(h_0=69.9) annotation (Placement(transformation(
        origin={2,42},
        extent={{-10,-10},{10,10}})));
  ElectroMech.Turbines.Turbine turbine(C_v=3.7) annotation (Placement(transformation(
        origin={40,12},
        extent={{-10,-10},{10,10}})));
  inner OpenHPL.Data data annotation (Placement(transformation(
        origin={-90,92},
        extent={{-10,-10},{10,10}})));
equation
  connect(reservoir1.inflow, runOff.Vdot_runoff) annotation (Line(points={{-68,40},{-76,40},{-76,50},{-82,50}}, color={0,0,127}));
  connect(control.y, turbine.u_t) annotation (
    Line(points={{35,62},{40,62},{40,24}},          color = {0, 0, 127}));
  connect(intake.n, surgeTank.p) annotation (
    Line(points={{-16,36},{-10.95,36},{-10.95,42},{-8,42}},                      color = {28, 108, 200}));
  connect(surgeTank.n, penstock.p) annotation (
    Line(points={{12,42},{18,42},{18,36},{20,36},{20,36},{24,36}},                          color = {28, 108, 200}));
  connect(turbine.n, discharge.p) annotation (
    Line(points={{50,12},{50,12},{56,12},{56,8}},                          color = {28, 108, 200}));
  connect(discharge.n, tail.n) annotation (
    Line(points={{76,8},{76,12.95},{84,12.95},{84,16}},                      color = {28, 108, 200}));
  connect(penstock.n, turbine.p) annotation (
    Line(points={{24,16},{28.95,16},{28.95,12},{30,12}},                      color = {28, 108, 200}));
  connect(reservoir1.n, intake.p) annotation (
    Line(points={{-48,40},{-42,40},{-42,36},{-36,36}},                      color = {28, 108, 200}));
  annotation (
    experiment(StopTime = 8.64e+006, Interval = 86400));
end TestRunoff;
