within OpenHPL.Tests.SummerProject2023;
model Model_IV_Pelgen_elastico "System with elastic pipe and variable load"
  OpenHPL.Waterway.Reservoir reservoir(L = 500000, W = 100000) annotation (
    Placement(visible = true, transformation(origin = {-90, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner OpenHPL.Data data(SteadyState = true, Vdot_0 = 1.2) annotation (
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.ElectroMech.Generators.SimpleGen simpleGen annotation (
    Placement(visible = true, transformation(origin = {30, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp2(duration = 27, height = -0.99999, offset = 1, startTime = 5) annotation (
    Placement(visible = true, transformation(origin = {-70, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 0) annotation (
    Placement(visible = true, transformation(origin = {90, 70}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch2 annotation (
    Placement(visible = true, transformation(origin = {-17, 39}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  OpenHPL.Waterway.Reservoir tail(h_0 = 1) annotation (
    Placement(visible = true, transformation(origin = {90, -10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp(duration = 10, height = -0.00001, offset = 1, startTime = 2) annotation (
    Placement(visible = true, transformation(origin = {-70, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime = 5) annotation (
    Placement(visible = true, transformation(origin = {-2, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch1 annotation (
    Placement(visible = true, transformation(origin = {57, 49}, extent = {{9, -9}, {-9, 9}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const2(k = 4000000) annotation (
    Placement(visible = true, transformation(origin = {90, 22}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  OpenHPL.ElectroMech.Turbines.Turbine turbine(H_n = 382, Pmax = 3.9e6, ValveCapacity = false, Vdot_n = 1.2) annotation (
    Placement(visible = true, transformation(origin={30,-10},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.PenstockKP penstockKP(D_i = 0.7, H = 385.7, L = 2006.2) annotation (
    Placement(visible = true, transformation(origin = {-42, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(const.y, switch1.u1) annotation (
    Line(points={{79,70},{67.8,70},{67.8,56.2}},  color = {0, 0, 127}));
  connect(switch2.y, turbine.u_t) annotation (
    Line(points={{-7.1,39},{14,39},{14,8},{22,8},{22,2}},
                                               color = {0, 0, 127}));
  connect(turbine.o, tail.o) annotation (
    Line(points={{40,-10},{80,-10}},      color = {0, 128, 255}));
  connect(ramp.y, switch2.u3) annotation (
    Line(points={{-59,24},{-42,24},{-42,31.8},{-27.8,31.8}},    color = {0, 0, 127}));
  connect(simpleGen.flange, turbine.flange) annotation (
    Line(points={{30,28},{30,-10}}));
  connect(switch1.y, simpleGen.Pload) annotation (
    Line(points={{47.1,49},{30,49},{30,40}},      color = {0, 0, 127}));
  connect(booleanStep.y, switch1.u2) annotation (
    Line(points={{9,90},{76,90},{76,49},{67.8,49}},         color = {255, 0, 255}));
  connect(ramp2.y, switch2.u1) annotation (
    Line(points={{-59,56},{-42,56},{-42,46.2},{-27.8,46.2}},    color = {0, 0, 127}));
  connect(booleanStep.y, switch2.u2) annotation (
    Line(points={{9,90},{24,90},{24,66},{-38,66},{-38,39},{-27.8,39}},             color = {255, 0, 255}));
  connect(const2.y, switch1.u3) annotation (
    Line(points={{79,22},{67.8,22},{67.8,41.8}},  color = {0, 0, 127}));
  connect(reservoir.o, penstockKP.i) annotation (
    Line(points = {{-80, -10}, {-52, -10}}, color = {0, 128, 255}));
  connect(penstockKP.o, turbine.i) annotation (
    Line(points={{-32,-10},{20,-10}},     color = {0, 128, 255}));
  annotation (
    experiment(StartTime = 0, StopTime = 150, Tolerance = 1e-06, Interval = 0.3));
end Model_IV_Pelgen_elastico;
