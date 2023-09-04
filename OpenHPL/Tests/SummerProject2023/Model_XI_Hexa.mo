within OpenHPL.Tests.SummerProject2023;
model Model_XI_Hexa "Six pipes five stiff and one elastic"
  OpenHPL.Waterway.Reservoir reservoir(L = 500000, W = 100000) annotation (
    Placement(visible = true, transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner OpenHPL.Data data(SteadyState = true, Vdot_0 = 1.167) annotation (
    Placement(visible = true, transformation(origin = {-90, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp(duration = 10, height = -0.000001, offset = 1, startTime = 2) annotation (
    Placement(visible = true, transformation(origin = {-36, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 0) annotation (
    Placement(visible = true, transformation(origin = {124, 96}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Reservoir tail(L = 500000, W = 100000) annotation (
    Placement(visible = true, transformation(origin = {130, 10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  OpenHPL.Waterway.PenstockKP KP(D_i = 0.7, H = 0.7, L = 336.2) annotation (
    Placement(visible = true, transformation(origin = {74, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.ElectroMech.Turbines.Turbine turbine7(H_n = 382, Pmax = 3.9e6, ValveCapacity = false, Vdot_n = 1.2) annotation (
    Placement(visible = true, transformation(origin = {102, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const2(k = 4000000) annotation (
    Placement(visible = true, transformation(origin = {124, 58}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch2 annotation (
    Placement(visible = true, transformation(origin = {13, 49}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  OpenHPL.ElectroMech.Generators.SimpleGen simpleGen annotation (
    Placement(visible = true, transformation(origin = {46, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime = 5) annotation (
    Placement(visible = true, transformation(origin = {18, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch1 annotation (
    Placement(visible = true, transformation(origin = {80, 76}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp2(duration = 27, height = -0.99999, offset = 1, startTime = 5) annotation (
    Placement(visible = true, transformation(origin = {-34, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe P1(D_i = 0.7, H = 61, L = 333.8, Vdot(start = 1.2)) annotation (
    Placement(visible = true, transformation(origin = {-62, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe P2(D_i = 0.7, H = 56, L = 332.6) annotation (
    Placement(visible = true, transformation(origin = {-36, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe P3(D_i = 0.7, H = 65, L = 331.2) annotation (
    Placement(visible = true, transformation(origin = {-10, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe P4(D_i = 0.7, H = 28, L = 336.2) annotation (
    Placement(visible = true, transformation(origin = {16, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe P5(D_i = 0.7, H = 174.3, L = 336.2) annotation (
    Placement(visible = true, transformation(origin = {46, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(const.y, switch1.u1) annotation (
    Line(points = {{113, 96}, {98.5, 96}, {98.5, 84}, {92, 84}}, color = {0, 0, 127}));
  connect(const2.y, switch1.u3) annotation (
    Line(points = {{113, 58}, {113, 68}, {92, 68}}, color = {0, 0, 127}));
  connect(simpleGen.flange, turbine7.flange) annotation (
    Line(points = {{46, 64}, {46, 37}, {102, 37}, {102, 10}}));
  connect(turbine7.o, tail.o) annotation (
    Line(points = {{112, 10}, {120, 10}}, color = {0, 128, 255}));
  connect(booleanStep.y, switch2.u2) annotation (
    Line(points={{29,110},{43,110},{43,84},{-5,84},{-5,49},{2.2,49}},            color = {255, 0, 255}));
  connect(ramp.y, switch2.u3) annotation (
    Line(points={{-25,42},{-12,42},{-12,41.8},{2.2,41.8}},
                                        color = {0, 0, 127}));
  connect(switch1.y, simpleGen.Pload) annotation (
    Line(points = {{69, 76}, {46, 76}}, color = {0, 0, 127}));
  connect(booleanStep.y, switch1.u2) annotation (
    Line(points = {{29, 110}, {92, 110}, {92, 76}}, color = {255, 0, 255}));
  connect(ramp2.y, switch2.u1) annotation (
    Line(points={{-23,78},{-14,78},{-14,56.2},{2.2,56.2}},    color = {0, 0, 127}));
  connect(KP.o, turbine7.i) annotation (
    Line(points = {{84, 10}, {92, 10}}, color = {0, 128, 255}));
  connect(switch2.y, turbine7.u_t) annotation (
    Line(points={{22.9,49},{32,49},{32,34},{94,34},{94,22}},          color = {0, 0, 127}));
  connect(reservoir.o, P1.i) annotation (
    Line(points = {{-80, 10}, {-72, 10}}, color = {0, 128, 255}));
  connect(P1.o, P2.i) annotation (
    Line(points = {{-52, 10}, {-46, 10}}, color = {0, 128, 255}));
  connect(P2.o, P3.i) annotation (
    Line(points = {{-26, 10}, {-20, 10}}, color = {0, 128, 255}));
  connect(P3.o, P4.i) annotation (
    Line(points = {{0, 10}, {6, 10}}, color = {0, 128, 255}));
  connect(P5.o, KP.i) annotation (
    Line(points = {{56, 10}, {64, 10}}, color = {0, 128, 255}));
  connect(P4.o, P5.i) annotation (
    Line(points = {{26, 10}, {36, 10}}, color = {0, 128, 255}));
  annotation (
    Diagram(coordinateSystem(extent = {{-100, 120}, {140, 0}})),
    experiment(StartTime = 0, StopTime = 150, Tolerance = 1e-06, Interval = 0.15));
end Model_XI_Hexa;
