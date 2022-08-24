within OpenHPL.Tests;
model TestFitingSimpleHP "Model of HP system with pipe fitting"
  extends Modelica.Icons.Example;
  Waterway.Pipe conduit(
    H=25,
    L=6600,
    Vdot_0=19.06) annotation (Placement(visible=true, transformation(
        origin={-66,14},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.Reservoir reservoir annotation (Placement(visible=true, transformation(
        origin={-92,14},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.Pipe discharge(
    H=5,
    L=600,
    Vdot_0=19.06) annotation (Placement(visible=true, transformation(
        origin={64,-30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Turbines.Turbine turbine(C_v=3.7) annotation (Placement(visible=true, transformation(
        origin={40,-14},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.Reservoir tail(h_0=10) annotation (Placement(visible=true, transformation(
        origin={92,-30},
        extent={{10,-10},{-10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(duration = 1, startTime = 500, height = -0.04615, offset = 0.7493) annotation (
    Placement(visible = true, transformation(origin = {16, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Waterway.Fitting fitting(
    D_1=conduit.D_o,
    D_2=penstock.D_i,
    theta(displayUnit="deg")) annotation (Placement(transformation(extent={{-24,4},{-4,24}})));
  Waterway.Pipe penstock(
    H=420,
    L=600,
    D_i=3.3,
    D_o=3.3,
    Vdot_0=19.06) annotation (Placement(visible=true, transformation(
        origin={10,-4},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.SurgeTank surgeTank annotation (Placement(transformation(extent={{-50,4},{-30,24}})));
  Modelica.Blocks.Sources.Ramp load(duration = 1, height = -5e6, offset = 80e6, startTime = 600) annotation (
    Placement(visible = true, transformation(extent = {{0, -50}, {20, -30}}, rotation = 0)));
  ElectroMech.Generators.SimpleGen aggregate(SteadyState=false) annotation (Placement(visible=true, transformation(extent={{30,-50},{50,-30}}, rotation=0)));
equation
  connect(turbine.P_out, aggregate.P_in) annotation (
    Line(points = {{40, -24}, {40, -24}, {40, -30}, {40, -30}}, color = {0, 0, 127}));
  connect(control.y, turbine.u_t) annotation (
    Line(points = {{27, 50}, {39, 50}, {39, -3.2}, {40, -3.2}}, color = {0, 0, 127}));
  connect(discharge.n, tail.n) annotation (
    Line(points = {{74.1, -30.1}, {78, -30.1}, {78, -30.1}, {81.9, -30.1}}));
  connect(discharge.p, turbine.n) annotation (
    Line(points = {{54.1, -30.1}, {54.1, -22.1}, {54.1, -14.1}, {52.1, -14.1}, {50.1, -14.1}}));
  connect(fitting.n, penstock.p) annotation (
    Line(points = {{-3.9, 13.9}, {-4, 13.9}, {-4, -4}, {0, -4}, {0, -4.1}, {0.1, -4.1}}, color = {28, 108, 200}));
  connect(turbine.p, penstock.n) annotation (
    Line(points = {{30.1, -14.1}, {26, -14.1}, {26, -4.1}, {20.1, -4.1}}, color = {28, 108, 200}));
  connect(fitting.p, surgeTank.n) annotation (
    Line(points = {{-23.9, 13.9}, {-28, 13.9}, {-29.9, 13.9}}, color = {28, 108, 200}));
  connect(conduit.n, surgeTank.p) annotation (
    Line(points = {{-55.9, 13.9}, {-48, 13.9}, {-49.9, 13.9}}, color = {28, 108, 200}));
  connect(conduit.p, reservoir.n) annotation (
    Line(points = {{-75.9, 13.9}, {-75.95, 13.9}, {-75.95, 13.9}, {-81.9, 13.9}}, color = {28, 108, 200}));
  connect(load.y, aggregate.u) annotation (
    Line(points = {{21, -40}, {21, -40}, {30, -40}}, color = {0, 0, 127}));
  annotation (
    experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-06, Interval = 2));
end TestFitingSimpleHP;
