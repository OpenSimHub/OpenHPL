within OpenHPLTest.EmpiricalTurbine.TurbineTest;

model Test01_Turbine
  extends Modelica.Icons.Example;
   inner OpenHPL.Data data annotation (
    Placement(transformation(origin = {-84, 82}, extent = {{-10, -10}, {10, 10}})));
    parameter Modelica.Units.SI.Height Hn=100;
    
  OpenHPL.Waterway.Reservoir overvann(h_0 = Hn, constantLevel = true) annotation (
    Placement(transformation(origin = {-46, 28}, extent = {{-10, -10}, {10, 10}})));
  OpenHPL.Waterway.Reservoir undervann(h_0 = 0, constantLevel = true) annotation (
    Placement(transformation(origin = {72, -16}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  OpenHPL.ElectroMech.Turbines.EmpiricalTurbine turbine( H_n = Hn, P_n = 1e7, p = 18,enable_nomSpeed = false, enable_f = true, f_0 = 0 ) annotation (
    Placement(transformation(origin = {12, 12}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp ramp(height = 1, duration = 10, offset = 0, startTime = 0)  annotation(
    Placement(transformation(origin = {-26, 76}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(overvann.o, turbine.i) annotation(
    Line(points = {{-36, 28}, {-20, 28}, {-20, 12}, {2, 12}}, color = {0, 128, 255}));
  connect(turbine.o, undervann.o) annotation(
    Line(points = {{22, 12}, {28, 12}, {28, -16}, {62, -16}}, color = {0, 128, 255}));
  connect(ramp.y, turbine.u_t) annotation(
    Line(points = {{-14, 76}, {4, 76}, {4, 24}}, color = {0, 0, 127}));
  annotation (
    Documentation(info = "<html><head></head><body>Basic test of EpiricalTurbine model. Opening is kept constant.<div>Initial speed f_0 is set to 0.2 and the turbine is permitted to speed up as function of computed turbine torque Tt.<br><div><br></div></div></body></html>"),
    experiment(StartTime = 0, StopTime = 30, Tolerance = 1e-06, Interval = 0.001));

end Test01_Turbine;
