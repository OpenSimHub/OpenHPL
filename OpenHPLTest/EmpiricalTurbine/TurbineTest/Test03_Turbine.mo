within OpenHPLTest.EmpiricalTurbine.TurbineTest;
model Test03_Turbine
   extends AbstractTurbineTest;

public
  OpenHPL.Waterway.Pipe tunnel(H = 0, L = 2000, p_eps_input(displayUnit = "mm") = 1e-4, D_i = 4.6, SteadyState = true, Vdot_0 = 20.5) annotation (
    Placement(transformation(origin = {-44, 32}, extent = {{-10, -10}, {10, 10}})));

  OpenHPL.Waterway.Reservoir overvann(h_0 = 425.0, constantLevel = true) annotation (
    Placement(transformation(origin = {-80, 32}, extent = {{-10, -10}, {10, 10}})));
  OpenHPL.Waterway.Reservoir undervann(h_0 = 0.0, constantLevel = true) annotation (
    Placement(transformation(origin = {72, -16}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  OpenHPL.ElectroMech.Turbines.EmpiricalTurbine turbine(turbineData = turbineData, turbineCharacteristics = tc, enable_nomSpeed = false, enable_f = true, f_0 = 0.2) annotation (
    Placement(transformation(origin = {12, 12}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant const(k = 0.603) annotation (
    Placement(transformation(origin = {52, 72}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
equation
  connect(turbine.o, undervann.o) annotation (
    Line(points = {{22, 12}, {28, 12}, {28, -16}, {62, -16}}, color = {0, 128, 255}));
  connect(const.y, turbine.u_t) annotation (
    Line(points = {{41, 72}, {4, 72}, {4, 24}}, color = {0, 0, 127}));
  connect(overvann.o, tunnel.i) annotation (
    Line(points = {{-70, 32}, {-54, 32}}, color = {0, 128, 255}));
  connect(tunnel.o, turbine.i) annotation (
    Line(points = {{-34, 32}, {-24, 32}, {-24, 12}, {2, 12}}, color = {0, 128, 255}));
  annotation (
    experiment(StartTime = 0, StopTime = 50.0, Tolerance = 1e-06, Interval = 0.02000),
    Documentation(info = "<html><head></head><body>Generic test with penstock and emprical turbine model. The opening is kept fixed and the unit is allowed to speed up to runaway.</body></html>"));
      
      /*
      ,
    __OpenModelica_commandLineOptions="--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(
      lv="LOG_STDOUT,LOG_ASSERT,LOG_STATS",
      s="dassl",
      noHomotopyOnFirstTry="()",
      homMaxNewtonSteps="50",
      homMaxTries="30",
      variableFilter=".*"));
      */
end Test03_Turbine;
