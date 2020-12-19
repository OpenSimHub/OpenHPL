within OpenHPL.Examples;
model HPSimple_generator "Model of waterway and aggregate of the HP system with simplified models for conduits, turbine, etc."
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(H_r=48) annotation (Placement(visible=true, transformation(
        origin={-90,10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = -0.04615, offset = 0.7493, startTime = 600) annotation (
    Placement(visible = true, transformation(origin={-10,40},    extent={{-10,-10},{10,10}},      rotation = 0)));
  OpenHPL.Waterway.Pipe intake(H=23) annotation (Placement(visible=true, transformation(extent={{-70,0},{-50,20}},  rotation=0)));
  OpenHPL.Waterway.Pipe discharge(H=0.5, L=600) annotation (Placement(visible=true, transformation(extent={{50,-10},{70,10}},rotation=0)));
  OpenHPL.Waterway.Reservoir tail(H_r=5) annotation (Placement(visible=true, transformation(
        origin={90,0},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.Pipe penstock(
    vertical=true,
    D_i=3,
    D_o=3,
    H=428.5,
    L=600) annotation (Placement(visible=true, transformation(
        origin={0,10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.SurgeTank surgeTank(h_0=69.9) annotation (Placement(visible=true, transformation(
        origin={-30,10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp load(duration = 1, height = -5.49e6, offset = 82.69e6, startTime = 600) annotation (
    Placement(visible = true, transformation(extent={{60,60},{40,80}},        rotation = 0)));
  ElectroMech.Generators.SimpleGen2        generator annotation (Placement(visible=true, transformation(extent={{20,30},{40,50}}, rotation=0)));
  ElectroMech.Turbines.Turbine2 turbine(C_v=3.7, ConstEfficiency=false) annotation (Placement(visible=true, transformation(
        origin={30,0},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner OpenHPL.Data data annotation (Placement(visible=true, transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  connect(penstock.o, turbine.i) annotation (Line(points={{10,10},{14.95,10},{14.95,0},{20,0}}, color={28,108,200}));
  connect(control.y, turbine.u_t) annotation (Line(points={{1,40},{12,40},{12,20},{22,20},{22,12}}, color={0,0,127}));
  connect(turbine.o, discharge.i) annotation (Line(points={{40,0},{50,0}}, color={28,108,200}));
  connect(reservoir.o, intake.i) annotation (
    Line(points={{-80,10},{-70,10}},                                              color = {28, 108, 200}));
  connect(intake.o, surgeTank.i) annotation (
    Line(points={{-50,10},{-40,10}},                                              color = {28, 108, 200}));
  connect(surgeTank.o, penstock.i) annotation (
    Line(points={{-20,10},{-10,10}},                                              color = {28, 108, 200}));
  connect(tail.o, discharge.o) annotation (Line(points={{80,7.21645e-16},{76,7.21645e-16},{76,0},{70,0}}, color={28,108,200}));
  connect(generator.flange, turbine.flange) annotation (Line(points={{30,40},{30,0}}, color={0,0,0}));
  connect(load.y, generator.P_load) annotation (Line(points={{39,70},{30,70},{30,52}}, color={0,0,127}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPSimple_generator;
