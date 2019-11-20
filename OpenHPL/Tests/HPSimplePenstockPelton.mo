within OpenHPL.Tests;
model HPSimplePenstockPelton "HP system model with Pelton turbine"
  extends Modelica.Icons.Example;
  Waterway.Reservoir reservoir(H_r=48) annotation (Placement(visible=true, transformation(
        origin={-92,62},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(duration = 1, offset = 0.015, startTime = 600, height = 0.01) annotation (
    Placement(visible = true, transformation(origin = {-10, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Waterway.Pipe intake(H=23) annotation (Placement(visible=true, transformation(extent={{-72,50},{-52,70}}, rotation=0)));
  Waterway.Pipe discharge(
    H=0.5,
    L=600,
    V_dot0=0) annotation (Placement(visible=true, transformation(extent={{30,24},{50,44}}, rotation=0)));
  Waterway.Reservoir tail(H_r=5) annotation (Placement(visible=true, transformation(
        origin={94,40},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Waterway.Pipe penstock(
    D_i=3,
    D_o=3,
    H=610,
    L=700) annotation (Placement(visible=true, transformation(
        origin={-10,48},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  Waterway.SurgeTank surgeTank(h_0=69.9) annotation (Placement(visible=true, transformation(
        origin={-30,66},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner OpenHPL.Parameters para annotation (Placement(visible=true, transformation(
        origin={-90,92},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Turbines.Pelton turbine(R=1.74/2, D_0=1) annotation (Placement(visible=true, transformation(
        origin={10,34},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.ElectroMech.Generators.SynchGen aggregate(np=5) annotation (Placement(visible=true, transformation(extent={{0,-4},{20,16}}, rotation=0)));
equation
  connect(aggregate.P_in, turbine.P_out) annotation (
    Line(points={{4,16},{4,19},{10,19},{10,23}},        color = {0, 0, 127}));
  connect(aggregate.w_out, turbine.w_in) annotation (
    Line(points={{16,16},{16,20},{14,20},{14,23.8}},        color = {0, 0, 127}));
  connect(reservoir.n, intake.p) annotation (
    Line(points={{-82,62},{-77.95,62},{-77.95,60},{-72,60}},                      color = {28, 108, 200}));
  connect(intake.n, surgeTank.p) annotation (
    Line(points={{-52,60},{-45.95,60},{-45.95,66},{-40,66}},                      color = {28, 108, 200}));
  connect(surgeTank.n, penstock.p) annotation (
    Line(points={{-20,66},{-15.95,66},{-15.95,58},{-10,58}},                      color = {28, 108, 200}));
  connect(penstock.n, turbine.p) annotation (
    Line(points={{-10,38},{-10,34},{0,34}},                    color = {28, 108, 200}));
  connect(discharge.n, tail.n) annotation (
    Line(points={{50,34},{62.05,34},{62.05,40},{84,40}},                      color = {28, 108, 200}));
  connect(turbine.n, discharge.p) annotation (
    Line(points={{20,34},{20,34},{30,34}},                    color = {28, 108, 200}));
  connect(control.y, turbine.u_t) annotation (
    Line(points={{1,84},{10,84},{10,46}},          color = {0, 0, 127}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPSimplePenstockPelton;
