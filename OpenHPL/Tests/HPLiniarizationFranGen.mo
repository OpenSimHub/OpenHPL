within OpenHPL.Tests;
model HPLiniarizationFranGen "HP system model for liniarization with Francis turbine + generator"
  extends Modelica.Icons.Example;
  Waterway.Pipe intake(H=23, V_dot0=18.5952) annotation (Placement(visible=true, transformation(extent={{-72,50},{-52,70}}, rotation=0)));
  input Real u = 0.576313;
  output Real P;
  //, f;
  Waterway.Reservoir reservoir(H_r=48) annotation (Placement(visible=true, transformation(
        origin={-92,62},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.Pipe discharge(
    H=0.5,
    L=600,
    V_dot0=18.5952) annotation (Placement(visible=true, transformation(extent={{30,24},{50,44}}, rotation=0)));
  Waterway.Reservoir tail(H_r=5) annotation (Placement(visible=true, transformation(
        origin={94,40},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Waterway.Pipe penstock(
    D_i=3,
    D_o=3,
    H=428.5,
    L=600,
    V_dot0=18.5952) annotation (Placement(visible=true, transformation(
        origin={-10,48},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  Waterway.SurgeTank surgeTank(h_0=69.963) annotation (Placement(visible=true, transformation(
        origin={-30,66},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner OpenHPL.Constants Const annotation (
    Placement(visible = true, transformation(origin = {-90, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ElectroMech.Turbines.Francis turbine(
    GivenData=false,
    GivenServoData=false,
    Given_losses=false,
    u_end_=2.3683,
    u_start_=2.24) annotation (Placement(visible=true, transformation(
        origin={10,34},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.ElectroMech.Generators.SynchGen generator(
    SelfInitialization=true,
    EEd_0=-7207.13,
    EEq_0=18005.2,
    Ef_0=38110.4,
    Vstabilizer_0=0,
    w_0=52.3599,
    DELTA_0=0.65703268757177) annotation (Placement(visible=true, transformation(extent={{0,-10},{20,10}}, rotation=0)));
equation
  connect(generator.w_out, turbine.w_in) annotation (
    Line(points = {{16, 10}, {16, 17}, {14, 17}, {14, 24}}, color = {0, 0, 127}));
  connect(turbine.P_out, generator.P_in) annotation (
    Line(points = {{6, 23}, {6, 16.5}, {4, 16.5}, {4, 10}}, color = {0, 0, 127}));
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
  //f = generator.f;
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPLiniarizationFranGen;
