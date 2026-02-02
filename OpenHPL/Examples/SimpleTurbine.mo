within OpenHPL.Examples;
model SimpleTurbine "Model of a hydropower system with a simple turbine turbine"
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(h_0=10) annotation (Placement(transformation(
        origin={-90,30},
        extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp control(
    duration=30,
    height=-0.9,
    offset=1,
    startTime=500) annotation (
    Placement(transformation(origin={-10,70}, extent = {{-10, -10}, {10, 10}})));
  OpenHPL.Waterway.Pipe intake(H=10, Vdot(fixed = true)) annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
  OpenHPL.Waterway.Pipe discharge(H=0.5, L=600) annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  OpenHPL.Waterway.Reservoir tail(h_0=5) annotation (Placement(transformation(
        origin={90,0},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  replaceable OpenHPL.Waterway.Pipe penstock(
    D_i=3,
    D_o=3,
    H=80,
    L=200,
    vertical=true) constrainedby Interfaces.TwoContacts annotation (Placement(transformation(origin={0,30}, extent={{-10,-10},{10,10}})));
  OpenHPL.Waterway.SurgeTank surgeTank(h_0=20)   annotation (Placement(transformation(
        origin={-30,30},
        extent={{-10,-10},{10,10}})));
  ElectroMech.Turbines.Turbine turbine(enable_nomSpeed=true)
    annotation (Placement(transformation(
        origin={30,10},
        extent={{-10,-10},{10,10}})));
  inner OpenHPL.Data data(Vdot_0=3)
                          annotation (Placement(transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}})));
equation
  connect(turbine.o, discharge.i) annotation (Line(points={{40,10},{44,10},{44,0},{50,0}}, color={28,108,200}));
  connect(control.y, turbine.u_t) annotation (Line(points={{1,70},{16,70},{16,40},{22,40},{22,22}},
                                                                                    color={0,0,127}));
  connect(penstock.o, turbine.i) annotation (Line(points={{10,30},{14.95,30},{14.95,10},{20,10}}, color={28,108,200}));
  connect(reservoir.o, intake.i) annotation (
    Line(points={{-80,30},{-70,30}}, color = {28, 108, 200}));
  connect(intake.o, surgeTank.i) annotation (
    Line(points={{-50,30},{-40,30}}, color = {28, 108, 200}));
  connect(surgeTank.o, penstock.i) annotation (Line(points={{-20,30},{-10,30}}, color={28,108,200}));
  connect(discharge.o, tail.o) annotation (Line(points={{70,0},{80,0}}, color={28,108,200}));
  annotation (experiment(StopTime=1000));
end SimpleTurbine;
