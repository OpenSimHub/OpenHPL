within OpenHPL.Tests.SummerProject2023;
model Model_VII_Double_Mix12 "Two pipes stiff and elastic"
  Modelica.Blocks.Sources.Ramp ramp2(duration = 27, height = -0.9999, offset = 1, startTime = 5) annotation (
    Placement(visible = true, transformation(origin={-30,80},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner OpenHPL.Data data(SteadyState = false, Vdot_0 = 1.167) annotation (
    Placement(visible = true, transformation(origin={-90,110},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const2(k = 4000000) annotation (
    Placement(visible = true, transformation(origin={120,60},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch1 annotation (
    Placement(visible = true, transformation(origin={80,80},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe pipe1(D_i = 0.7, H = 182, L = 997.6, Vdot(fixed = true)) annotation (
    Placement(visible = true, transformation(origin={-50,10},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp(duration = 10, height = -0.000001, offset = 1, startTime = 2) annotation (
    Placement(visible = true, transformation(origin={-30,40},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 0) annotation (
    Placement(visible = true, transformation(origin={120,100},   extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  OpenHPL.ElectroMech.Turbines.Turbine turbine(ConstEfficiency = false, H_n = 382, Pmax = 3.9e6, ValveCapacity = false, Vdot_n = 1.2, enable_P_out = true) annotation (
    Placement(visible = true, transformation(origin={40,10},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime = 5) annotation (
    Placement(visible = true, transformation(origin={20,110},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Reservoir tail(L = 500000, W = 100000, h_0 = 1) annotation (
    Placement(visible = true, transformation(origin={90,10},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  OpenHPL.ElectroMech.Generators.SimpleGen simpleGen annotation (
    Placement(visible = true, transformation(origin={50,60},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch2 annotation (
    Placement(visible = true, transformation(origin={10,50},    extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  OpenHPL.Waterway.Reservoir reservoir(L = 500000, W = 100000, h_0 = 1) annotation (
    Placement(visible = true, transformation(origin={-90,10},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.PenstockKP penstockKP(D_i = 0.7, H = 203.7, L = 1008.6)  annotation (
    Placement(visible = true, transformation(origin={-10,10},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(switch2.y, turbine.u_t) annotation (
    Line(points={{19.9,50},{19.9,55},{32,55},{32,22}},      color = {0, 0, 127}));
  connect(ramp.y, switch2.u3) annotation (
    Line(points={{-19,40},{-12.6,40},{-12.6,42.8},{-0.8,42.8}},
                                        color = {0, 0, 127}));
  connect(ramp2.y, switch2.u1) annotation (
    Line(points={{-19,80},{-14.6,80},{-14.6,57.2},{-0.8,57.2}},
                                                              color = {0, 0, 127}));
  connect(turbine.o, tail.o) annotation (
    Line(points={{50,10},{80,10}},      color = {0, 128, 255}));
  connect(simpleGen.flange, turbine.flange) annotation (
    Line(points={{50,60},{50,30},{40,30},{40,10}}));
  connect(booleanStep.y, switch2.u2) annotation (
    Line(points={{31,110},{44,110},{44,84.5},{-4,84.5},{-4,50},{-0.8,50}},       color = {255, 0, 255}));
  connect(switch1.y, simpleGen.Pload) annotation (
    Line(points={{69,80},{60,80},{60,72},{50,72}},
                                        color = {0, 0, 127}));
  connect(const2.y, switch1.u3) annotation (
    Line(points={{109,60},{109,72},{92,72}},        color = {0, 0, 127}));
  connect(const.y, switch1.u1) annotation (
    Line(points={{109,100},{96,100},{96,88},{92,88}},            color = {0, 0, 127}));
  connect(reservoir.o, pipe1.i) annotation (
    Line(points={{-80,10},{-60,10}},      color = {0, 128, 255}));
  connect(booleanStep.y, switch1.u2) annotation (
    Line(points={{31,110},{92,110},{92,80}},        color = {255, 0, 255}));
  connect(pipe1.o, penstockKP.i) annotation (
    Line(points={{-40,10},{-20,10}},      color = {0, 128, 255}));
  connect(penstockKP.o, turbine.i) annotation (
    Line(points={{0,10},{30,10}},      color = {0, 128, 255}));
  annotation (
    Diagram(coordinateSystem(extent = {{-100, 120}, {140, 0}})),
    experiment(StartTime = 0, StopTime = 150, Tolerance = 1e-06, Interval = 0.3));
end Model_VII_Double_Mix12;
