within OpenHPLTest;
model TorpaHPPAirCushionTest2 "Test case for air cushion surge tank from Torpa hydro power plant."
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(h_0=48) annotation (Placement(transformation(
        origin={-90,30},
        extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = -0.04615, offset = 0.7493, startTime = 600) annotation (
    Placement(transformation(origin={-10,70}, extent = {{-10, -10}, {10, 10}})));
  OpenHPL.Waterway.Pipe intake(H=23) annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
  OpenHPL.Waterway.Pipe discharge(H=0.5, L=600) annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  OpenHPL.Waterway.Reservoir tail(h_0=5) annotation (Placement(transformation(
        origin={90,0},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.Pipe penstock(
    D_i=3,
    D_o=3,
    H=428.5,
    L=600,
    vertical=true) annotation (Placement(transformation(
        origin={0,30},
        extent={{-10,-10},{10,10}})));
  OpenHPL.Waterway.SurgeTank surgeTank(h_0=69.9) annotation (Placement(transformation(
        origin={-30,30},
        extent={{-10,-10},{10,10}})));
  OpenHPL.ElectroMech.Turbines.Turbine turbine(C_v=3.7, ConstEfficiency=false) annotation (Placement(transformation(origin={44,50}, extent={{-10,-10},{10,10}})));
  inner OpenHPL.Data data annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation
  connect(turbine.o, discharge.i) annotation (
    Line(points={{54,50},{44,50},{44,0},{50,0}}, color = {28, 108, 200}));
  connect(control.y, turbine.u_t) annotation (
    Line(points={{1,70},{36,70},{36,62}}, color = {0, 0, 127}));
  connect(penstock.o, turbine.i) annotation (
    Line(points={{10,30},{14.95,30},{14.95,50},{34,50}}, color = {28, 108, 200}));
  connect(reservoir.o, intake.i) annotation (
    Line(points={{-80,30},{-70,30}}, color = {28, 108, 200}));
  connect(intake.o, surgeTank.i) annotation (
    Line(points={{-50,30},{-40,30}}, color = {28, 108, 200}));
  connect(surgeTank.o, penstock.i) annotation (
    Line(points={{-20,30},{-10,30}}, color = {28, 108, 200}));
  connect(discharge.o, tail.o) annotation (Line(points={{70,0},{80,0}}, color={28,108,200}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end TorpaHPPAirCushionTest2;
