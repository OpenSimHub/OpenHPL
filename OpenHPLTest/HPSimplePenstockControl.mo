within OpenHPLTest;
model HPSimplePenstockControl "Model of HP system with governor"
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir annotation (Placement(transformation(origin={-92,62}, extent={{-10,-10},{10,10}})));
  inner OpenHPL.Data data annotation (Placement(transformation(
        origin={-90,92},
        extent={{-10,-10},{10,10}})));
  OpenHPL.Waterway.Pipe intake annotation (Placement(transformation(extent={{-64,52},{-44,72}})));
  OpenHPL.Waterway.Pipe discharge(H=5, L=600) annotation (Placement(transformation(extent={{48,26},{68,46}})));
  OpenHPL.Waterway.Reservoir tail(h_0=10) annotation (Placement(transformation(
        origin={86,42},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.Pipe penstock(
    H=420,
    L=600,
    D_i=3.3,
    D_o=3.3) annotation (Placement(transformation(origin={-2,46}, extent={{-10,-10},{10,10}})));
  OpenHPL.Waterway.SurgeTank surgeTank annotation (Placement(transformation(origin={-22,66}, extent={{-10,-10},{10,10}})));
  OpenHPL.ElectroMech.Turbines.Turbine turbine(C_v=3.7) annotation (Placement(transformation(origin={26,36}, extent={{-10,-10},{10,10}})));
  OpenHPL.Controllers.Governor governor annotation (Placement(transformation(origin = {44, 84}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Sources.Ramp load(duration = 1, height = -3e6, offset = 80e6, startTime = 4000) annotation (
    Placement(transformation(extent = {{-16, -10}, {4, 10}})));
  OpenHPL.ElectroMech.Generators.SimpleGen simpleGen annotation (
    Placement(transformation(origin = {26, 8}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(simpleGen.f, governor.f) annotation (
    Line(points = {{38, 8}, {98, 8}, {98, 80}, {56, 80}, {56, 80}, {56, 80}}, color = {0, 0, 127}));
  connect(load.y, simpleGen.u) annotation (
    Line(points = {{6, 0}, {10, 0}, {10, 8}, {16, 8}, {16, 8}}, color = {0, 0, 127}));
  connect(turbine.P_out, simpleGen.P_in) annotation (
    Line(points = {{26, 26}, {26, 26}, {26, 20}, {26, 20}}, color = {0, 0, 127}));
  connect(load.y, governor.P_ref) annotation (
    Line(points = {{6, 0}, {100, 0}, {100, 88}, {56, 88}}, color = {0, 0, 127}));
  connect(governor.Y_gv, turbine.u_t) annotation (
    Line(points = {{33, 84}, {26, 84}, {26, 48}}, color = {0, 0, 127}));
  connect(discharge.n, tail.n) annotation (
    Line(points = {{68, 36}, {72, 36}, {72, 42}, {76, 42}}));
  connect(turbine.n, discharge.p) annotation (
    Line(points = {{36, 36}, {42.1, 36}, {48, 36}}));
  connect(turbine.p, penstock.n) annotation (
    Line(points = {{16, 36}, {12, 36}, {12, 46}, {8, 46}}));
  connect(intake.p, reservoir.n) annotation (
    Line(points = {{-64, 62}, {-66, 62}, {-66, 62}, {-67.9, 62}, {-67.9, 62}, {-82, 62}}));
  connect(intake.n, surgeTank.p) annotation (
    Line(points = {{-44, 62}, {-40, 62}, {-40, 66}, {-32, 66}}));
  connect(surgeTank.n, penstock.p) annotation (
    Line(points = {{-12, 66}, {-12, 66}, {-12, 46}}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPSimplePenstockControl;
