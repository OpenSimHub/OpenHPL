within OpenHPL.Tests.SummerProject2023;
model Model_III_PelRamp_Uel "System with stiff pipe and variable load"
  Modelica.Blocks.Sources.Constant const(k = 0) annotation (
    Placement(visible = true, transformation(origin={90,70},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch1 annotation (
    Placement(visible = true, transformation(origin={58,50},    extent={{10,-10},{-10,10}},  rotation = 0)));
  OpenHPL.Waterway.Reservoir reservoir(L = 500000, W = 100000) annotation (
    Placement(visible = true, transformation(origin={-90,-10},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.ElectroMech.Generators.SimpleGen simpleGen annotation (
    Placement(visible = true, transformation(origin={30,30},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner OpenHPL.Data data(SteadyState = true, Vdot_0 = 1.2) annotation (
    Placement(visible = true, transformation(origin={-90,90},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp(duration = 10, height = -0.00001, offset = 1, startTime = 2) annotation (
    Placement(visible = true, transformation(origin={-70,20},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Reservoir tail(h_0 = 1) annotation (
    Placement(visible = true, transformation(origin={90,-10},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  OpenHPL.ElectroMech.Turbines.Turbine turbine(H_n = 380, Pmax = 3.9e6, ValveCapacity = false, Vdot_n = 1.2) annotation (
    Placement(visible = true, transformation(origin={30,-10},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const2(k = 4000000) annotation (
    Placement(visible = true, transformation(origin={90,20},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe penstock(D_i = 0.7, H = 385.7, L = 2006.2) annotation (
    Placement(visible = true, transformation(origin={-40,-10},    extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch2 annotation (
    Placement(visible = true, transformation(origin={-20,40},    extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp2(duration = 27, height = -0.99999, offset = 1, startTime = 5) annotation (
    Placement(visible = true, transformation(origin={-70,60},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime = 5) annotation (
    Placement(visible = true, transformation(origin={0,90},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(const2.y, switch1.u3) annotation (
    Line(points={{79,20},{76,20},{76,42},{70,42}},color = {0, 0, 127}));
  connect(simpleGen.flange, turbine.flange) annotation (
    Line(points={{30,30},{30,-10}}));
  connect(reservoir.o, penstock.i) annotation (
    Line(points={{-80,-10},{-50,-10}},      color = {0, 128, 255}));
  connect(turbine.o, tail.o) annotation (
    Line(points={{40,-10},{80,-10}},      color = {0, 128, 255}));
  connect(penstock.o, turbine.i) annotation (
    Line(points={{-30,-10},{20,-10}},     color = {0, 128, 255}));
  connect(switch2.y, turbine.u_t) annotation (
    Line(points={{-10.1,40},{14,40},{14,8},{22,8},{22,2}},
                                               color = {0, 0, 127}));
  connect(ramp2.y, switch2.u1) annotation (
    Line(points={{-59,60},{-38.6,60},{-38.6,47.2},{-30.8,47.2}},color = {0, 0, 127}));
  connect(ramp.y, switch2.u3) annotation (
    Line(points={{-59,20},{-38.6,20},{-38.6,32.8},{-30.8,32.8}},color = {0, 0, 127}));
  connect(const.y, switch1.u1) annotation (
    Line(points={{79,70},{70,70},{70,58}},        color = {0, 0, 127}));
  connect(switch1.y, simpleGen.Pload) annotation (
    Line(points={{47,50},{30,50},{30,42}},        color = {0, 0, 127}));
  connect(booleanStep.y, switch1.u2) annotation (
    Line(points={{11,90},{75.75,90},{75.75,50},{70,50}},    color = {255, 0, 255}));
  connect(booleanStep.y, switch2.u2) annotation (
    Line(points={{11,90},{21,90},{21,61.5},{-41,61.5},{-41,40},{-30.8,40}},        color = {255, 0, 255}));
  annotation (
    experiment(StartTime = 0, StopTime = 150, Tolerance = 1e-06, Interval = 0.3));
end Model_III_PelRamp_Uel;
