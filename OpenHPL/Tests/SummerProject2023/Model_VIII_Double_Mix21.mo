within OpenHPL.Tests.SummerProject2023;
model Model_VIII_Double_Mix21 "Two pipes elastic and stiff"
  OpenHPL.Waterway.Pipe pipe1(D_i = 0.7, H = 203.7, L = 1008.6) annotation (
    Placement(visible = true, transformation(origin = {-10, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Reservoir tail(L = 500000, W = 100000) annotation (
    Placement(visible = true, transformation(origin = {90, 10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  inner OpenHPL.Data data(SteadyState = true, Vdot_0 = 1.2) annotation (
    Placement(visible = true, transformation(origin = {-90, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const2(k = 4000000) annotation (
    Placement(visible = true, transformation(origin = {124, 58}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp2(duration = 27, height = -0.99999, offset = 1, startTime = 5) annotation (
    Placement(visible = true, transformation(origin = {-34, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime = 5) annotation (
    Placement(visible = true, transformation(origin = {18, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.PenstockKP penKP2(D_i = 0.7, H = 182, L = 997.6) annotation (
    Placement(visible = true, transformation(origin = {-50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch2 annotation (
    Placement(visible = true, transformation(origin = {13, 49}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  OpenHPL.Waterway.Reservoir reservoir(L = 500000, W = 100000) annotation (
    Placement(visible = true, transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp(duration = 10, height = -0.000001, offset = 1, startTime = 2) annotation (
    Placement(visible = true, transformation(origin = {-36, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.ElectroMech.Turbines.Turbine turbine7(H_n = 382, Pmax = 3.9e6, ValveCapacity = false, Vdot_n = 1.2) annotation (
    Placement(visible = true, transformation(origin = {36, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.ElectroMech.Generators.SimpleGen simpleGen annotation (
    Placement(visible = true, transformation(origin = {46, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 0) annotation (
    Placement(visible = true, transformation(origin = {124, 96}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch1 annotation (
    Placement(visible = true, transformation(origin = {80, 76}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(const.y, switch1.u1) annotation (
    Line(points = {{113, 96}, {98.5, 96}, {98.5, 84}, {92, 84}}, color = {0, 0, 127}));
  connect(simpleGen.flange, turbine7.flange) annotation (
    Line(points = {{46, 64}, {46, 27}, {36, 27}, {36, 10}}));
  connect(switch2.y, turbine7.u_t) annotation (
    Line(points={{22.9,49},{22.9,52},{28,52},{28,22}},      color = {0, 0, 127}));
  connect(ramp.y, switch2.u3) annotation (
    Line(points={{-25,42},{-12,42},{-12,41.8},{2.2,41.8}},
                                        color = {0, 0, 127}));
  connect(switch1.y, simpleGen.Pload) annotation (
    Line(points = {{69, 76}, {46, 76}}, color = {0, 0, 127}));
  connect(ramp2.y, switch2.u1) annotation (
    Line(points={{-23,78},{-14,78},{-14,56.2},{2.2,56.2}},    color = {0, 0, 127}));
  connect(turbine7.o, tail.o) annotation (
    Line(points = {{46, 10}, {80, 10}}, color = {0, 128, 255}));
  connect(booleanStep.y, switch1.u2) annotation (
    Line(points = {{29, 110}, {92, 110}, {92, 76}}, color = {255, 0, 255}));
  connect(booleanStep.y, switch2.u2) annotation (
    Line(points={{29,110},{43,110},{43,84},{-5,84},{-5,49},{2.2,49}},            color = {255, 0, 255}));
  connect(const2.y, switch1.u3) annotation (
    Line(points = {{113, 58}, {113, 68}, {92, 68}}, color = {0, 0, 127}));
  connect(penKP2.o, pipe1.i) annotation (
    Line(points = {{-40, 10}, {-20, 10}}, color = {0, 128, 255}));
  connect(pipe1.o, turbine7.i) annotation (
    Line(points = {{0, 10}, {26, 10}}, color = {0, 128, 255}));
  connect(reservoir.o, penKP2.i) annotation (
    Line(points = {{-80, 10}, {-60, 10}}, color = {0, 128, 255}));
  annotation (
    Diagram(coordinateSystem(extent = {{-100, 120}, {140, 0}})),
    experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.2));
end Model_VIII_Double_Mix21;
