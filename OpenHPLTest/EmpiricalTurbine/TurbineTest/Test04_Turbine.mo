within OpenHPLTest.EmpiricalTurbine.TurbineTest;
model Test04_Turbine
   extends AbstractTurbineTest;
public
  OpenHPL.Waterway.Reservoir overvann(h_0 = 425.0, constantLevel = true) annotation (
    Placement(transformation(origin = {-46, 28}, extent = {{-10, -10}, {10, 10}})));
  OpenHPL.Waterway.Reservoir undervann(h_0 = 0.0, constantLevel = true) annotation (
    Placement(transformation(origin = {72, -16}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  OpenHPL.ElectroMech.Turbines.EmpiricalTurbine turbine(turbineData = turbineData, turbineCharacteristics = tc,                      enable_nomSpeed = false, f_0 = 0.2, enable_f = true) annotation (
    Placement(transformation(origin = {12, 12}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp ramp(height = -1, duration = 10, offset = 1, startTime = 2) annotation (
    Placement(transformation(origin = {52, 72}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  parameter OpenHPL.Types.TurbineData turbineData(Dn = 1.59, nrps = 8.33, Hbep = 425.0, Qbep = 23.95, Tbep = 1.718E+06, openingBep = 0.601, g = data.g, rho = data.rho) annotation (
    Placement(transformation(origin = {-80, 44}, extent = {{-12, 24}, {6, 6}})));
equation
  connect(overvann.o, turbine.i) annotation (
    Line(points = {{-36, 28}, {-20, 28}, {-20, 12}, {2, 12}}, color = {0, 128, 255}));
  connect(turbine.o, undervann.o) annotation (
    Line(points = {{22, 12}, {28, 12}, {28, -16}, {62, -16}}, color = {0, 128, 255}));
  connect(ramp.y, turbine.u_t) annotation (
    Line(points = {{41, 72}, {4, 72}, {4, 24}}, color = {0, 0, 127}));
annotation (
    experiment(StartTime = 0, StopTime = 15, Tolerance = 1e-06, Interval = 0.01));
end Test04_Turbine;
