within OpenHPLTest.EmpiricalTurbine.TurbineTest;
model Test05_Turbine
  extends AbstractTurbineTest;
  //
public
  OpenHPL.Waterway.Reservoir overvann(h_0 = 425.0, constantLevel = true) annotation (
    Placement(transformation(origin = {-82, 12}, extent = {{-10, -10}, {10, 10}})));
  OpenHPL.Waterway.Reservoir undervann(h_0 = 0.0, constantLevel = true) annotation (
    Placement(transformation(origin = {72, -16}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  OpenHPL.ElectroMech.Turbines.EmpiricalTurbine turbine(turbineData = turbineData, turbineCharacteristics = tc,                      enable_nomSpeed = true) annotation (
    Placement(transformation(origin = {12, 12}, extent = {{-10, -10}, {10, 10}})));
   OpenHPL.Waterway.Pipe tunnel(H = 0, L = 2000, p_eps_input(displayUnit = "mm") = 1e-4, D_i = 4.6, SteadyState = true, Vdot_0 = 20.5) annotation (
      Placement(transformation(origin = {-42, 12}, extent = {{-10, -10}, {10, 10}})));

  Modelica.Blocks.Sources.Ramp ramp(height = 1, duration = 10, offset = 0, startTime = 0.1) annotation (
    Placement(transformation(origin = {52, 72}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
equation
  connect(turbine.o, undervann.o) annotation (
    Line(points = {{22, 12}, {28, 12}, {28, -16}, {62, -16}}, color = {0, 128, 255}));
  connect(ramp.y, turbine.u_t) annotation (
    Line(points = {{41, 72}, {4, 72}, {4, 24}}, color = {0, 0, 127}));
connect(overvann.o, tunnel.i) annotation (
    Line(points = {{-72, 12}, {-52, 12}}, color = {0, 128, 255}));
connect(tunnel.o, turbine.i) annotation (
    Line(points = {{-32, 12}, {2, 12}}, color = {0, 128, 255}));
end Test05_Turbine;
