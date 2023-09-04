within OpenHPL.Tests.SummerProject2023;
model Model_V_Sixpence_El "Six elastic pipes"
  Modelica.Blocks.Sources.Constant const(k = 0) annotation (
    Placement(visible = true, transformation(origin = {124, 96}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  OpenHPL.Waterway.PenstockKP penKP1(D_i = 0.7, H = 61, L = 333.8) annotation (
    Placement(visible = true, transformation(origin = {-86, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.PenstockKP penKP2(D_i = 0.7, H = 56, L = 332.6) annotation (
    Placement(visible = true, transformation(origin = {-60, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp2(duration = 27, height = -0.99999, offset = 1, startTime = 20) annotation (
    Placement(visible = true, transformation(origin = {-34, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.ElectroMech.Generators.SimpleGen simpleGen annotation (
    Placement(visible = true, transformation(origin = {46, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch2 annotation (
    Placement(visible = true, transformation(origin = {13, 49}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  OpenHPL.Waterway.Reservoir reservoir(L = 500000, W = 100000) annotation (
    Placement(visible = true, transformation(origin = {-110, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp(duration = 10, height = -0.000001, offset = 1, startTime = 2) annotation (
    Placement(visible = true, transformation(origin = {-36, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const2(k = 4000000) annotation (
    Placement(visible = true, transformation(origin = {124, 28}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  OpenHPL.ElectroMech.Turbines.Turbine turbine7(ConstEfficiency = false, H_n = 382, Pmax = 3.9e6, ValveCapacity = false, Vdot_n = 1.2) annotation (
    Placement(visible = true, transformation(origin = {74, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch1 annotation (
    Placement(visible = true, transformation(origin = {80, 76}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  inner OpenHPL.Data data(SteadyState = false, Vdot_0 = 1.2) annotation (
    Placement(visible = true, transformation(origin = {-110, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Reservoir tail(L = 500000, W = 100000, h_0 = 1) annotation (
    Placement(visible = true, transformation(origin = {104, -10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime = 5) annotation (
    Placement(visible = true, transformation(origin = {18, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.PenstockKP penKP3(D_i = 0.7, H = 65, L = 331.2) annotation (
    Placement(visible = true, transformation(origin = {-34, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.PenstockKP penKP4(D_i = 0.7, H = 28, L = 336.2) annotation (
    Placement(visible = true, transformation(origin = {-8, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.PenstockKP penKP5(D_i = 0.7, H = 174.3, L = 336.2) annotation (
    Placement(visible = true, transformation(origin = {18, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.PenstockKP penKP6(D_i = 0.7, H = 0.7, L = 336.2) annotation (
    Placement(visible = true, transformation(origin = {46, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(const2.y, switch1.u3) annotation (
    Line(points = {{113, 28}, {101, 28}, {101, 68}, {92, 68}}, color = {0, 0, 127}));
  connect(switch1.y, simpleGen.Pload) annotation (
    Line(points = {{69, 76}, {46, 76}}, color = {0, 0, 127}));
  connect(booleanStep.y, switch2.u2) annotation (
    Line(points={{29,110},{43,110},{43,84},{-5,84},{-5,49},{2.2,49}},            color = {255, 0, 255}));
  connect(turbine7.o, tail.o) annotation (
    Line(points = {{84, -10}, {94, -10}}, color = {0, 128, 255}));
  connect(booleanStep.y, switch1.u2) annotation (
    Line(points = {{29, 110}, {92, 110}, {92, 76}}, color = {255, 0, 255}));
  connect(reservoir.o, penKP1.i) annotation (
    Line(points = {{-100, -10}, {-96, -10}}, color = {0, 128, 255}));
  connect(ramp.y, switch2.u3) annotation (
    Line(points={{-25,42},{-12,42},{-12,41.8},{2.2,41.8}},
                                        color = {0, 0, 127}));
  connect(ramp2.y, switch2.u1) annotation (
    Line(points={{-23,78},{-14,78},{-14,56.2},{2.2,56.2}},    color = {0, 0, 127}));
  connect(const.y, switch1.u1) annotation (
    Line(points = {{113, 96}, {98.5, 96}, {98.5, 84}, {92, 84}}, color = {0, 0, 127}));
  connect(penKP1.o, penKP2.i) annotation (
    Line(points = {{-76, -10}, {-70, -10}}, color = {0, 128, 255}));
  connect(simpleGen.flange, turbine7.flange) annotation (
    Line(points = {{46, 64}, {46, 27}, {74, 27}, {74, -10}}));
  connect(switch2.y, turbine7.u_t) annotation (
    Line(points={{22.9,49},{30,49},{30,16},{66,16},{66,2}},          color = {0, 0, 127}));
  connect(penKP2.o, penKP3.i) annotation (
    Line(points = {{-50, -10}, {-44, -10}}, color = {0, 128, 255}));
  connect(penKP3.o, penKP4.i) annotation (
    Line(points = {{-24, -10}, {-18, -10}}, color = {0, 128, 255}));
  connect(penKP4.o, penKP5.i) annotation (
    Line(points = {{2, -10}, {8, -10}}, color = {0, 128, 255}));
  connect(penKP5.o, penKP6.i) annotation (
    Line(points = {{28, -10}, {36, -10}}, color = {0, 128, 255}));
  connect(penKP6.o, turbine7.i) annotation (
    Line(points = {{56, -10}, {64, -10}}, color = {0, 128, 255}));
  annotation (
    Diagram(coordinateSystem(extent = {{-120, 120}, {140, -20}})),
    experiment(StartTime = 0, StopTime = 150, Tolerance = 1e-06, Interval = 0.3));
end Model_V_Sixpence_El;
