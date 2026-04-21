within OpenHPLTest.EmpiricalTurbine.TurbineTest;

model Test07_Turbine
extends Modelica.Icons.Example;
   inner OpenHPL.Data data annotation (
    Placement(transformation(origin = {-84, 82}, extent = {{-10, -10}, {10, 10}})));
    parameter Modelica.Units.SI.Height Hn=500;
    Modelica.Units.SI.Height Ht1 "Turbine1 pressure head";
    Modelica.Units.SI.Height Ht2 "Turbine2 pressure head";
    
  OpenHPL.Waterway.Reservoir overvann(h_0 = Hn, constantLevel = true) annotation (
    Placement(transformation(origin = {-80, 26}, extent = {{-10, -10}, {10, 10}})));
  OpenHPL.Waterway.Reservoir undervann(h_0 = 0, constantLevel = true) annotation (
    Placement(transformation(origin = {72, -16}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  OpenHPL.ElectroMech.Turbines.EmpiricalTurbine turbine( H_n = Hn, P_n = 1e7, p = 18,enable_nomSpeed = true, enable_f = true, f_0 = 1, fixed_iniSpeed = false ) annotation (
    Placement(transformation(origin = {12, 12}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp ramp(height = 1, duration = 10, offset = 0, startTime = 5)  annotation(
    Placement(transformation(origin = {-26, 76}, extent = {{-10, -10}, {10, 10}})));
 OpenHPL.Waterway.Pipe pipe(H = 0, L = 1000, D_i = 1.128379167, SteadyState = true)  annotation(
    Placement(transformation(origin = {-38, 18}, extent = {{-10, -10}, {10, 10}})));
 OpenHPL.Waterway.Reservoir ov2(constantLevel = true, h_0 = Hn) annotation(
    Placement(transformation(origin = {-80, -30}, extent = {{-10, -10}, {10, 10}})));
 OpenHPL.Waterway.Reservoir uv2(constantLevel = true, h_0 = 0) annotation(
    Placement(transformation(origin = {70, -74}, extent = {{10, -10}, {-10, 10}})));
 OpenHPL.Waterway.Pipe pipe2(D_i = 1.128379167, H = 0, L = 1000, SteadyState = true) annotation(
    Placement(transformation(origin = {-36, -30}, extent = {{-10, -10}, {10, 10}})));
 OpenHPL.ElectroMech.Turbines.Turbine turb2(ValveCapacity = false, H_n = Hn, Vdot_n = 2.15, f_0 = 1, enable_nomSpeed = true, enable_f = true)  annotation(
    Placement(transformation(origin = {4, -42}, extent = {{-10, -10}, {10, 10}})));
equation
  Ht1 = turbine.dp/(data.rho*data.g);
  Ht2 = turb2.dp/(data.rho*data.g);
  connect(turbine.o, undervann.o) annotation(
    Line(points = {{22, 12}, {28, 12}, {28, -16}, {62, -16}}, color = {0, 128, 255}));
  connect(ramp.y, turbine.u_t) annotation(
    Line(points = {{-14, 76}, {4, 76}, {4, 24}}, color = {0, 0, 127}));
  connect(overvann.o, pipe.i) annotation(
    Line(points = {{-70, 26}, {-60, 26}, {-60, 18}, {-48, 18}}, color = {0, 128, 255}));
  connect(pipe.o, turbine.i) annotation(
    Line(points = {{-28, 18}, {-20, 18}, {-20, 12}, {2, 12}}, color = {0, 128, 255}));
  connect(ov2.o, pipe2.i) annotation(
    Line(points = {{-70, -30}, {-46, -30}}, color = {0, 128, 255}));
 connect(turb2.o, uv2.o) annotation(
    Line(points = {{14, -42}, {26, -42}, {26, -74}, {60, -74}}, color = {0, 128, 255}));
 connect(pipe2.o, turb2.i) annotation(
    Line(points = {{-26, -30}, {-22, -30}, {-22, -42}, {-6, -42}}, color = {0, 128, 255}));
 connect(ramp.y, turb2.u_t) annotation(
    Line(points = {{-14, 76}, {-12, 76}, {-12, -14}, {-4, -14}, {-4, -30}}, color = {0, 0, 127}));
  annotation (
    Documentation(info = "<html><head></head><body>Basic test of EpiricalTurbine model. Opening is kept constant.<div>Initial speed f_0 is set to 0.2 and the turbine is permitted to speed up as function of computed turbine torque Tt.<br><div><br></div></div></body></html>"),
    experiment(StartTime = 0, StopTime = 30, Tolerance = 1e-06, Interval = 0.001));


end Test07_Turbine;
