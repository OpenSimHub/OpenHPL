within OpenHPL.Tests;
model HPSimpleElasticPenstock "Model of HP system with elastic penctock (StagardGrid), but simplified models for turbine, etc."
  extends Modelica.Icons.Example;
  Waterway.Reservoir reservoir(h_0=48) annotation (Placement(visible=true, transformation(
        origin={-90,62},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = -0.04615, offset = 0.7493, startTime = 600) annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin={10,82})));
  inner OpenHPL.Data data annotation (Placement(visible=true, transformation(
        origin={-90,92},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.Pipe intake(
    H=23,
    SteadyState=false,
    Vdot_0=19.06) annotation (Placement(visible=true, transformation(extent={{-66,52},{-46,72}}, rotation=0)));
  Waterway.Pipe discharge(
    H=0.5,
    L=600,
    SteadyState=false,
    Vdot_0=19.06) annotation (Placement(visible=true, transformation(extent={{54,26},{74,46}}, rotation=0)));
  Waterway.Reservoir tail(h_0=10) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={92,42})));
  Waterway.SurgeTank surgeTank1(SteadyState=false, h_0=71) annotation (Placement(visible=true, transformation(
        origin={-26,62},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.Penstock penstock(
    D_i=3,
    D_o=3,
    H=428.5,
    N=10,
    Vdot_0=19.06) annotation (Placement(visible=true, transformation(
        origin={0,54},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.ElectroMech.Turbines.Turbine turbine(C_v=3.7, WaterCompress=true) annotation (Placement(visible=true, transformation(extent={{20,26},{40,46}}, rotation=0)));
  Modelica.Blocks.Sources.Ramp load(duration = 1, height = -5e6, offset = 80e6, startTime = 600) annotation (
    Placement(visible = true, transformation(extent = {{-10, -4}, {10, 16}}, rotation = 0)));
  OpenHPL.ElectroMech.Generators.SimpleGen aggregate annotation (Placement(visible=true, transformation(extent={{20,-4},{40,16}}, rotation=0)));
equation
  connect(load.y, aggregate.u) annotation (
    Line(points = {{11, 6}, {20, 6}}, color = {0, 0, 127}));
  connect(turbine.P_out, aggregate.P_in) annotation (
    Line(points = {{26, 25}, {26, 16}}, color = {0, 0, 127}));
  connect(penstock.n, turbine.p) annotation (
    Line(points = {{10.1, 53.9}, {10.1, 43.95}, {20, 43.95}, {20, 36}}, color = {28, 108, 200}));
  connect(control.y, turbine.u_t) annotation (
    Line(points={{21,82},{22,82},{22,48}},        color = {0, 0, 127}));
  connect(reservoir.n, intake.p) annotation (
    Line(points = {{-79.9, 61.9}, {-72.95, 61.9}, {-72.95, 61.9}, {-65.9, 61.9}}, color = {28, 108, 200}));
  connect(intake.n, surgeTank1.p) annotation (
    Line(points = {{-45.9, 61.9}, {-40.95, 61.9}, {-40.95, 61.9}, {-35.9, 61.9}}, color = {28, 108, 200}));
  connect(surgeTank1.n, penstock.p) annotation (
    Line(points = {{-15.9, 61.9}, {-11.95, 61.9}, {-9.9, 61.9}, {-9.9, 53.9}}, color = {28, 108, 200}));
  connect(discharge.n, tail.n) annotation (
    Line(points = {{74.1, 35.9}, {78.05, 35.9}, {78.05, 41.9}, {81.9, 41.9}}, color = {28, 108, 200}));
  connect(turbine.o, discharge.i) annotation (Line(points={{40,36},{54,36}}, color={0,128,255}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPSimpleElasticPenstock;
