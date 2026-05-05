within OpenHPLTest.EmpiricalTurbine.TurbineTest;

model Test_Turbine_Charactersistics
  extends Modelica.Icons.Example;
  //
  parameter Modelica.Units.SI.Height Hn=600;
  Test05_Turbine t01(opening=0.1,Hn=Hn) annotation(
    Placement(transformation(origin = {-60, 82}, extent = {{-10, -10}, {10, 10}})));
  Test05_Turbine t02(opening=0.2,Hn=Hn) annotation(
    Placement(transformation(origin = {-2, 82}, extent = {{-10, -10}, {10, 10}})));
  Test05_Turbine t03(opening=0.3,Hn=Hn) annotation(
    Placement(transformation(origin = {46, 84}, extent = {{-10, -10}, {10, 10}})));
  Test05_Turbine t04(opening=0.4,Hn=Hn) annotation(
    Placement(transformation(origin = {-56, 50}, extent = {{-10, -10}, {10, 10}})));
  Test05_Turbine t05(opening=0.5,Hn=Hn) annotation(
    Placement(transformation(origin = {-2, 46}, extent = {{-10, -10}, {10, 10}})));
  Test05_Turbine t06(opening=0.6,Hn=Hn) annotation(
    Placement(transformation(origin = {50, 50}, extent = {{-10, -10}, {10, 10}})));
  Test05_Turbine t07(opening=0.7,Hn=Hn) annotation(
    Placement(transformation(origin = {-60, 10}, extent = {{-10, -10}, {10, 10}})));
  Test05_Turbine t08(opening=0.8,Hn=Hn) annotation(
    Placement(transformation(origin = {-8, 6}, extent = {{-10, -10}, {10, 10}})));
   Test05_Turbine t09(opening=0.9,Hn=Hn) annotation(
    Placement(transformation(origin = {48, 8}, extent = {{-10, -10}, {10, 10}})));
  Test05_Turbine t10(opening=1.0,Hn=Hn) annotation(
    Placement(transformation(origin = {-58, -28}, extent = {{-10, -10}, {10, 10}})));
  
equation

annotation(
    experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-06, Interval = 0.005),
  Icon(graphics = {Text(origin = {142, 45}, extent = {{-142, 91}, {142, -91}}, textString = "H=%Hn")}));
end Test_Turbine_Charactersistics;