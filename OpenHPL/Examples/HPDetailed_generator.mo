within OpenHPL.Examples;
model HPDetailed_generator "Model of waterway and aggregate of the HP system with detailed model for the penstock (using KP scheme) and simplified models for others conduits, turbine, etc."
  extends Modelica.Icons.Example;
  Waterway.Reservoir reservoir(H_r=48) annotation (Placement(visible=true, transformation(
        origin={-92,66},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = -0.04615, offset = 0.7493, startTime = 600) annotation (
    Placement(visible = true, transformation(origin = {0, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner OpenHPL.Constants Const(V_0 = 19.12, rho(displayUnit = "kg/m3") = 997) annotation (
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Waterway.Pipe intake(H=23) annotation (Placement(visible=true, transformation(extent={{-72,54},{-52,74}}, rotation=0)));
  Waterway.Pipe discharge(H=0.5, L=600) annotation (Placement(visible=true, transformation(extent={{38,30},{58,50}}, rotation=0)));
  Waterway.Reservoir tail(H_r=5) annotation (Placement(visible=true, transformation(
        origin={90,46},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.ElectroMech.Turbines.Turbine turbine(C_v=3.7, WaterCompress=true) annotation (Placement(visible=true, transformation(extent={{10,32},{30,52}}, rotation=0)));
  Waterway.SurgeTank surgeTank(h_0=69.9) annotation (Placement(visible=true, transformation(extent={{-42,60},{-22,80}}, rotation=0)));
  Waterway.PenstockKP penstockKP(
    D_i=3,
    D_o=3,
    H=428.5,
    PipeElasticity=false,
    h_s0=69.9,
    vertical=true) annotation (Placement(transformation(extent={{-20,44},{0,64}})));
  Modelica.Blocks.Sources.Ramp load(duration = 1, height = -4.9e6, offset = 80.3e6, startTime = 600) annotation (
    Placement(visible = true, transformation(extent = {{-22, 0}, {-2, 20}}, rotation = 0)));
  ElectroMech.Generators.SimpleGen generator annotation (Placement(visible=true, transformation(extent={{8,0},{28,20}}, rotation=0)));
equation
  connect(turbine.i, penstockKP.o) annotation (
    Line(points={{10,42},{4,42},{4,54},{0,54}},                color = {28, 108, 200}));
  connect(turbine.o, discharge.i) annotation (
    Line(points={{30,42},{34,42},{34,40},{38,40}},                color = {28, 108, 200}));
  connect(control.y, turbine.u_t) annotation (
    Line(points={{11,84},{20,84},{20,54}},        color = {0, 0, 127}));
  connect(turbine.P_out,generator. P_in) annotation (
    Line(points={{20,31},{20,25.5},{18,25.5},{18,22}},          color = {0, 0, 127}));
  connect(discharge.o, tail.o) annotation (
    Line(points={{58,40},{70,40},{70,46},{80,46}},                      color = {28, 108, 200}));
  connect(surgeTank.o, penstockKP.i) annotation (
    Line(points={{-22,70},{-20,70},{-20,54}},                    color = {28, 108, 200}));
  connect(intake.o, surgeTank.i) annotation (
    Line(points={{-52,64},{-46,64},{-46,70},{-42,70}},                      color = {28, 108, 200}));
  connect(reservoir.o, intake.i) annotation (
    Line(points={{-82,66},{-76,66},{-76,64},{-72,64}},                      color = {28, 108, 200}));
  connect(load.y,generator. u) annotation (
    Line(points = {{-1, 10}, {-1, 10}, {8, 10}}, color = {0, 0, 127}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPDetailed_generator;
