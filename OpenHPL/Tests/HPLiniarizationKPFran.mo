within OpenHPL.Tests;
model HPLiniarizationKPFran "HP system model for liniarization with elastic penstock (KP) + Francis turbine + generator"
  extends Modelica.Icons.Example;
  input Real u;
  output Real P, f;
  Waterway.Reservoir reservoir(h_0=48) annotation (Placement(transformation(
        origin={-92,62},
        extent={{-10,-10},{10,10}})));
  Waterway.Pipe intake(H=23, Vdot_0=19.0777) annotation (Placement(transformation(extent={{-72,50},{-52,70}})));
  Waterway.Pipe discharge(
    H=0.5,
    L=600,
    Vdot_0=19.0777) annotation (Placement(transformation(extent={{30,24},{50,44}})));
  Waterway.Reservoir tail(h_0=5) annotation (Placement(transformation(
        origin={94,40},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Waterway.PenstockKP penstock(
    D_i=3,
    D_o=3,
    H=428.5,
    L=600,
    N=10,
    h_s0=69,
    Vdot_0=19.0777*ones(10),
    p_p0=997*9.81*(69 + 428.5/10/2):997*9.81*428.5/10:997*9.81*(69 + 428.5/10*(10 - 1/2))) annotation (Placement(transformation(
        origin={-10,48},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  Waterway.SurgeTank surgeTank(h_0=69.908) annotation (Placement(transformation(
        origin={-30,66},
        extent={{-10,-10},{10,10}})));
  inner OpenHPL.Data data annotation (Placement(transformation(
        origin={-90,92},
        extent={{-10,-10},{10,10}})));
  ElectroMech.Turbines.Francis turbine annotation (Placement(transformation(
        origin={10,34},
        extent={{-10,-10},{10,10}})));
  ElectroMech.Generators.SynchGen generator(
    SelfInitialization=true,
    EEd_0=-7207.13,
    EEq_0=18005.2,
    Ef_0=38110.4,
    Vstabilizer_0=0,
    DELTA_0=0.65703268757177,
    w_0=52.3599) annotation (Placement(transformation(extent={{0,-2},{20,18}})));
equation
  connect(generator.w_out, turbine.w_in) annotation (
    Line(points = {{16, 18}, {14, 18}, {14, 24}, {14, 24}}, color = {0, 0, 127}));
  connect(generator.w_out, turbine.w_in) annotation (
    Line(points = {{16, 18}, {14, 18}, {14, 24}, {14, 24}}, color = {0, 0, 127}));
  connect(turbine.P_out, generator.P_in) annotation (
    Line(points = {{6, 24}, {4, 24}, {4, 20}, {4, 20}, {4, 18}}, color = {0, 0, 127}));
  connect(reservoir.n, intake.p) annotation (
    Line(points = {{-81.9, 61.9}, {-77.95, 61.9}, {-77.95, 59.9}, {-71.9, 59.9}}, color = {28, 108, 200}));
  connect(intake.n, surgeTank.p) annotation (
    Line(points = {{-51.9, 59.9}, {-45.95, 59.9}, {-45.95, 65.9}, {-39.9, 65.9}}, color = {28, 108, 200}));
  connect(surgeTank.n, penstock.p) annotation (
    Line(points = {{-19.9, 65.9}, {-15.95, 65.9}, {-15.95, 57.9}, {-10.1, 57.9}}, color = {28, 108, 200}));
  connect(discharge.n, tail.n) annotation (
    Line(points = {{50.1, 33.9}, {62.05, 33.9}, {62.05, 39.9}, {83.9, 39.9}}, color = {28, 108, 200}));
  connect(penstock.n, turbine.p) annotation (
    Line(points = {{-10.1, 37.9}, {-10.1, 33.9}, {0.1, 33.9}}, color = {28, 108, 200}));
  connect(turbine.n, discharge.p) annotation (
    Line(points = {{20.1, 33.9}, {25.05, 33.9}, {30.1, 33.9}}, color = {28, 108, 200}));
  turbine.u_t = u;
  P = generator.Pe;
  f = generator.f;
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPLiniarizationKPFran;
