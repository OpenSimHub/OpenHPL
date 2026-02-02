within OpenHPL.Examples;
model SimpleValve "Model of a hydropower system with a simple turbine turbine"
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
  OpenHPL.Waterway.Pipe discharge(H=0.5, L=600) annotation (Placement(transformation(extent={{50,20},{70,40}})));
  OpenHPL.Waterway.Reservoir tail(h_0=5) annotation (Placement(transformation(
        origin={90,30},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  replaceable OpenHPL.Waterway.Pipe penstock(
    D_i=3,
    D_o=3,
    H=80,
    L=200,
    vertical=true) constrainedby Interfaces.TwoContacts annotation (Placement(transformation(origin={0,30}, extent={{-10,-10},{10,10}})));
  OpenHPL.Waterway.SurgeTank surgeTank(
    H=30,
    L=30,
    h_0=20)                                      annotation (Placement(transformation(
        origin={-30,30},
        extent={{-10,-10},{10,10}})));
  inner OpenHPL.Data data(Vdot_0=3)
                          annotation (Placement(transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}})));
  Waterway.Valve valve(
    ValveCapacity=false,
    C_v=1)               annotation (Placement(transformation(extent={{20,20},{40,40}})));
equation
  connect(reservoir.o, intake.i) annotation (
    Line(points={{-80,30},{-70,30}}, color = {28, 108, 200}));
  connect(intake.o, surgeTank.i) annotation (
    Line(points={{-50,30},{-40,30}}, color = {28, 108, 200}));
  connect(surgeTank.o, penstock.i) annotation (Line(points={{-20,30},{-10,30}}, color={28,108,200}));
  connect(discharge.o, tail.o) annotation (Line(points={{70,30},{80,30}},
                                                                        color={28,108,200}));
  connect(penstock.o, valve.i) annotation (Line(points={{10,30},{20,30}}, color={0,128,255}));
  connect(valve.o, discharge.i) annotation (Line(points={{40,30},{50,30}}, color={0,128,255}));
  connect(control.y, valve.opening) annotation (Line(points={{1,70},{30,70},{30,38}}, color={0,0,127}));
  annotation (experiment(StopTime=1000), Documentation(info="<html>
<p>
Simple model of a water way with only a valve component. 
This can be used to investigate the effect of different opening and closing times in the waterway.
</p>
</html>"));
end SimpleValve;
