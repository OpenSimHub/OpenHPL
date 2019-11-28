within OpenHPL.Tests;
model HPLiniarizationKP "HP system model for liniarization with elastic penstock (KP)"
  extends Modelica.Icons.Example;
  input Real u(start = 0.7493);
  output Real dotV;
  Waterway.Reservoir reservoir(H_r=48) annotation (Placement(visible=true, transformation(
        origin={-92,62},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.Pipe intake(H=23, Vdot0=19.0777) annotation (Placement(visible=true, transformation(extent={{-72,50},{-52,70}}, rotation=0)));
  Waterway.Pipe discharge(
    H=0.5,
    L=600,
    Vdot0=19.0777) annotation (Placement(visible=true, transformation(extent={{30,24},{50,44}}, rotation=0)));
  OpenHPL.Waterway.Reservoir tail(H_r=5) annotation (Placement(visible=true, transformation(
        origin={72,40},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Waterway.PenstockKP penstock(
    D_i=3,
    D_o=3,
    H=428.5,
    L=600,
    N=10,
    PipeElasticity=true,
    Vdot0=19.0777*ones(10),
    h_s0=69,
    p_p0=997*9.81*(69 + 428.5/10/2):997*9.81*428.5/10:997*9.81*(69 + 428.5/10*(10 - 1/2))) annotation (Placement(visible=true, transformation(
        origin={-10,48},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  Waterway.SurgeTank surgeTank(h_0=69.908) annotation (Placement(visible=true, transformation(
        origin={-30,66},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner OpenHPL.Data data annotation (Placement(visible=true, transformation(
        origin={-90,92},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Turbines.Turbine turbine(C_v=3.7, WaterCompress=true) annotation (Placement(visible=true, transformation(
        origin={10,34},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  connect(discharge.n, tail.n) annotation (
    Line(points={{50,34},{56.05,34},{56.05,40},{62,40}},                color = {28, 108, 200}));
  connect(reservoir.n, intake.p) annotation (
    Line(points={{-82,62},{-77.95,62},{-77.95,60},{-72,60}},                      color = {28, 108, 200}));
  connect(intake.n, surgeTank.p) annotation (
    Line(points={{-52,60},{-45.95,60},{-45.95,66},{-40,66}},                      color = {28, 108, 200}));
  connect(surgeTank.n, penstock.p) annotation (
    Line(points={{-20,66},{-15.95,66},{-15.95,58},{-10,58}},                      color = {28, 108, 200}));
  connect(penstock.n, turbine.p) annotation (
    Line(points={{-10,38},{-10,34},{0,34}},                    color = {28, 108, 200}));
  connect(turbine.n, discharge.p) annotation (
    Line(points={{20,34},{25.05,34},{30,34}},                  color = {28, 108, 200}));
  turbine.u_t = u;
  dotV = turbine.Vdot;
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPLiniarizationKP;
