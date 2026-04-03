within OpenHPLTest.EmpiricalTurbine.TurbineTest;

model TestXX_Turbine
  extends Modelica.Icons.Example;
  //
  Test02_Turbine test02_Turbine annotation(
    Placement(transformation(origin = {-58, 82}, extent = {{-10, -10}, {10, 10}})));
  Test03_Turbine test03_Turbine annotation(
    Placement(transformation(origin = {46, 80}, extent = {{-10, -10}, {10, 10}})));
  Test04_Turbine test04_Turbine annotation(
    Placement(transformation(origin = {-58, 24}, extent = {{-10, -10}, {10, 10}})));
  /**/
  Test05_Turbine test05_Turbine annotation(
    Placement(transformation(origin = {50, 24}, extent = {{-10, -10}, {10, 10}})));
  
equation

annotation(
    experiment(StartTime = 0, StopTime = 12, Tolerance = 1e-06, Interval = 0.005));
end TestXX_Turbine;
