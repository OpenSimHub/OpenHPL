within OpenHPLTest.EmpiricalTurbine.TurbineTest;
model Test02_Turbine
extends AbstractTurbineTest;
  OpenHPL.Waterway.Reservoir overvann(h_0 = 425.0, constantLevel = true) annotation (
    Placement(transformation(origin = {-46, 28}, extent = {{-10, -10}, {10, 10}})));
  OpenHPL.Waterway.Reservoir undervann(h_0 = 0.0, constantLevel = true) annotation (
    Placement(transformation(origin = {72, -16}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  OpenHPL.ElectroMech.Turbines.EmpiricalTurbine turbine(turbineData = turbineData, turbineCharacteristics = tc, SteadyState = false, enable_nomSpeed = false, f_0 = 0.2, enable_f = true) annotation (
    Placement(transformation(origin = {12, 12}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant const(k = 0.603) annotation (
    Placement(transformation(origin = {52, 72}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
equation
  connect(overvann.o, turbine.i) annotation (
    Line(points = {{-36, 28}, {-20, 28}, {-20, 12}, {2, 12}}, color = {0, 128, 255}));
  connect(turbine.o, undervann.o) annotation (
    Line(points = {{22, 12}, {28, 12}, {28, -16}, {62, -16}}, color = {0, 128, 255}));
  connect(const.y, turbine.u_t) annotation (
    Line(points = {{41, 72}, {4, 72}, {4, 24}}, color = {0, 0, 127}));
  annotation (
    Documentation(info = "<html><head></head><body>Basic test of EpiricalTurbine model. Opening is kept constant.<div>Initial speed f_0 is set to 0.2 and the turbine is permitted to speed up as function of computed turbine torque Tt.<br><div><br></div></div></body></html>"),
    experiment(StartTime = 0, StopTime = 20, Tolerance = 1e-06, Interval = 0.001));
end Test02_Turbine;
