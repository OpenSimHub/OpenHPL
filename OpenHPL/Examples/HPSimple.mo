within OpenHPL.Examples;
model HPSimple "Model of waterway of the HP system with simplified models for conduits, turbine, etc."
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(H_r=48) annotation (Placement(visible=true, transformation(
        origin={-90,30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = -0.04615, offset = 0.7493, startTime = 600) annotation (
    Placement(visible = true, transformation(origin={-10,70},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe intake(H=23) annotation (Placement(visible=true, transformation(extent={{-70,20},{-50,40}}, rotation=0)));
  OpenHPL.Waterway.Pipe discharge(H=0.5, L=600) annotation (Placement(visible=true, transformation(extent={{50,-10},{70,10}}, rotation=0)));
  OpenHPL.Waterway.Reservoir tail(H_r=5, Input_level=false) annotation (Placement(visible=true, transformation(
        origin={90,0},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.Pipe penstock(
    D_i=3,
    D_o=3,
    H=428.5,
    L=600,
    vertical=true) annotation (Placement(visible=true, transformation(
        origin={0,30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.SurgeTank surgeTank(h_0=69.9) annotation (Placement(visible=true, transformation(
        origin={-30,30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Turbines.Turbine turbine(C_v=3.7, ConstEfficiency=false) annotation (Placement(visible=true, transformation(
        origin={30,10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner OpenHPL.Parameters Const annotation (Placement(visible=true, transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  connect(turbine.o, discharge.i) annotation (
    Line(points={{40,10},{44,10},{44,0},{50,0}},            color = {28, 108, 200}));
  connect(control.y, turbine.u_t) annotation (
    Line(points={{1,70},{30,70},{30,22}},         color = {0, 0, 127}));
  connect(penstock.o, turbine.i) annotation (
    Line(points={{10,30},{14.95,30},{14.95,10},{20,10}},                         color = {28, 108, 200}));
  connect(reservoir.o, intake.i) annotation (
    Line(points={{-80,30},{-70,30}},                                              color = {28, 108, 200}));
  connect(intake.o, surgeTank.i) annotation (
    Line(points={{-50,30},{-40,30}},                                              color = {28, 108, 200}));
  connect(surgeTank.o, penstock.i) annotation (
    Line(points={{-20,30},{-10,30}},                                              color = {28, 108, 200}));
  connect(discharge.o, tail.o) annotation (Line(points={{70,0},{80,0}}, color={28,108,200}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPSimple;
