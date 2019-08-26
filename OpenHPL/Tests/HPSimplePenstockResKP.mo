within OpenHPL.Tests;
model HPSimplePenstockResKP "Model of HP system with using reservoir model based on open channel"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = -0.04615, offset = 0.7493, startTime = 600) annotation (
    Placement(visible = true, transformation(origin = {10, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp load(duration = 1, height = -5e6, offset = 80e6, startTime = 600) annotation (
    Placement(visible = true, transformation(extent = {{-12, -4}, {8, 16}}, rotation = 0)));
  Waterway.Pipe intake annotation (Placement(visible=true, transformation(extent={{-64,52},{-44,72}}, rotation=0)));
  Waterway.Pipe discharge(H=5, L=600) annotation (Placement(visible=true, transformation(extent={{46,26},{66,46}}, rotation=0)));
  Waterway.Reservoir tail(H_r=10) annotation (Placement(visible=true, transformation(
        origin={92,42},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  ElectroMech.Generators.SimpleGen aggregate annotation (Placement(visible=true, transformation(extent={{18,-4},{38,16}}, rotation=0)));
  Waterway.Pipe penstock(
    D_i=3.3,
    D_o=3.3,
    H=420,
    L=600) annotation (Placement(visible=true, transformation(
        origin={-2,46},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  Waterway.SurgeTank surgeTank annotation (Placement(visible=true, transformation(
        origin={-22,66},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Turbines.Turbine turbine(C_v=3.7) annotation (Placement(visible=true, transformation(
        origin={28,36},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner OpenHPL.Constants Const annotation (
    Placement(visible = true, transformation(origin = {-90, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Waterway.ReservoirChannel reservoir(
    N=20,
    w=1000,
    SteadyState=true) annotation (Placement(transformation(extent={{-102,52},{-82,72}})));
equation
  connect(turbine.P_out, aggregate.P_in) annotation (
    Line(points = {{28, 26}, {28, 26}, {28, 16}, {28, 16}}, color = {0, 0, 127}));
  connect(discharge.n, tail.n) annotation (
    Line(points = {{66.1, 35.9}, {76, 35.9}, {76, 41.9}, {81.9, 41.9}}));
  connect(turbine.n, discharge.p) annotation (
    Line(points = {{38.1, 35.9}, {43.1, 35.9}, {46.1, 35.9}}));
  connect(turbine.p, penstock.n) annotation (
    Line(points = {{18.1, 35.9}, {-2.1, 35.9}}));
  connect(load.y, aggregate.u) annotation (
    Line(points = {{9, 6}, {9, 6}, {18, 6}}, color = {0, 0, 127}));
  connect(intake.n, surgeTank.p) annotation (
    Line(points = {{-43.9, 61.9}, {-40, 61.9}, {-40, 65.9}, {-31.9, 65.9}}));
  connect(surgeTank.n, penstock.p) annotation (
    Line(points = {{-11.9, 65.9}, {-2.1, 65.9}, {-2.1, 55.9}}));
  connect(control.y, turbine.u_t) annotation (
    Line(points = {{21, 84}, {28, 84}, {28, 46.8}}, color = {0, 0, 127}));
  connect(intake.p, reservoir.n) annotation (
    Line(points = {{-63.9, 61.9}, {-72, 61.9}, {-72, 62.1}, {-81.9, 62.1}}, color = {28, 108, 200}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPSimplePenstockResKP;
