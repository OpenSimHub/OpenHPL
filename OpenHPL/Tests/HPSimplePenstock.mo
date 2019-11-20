within OpenHPL.Tests;
model HPSimplePenstock "Model of HP system with simplified models for penstock, turbine, etc."
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(H_r=48) annotation (Placement(visible=true, transformation(
        origin={-94,64},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = -0.04615, offset = 0.7493, startTime = 600) annotation (
    Placement(visible = true, transformation(origin = {-16, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe intake(H=23) annotation (Placement(visible=true, transformation(extent={{-76,50},{-56,70}}, rotation=0)));
  OpenHPL.Waterway.Pipe discharge(H=0.5, L=600) annotation (Placement(visible=true, transformation(extent={{42,22},{62,42}}, rotation=0)));
  OpenHPL.Waterway.Reservoir tail(H_r=5) annotation (Placement(visible=true, transformation(
        origin={80,40},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.Pipe penstock(
    D_i=3,
    D_o=3,
    H=428.5,
    L=600) annotation (Placement(visible=true, transformation(
        origin={-16,50},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  OpenHPL.Waterway.SurgeTank surgeTank(h_0=69.9) annotation (Placement(visible=true, transformation(
        origin={-36,64},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  //Modelica.Blocks.Sources.Ramp load(duration = 1, height = -5e6, offset = 80e6, startTime = 600) annotation(
  //  Placement(visible = true, transformation(extent = {{-40, -6}, {-20, 14}}, rotation = 0)));
  //OpenHPL.HydroPower.Aggregate aggregate annotation(
  //  Placement(visible = true, transformation(extent = {{-4, -6}, {16, 14}}, rotation = 0)));
  ElectroMech.Turbines.Turbine turbine(C_v=3.7, ConstEfficiency=false) annotation (Placement(visible=true, transformation(
        origin={6,34},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner OpenHPL.Parameters Const annotation (Placement(visible=true, transformation(
        origin={-90,92},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe pipe1(
    D_i=1.55,
    D_o=1.83,
    H=2.3,
    L=0.1) annotation (Placement(visible=true, transformation(extent={{16,14},{36,34}}, rotation=0)));
  OpenHPL.Waterway.Pipe pipe2(
    D_i=1.83,
    D_o=2.8,
    H=0.1,
    L=7.75) annotation (Placement(visible=true, transformation(extent={{22,40},{42,60}}, rotation=0)));
equation
  connect(discharge.p, pipe2.n) annotation (
    Line(points = {{42, 32}, {42, 32}, {42, 50}, {42, 50}}, color = {28, 108, 200}));
  connect(pipe1.n, pipe2.p) annotation (
    Line(points = {{36, 24}, {36, 40}, {22, 40}, {22, 50}}, color = {28, 108, 200}));
  connect(turbine.n, pipe1.p) annotation (
    Line(points = {{16, 34}, {16, 34}, {16, 24}, {16, 24}}, color = {28, 108, 200}));
  connect(discharge.n, tail.n) annotation (
    Line(points={{62,32},{62,36.95},{70,36.95},{70,40}},                      color = {28, 108, 200}));
  //connect(turbine.P_out, aggregate.P_in) annotation(
  //  Line(points = {{-3.8, 34}, {2, 34}, {2, 14}, {2, 14}}, color = {0, 0, 127}));
  //connect(load.y, aggregate.u) annotation(
  //  Line(points = {{-19, 4}, {-12.5, 4}, {-12.5, 4}, {-4, 4}}, color = {0, 0, 127}));
  connect(control.y, turbine.u_t) annotation (
    Line(points={{-5,86},{6,86},{6,46}},          color = {0, 0, 127}));
  connect(penstock.n, turbine.p) annotation (
    Line(points={{-16,40},{-11.05,40},{-11.05,34},{-4,34}},                      color = {28, 108, 200}));
  connect(reservoir.n, intake.p) annotation (
    Line(points={{-84,64},{-79.95,64},{-79.95,60},{-76,60}},                      color = {28, 108, 200}));
  connect(intake.n, surgeTank.p) annotation (
    Line(points={{-56,60},{-50.95,60},{-50.95,64},{-46,64}},                      color = {28, 108, 200}));
  connect(surgeTank.n, penstock.p) annotation (
    Line(points={{-26,64},{-21.95,64},{-21.95,60},{-16,60}},                      color = {28, 108, 200}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPSimplePenstock;
