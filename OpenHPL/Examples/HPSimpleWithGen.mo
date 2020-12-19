within OpenHPL.Examples;
model HPSimpleWithGen "Model of waterway of the HP system with simplified models for conduits, turbine, etc."
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(H_r=48) annotation (Placement(visible=true, transformation(
        origin={-90,30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(
    duration=30,
    height=-0.9,
    offset=1,
    startTime=200)                                                                                        annotation (
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
  ElectroMech.Turbines.Turbine turbine2(
    enable_P_out=true,
    C_v=3.7,
    ConstEfficiency=true) annotation (Placement(visible=true, transformation(
        origin={30,10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner OpenHPL.Data data annotation (Placement(visible=true, transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Generators.SimpleGen simpleGen2 annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Blocks.Math.Gain loadLevel(k=1) annotation (Placement(transformation(extent={{72,60},{52,80}})));
equation
  connect(turbine2.o, discharge.i) annotation (Line(points={{40,10},{44,10},{44,0},{50,0}}, color={28,108,200}));
  connect(control.y, turbine2.u_t) annotation (Line(points={{1,70},{14,70},{14,36},{22,36},{22,22}},
                                                                                     color={0,0,127}));
  connect(penstock.o, turbine2.i) annotation (Line(points={{10,30},{14.95,30},{14.95,10},{20,10}}, color={28,108,200}));
  connect(reservoir.o, intake.i) annotation (
    Line(points={{-80,30},{-70,30}},                                              color = {28, 108, 200}));
  connect(intake.o, surgeTank.i) annotation (
    Line(points={{-50,30},{-40,30}},                                              color = {28, 108, 200}));
  connect(surgeTank.o, penstock.i) annotation (
    Line(points={{-20,30},{-10,30}},                                              color = {28, 108, 200}));
  connect(discharge.o, tail.o) annotation (Line(points={{70,0},{80,0}}, color={28,108,200}));
  connect(turbine2.P_out, loadLevel.u) annotation (Line(points={{34,21},{34,30},{86,30},{86,70},{74,70}}, color={0,0,127}));
  connect(loadLevel.y, simpleGen2.P_load) annotation (Line(points={{51,70},{30,70},{30,62}}, color={0,0,127}));
  connect(simpleGen2.flange, turbine2.flange) annotation (Line(
      points={{30,50},{30,10},{30,10}},
      color={0,0,0},
      smooth=Smooth.Bezier));
  annotation (
    experiment(StopTime=600, Interval=0.4));
end HPSimpleWithGen;
