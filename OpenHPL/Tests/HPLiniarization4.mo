within OpenHPL.Tests;
model HPLiniarization4 "Simple HP system model for liniarization"
  extends Modelica.Icons.Example;
  input Real u(start = 0.7493);
  output Real dotV;
  Waterway.Reservoir reservoir(h_0=48) annotation (Placement(transformation(
        origin={-92,62},
        extent={{-10,-10},{10,10}})));
  Waterway.Pipe intake(H=23, Vdot_0=19.0777) annotation (Placement(transformation(extent={{-72,50},{-52,70}})));
  OpenHPL.Waterway.Pipe discharge(
    H=0.5,
    L=600,
    Vdot_0=19.0777) annotation (Placement(transformation(extent={{30,24},{50,44}})));
  OpenHPL.Waterway.Reservoir tail(h_0=5) annotation (Placement(transformation(
        origin={72,40},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Waterway.Pipe penstock(
    D_i=3,
    D_o=3,
    H=428.5,
    L=600,
    Vdot_0=19.0777) annotation (Placement(transformation(
        origin={-10,48},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  Waterway.SurgeTank surgeTank(h_0=69.908, p_2=data.p_a) annotation (Placement(transformation(
        origin={-30,66},
        extent={{-10,-10},{10,10}})));
  inner OpenHPL.Data data annotation (Placement(transformation(
        origin={-90,92},
        extent={{-10,-10},{10,10}})));
  ElectroMech.Turbines.Turbine turbine(C_v=3.7) annotation (Placement(transformation(
        origin={10,34},
        extent={{-10,-10},{10,10}})));
equation
  connect(discharge.n, tail.n) annotation (
    Line(points = {{50, 34}, {56.05, 34}, {56.05, 40}, {62, 40}}, color = {28, 108, 200}));
  connect(turbine.n, discharge.p) annotation (
    Line(points = {{20.1, 33.9}, {25.1, 33.9}, {25.1, 34}, {30, 34}}, color = {28, 108, 200}));
  connect(reservoir.n, intake.p) annotation (
    Line(points = {{-81.9, 61.9}, {-77.95, 61.9}, {-77.95, 59.9}, {-71.9, 59.9}}, color = {28, 108, 200}));
  connect(intake.n, surgeTank.p) annotation (
    Line(points = {{-51.9, 59.9}, {-45.95, 59.9}, {-45.95, 65.9}, {-39.9, 65.9}}, color = {28, 108, 200}));
  connect(surgeTank.n, penstock.p) annotation (
    Line(points = {{-19.9, 65.9}, {-15.95, 65.9}, {-15.95, 57.9}, {-10.1, 57.9}}, color = {28, 108, 200}));
  connect(penstock.n, turbine.p) annotation (
    Line(points = {{-10.1, 37.9}, {-10.1, 33.9}, {0.1, 33.9}}, color = {28, 108, 200}));
  turbine.u_t = u;
  dotV = turbine.Vdot;
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPLiniarization4;
