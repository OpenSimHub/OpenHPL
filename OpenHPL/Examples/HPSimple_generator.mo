within OpenHPL.Examples;
model HPSimple_generator "Model of waterway and aggregate of the HP system with simplified models for conduits, turbine, etc."
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(H_r=48) annotation (Placement(visible=true, transformation(
        origin={-94,64},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = -0.04615, offset = 0.7493, startTime = 600) annotation (
    Placement(visible = true, transformation(origin = {-16, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe intake(H=23) annotation (Placement(visible=true, transformation(extent={{-76,50},{-56,70}}, rotation=0)));
  OpenHPL.Waterway.Pipe discharge(H=0.5, L=600) annotation (Placement(visible=true, transformation(extent={{36,22},{56,42}}, rotation=0)));
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
        origin={-38,66},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp load(duration = 1, height = -5.49e6, offset = 82.69e6, startTime = 600) annotation (
    Placement(visible = true, transformation(extent = {{-40, -6}, {-20, 14}}, rotation = 0)));
  OpenHPL.ElectroMech.Generators.SimpleGen generator annotation (Placement(visible=true, transformation(extent={{-2,-6},{18,14}}, rotation=0)));
  OpenHPL.ElectroMech.Turbines.Turbine turbine(C_v=3.7, ConstEfficiency=false) annotation (Placement(visible=true, transformation(
        origin={8,34},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner OpenHPL.Constants Const annotation (
    Placement(visible = true, transformation(origin = {-90, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(penstock.n, turbine.p) annotation (
    Line(points={{-16,40},{-11.05,40},{-11.05,34},{-2,34}},                color = {28, 108, 200}));
  connect(control.y, turbine.u_t) annotation (
    Line(points={{-5,86},{8,86},{8,46}},        color = {0, 0, 127}));
  connect(turbine.n, discharge.p) annotation (
    Line(points = {{18, 34}, {32, 34}, {32, 32}, {36, 32}}, color = {28, 108, 200}));
  connect(turbine.P_out,generator. P_in) annotation (
    Line(points={{8,23},{8,16}},                            color = {0, 0, 127}));
  connect(discharge.n, tail.n) annotation (
    Line(points={{56,32},{56,36.95},{70,36.95},{70,40}},                color = {28, 108, 200}));
  connect(load.y,generator. u) annotation (
    Line(points={{-19,4},{-2,4}},                              color = {0, 0, 127}));
  connect(reservoir.n, intake.p) annotation (
    Line(points={{-84,64},{-79.95,64},{-79.95,60},{-76,60}},                      color = {28, 108, 200}));
  connect(intake.n, surgeTank.p) annotation (
    Line(points={{-56,60},{-50.95,60},{-50.95,66},{-48,66}},                      color = {28, 108, 200}));
  connect(surgeTank.n, penstock.p) annotation (
    Line(points={{-28,66},{-21.95,66},{-21.95,60},{-16,60}},                      color = {28, 108, 200}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPSimple_generator;
