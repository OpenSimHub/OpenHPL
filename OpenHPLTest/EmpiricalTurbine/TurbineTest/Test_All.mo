within OpenHPLTest.EmpiricalTurbine.TurbineTest;

model Test_All
extends Modelica.Icons.Example;
//
Test_Turbine_Charactersistics T1(Hn=25) annotation(
    Placement(transformation(origin = {-60, 90}, extent = {{-10, -10}, {10, 10}})));
Test_Turbine_Charactersistics T2(Hn=50) annotation(
    Placement(transformation(origin = {-60, 70}, extent = {{-10, -10}, {10, 10}})));
Test_Turbine_Charactersistics T3(Hn=75) annotation(
    Placement(transformation(origin = {-60, 50}, extent = {{-10, -10}, {10, 10}})));
Test_Turbine_Charactersistics T4(Hn=100) annotation(
    Placement(transformation(origin = {-60, 30}, extent = {{-10, -10}, {10, 10}})));
Test_Turbine_Charactersistics T5(Hn=200) annotation(
    Placement(transformation(origin = {-60, 10}, extent = {{-10, -10}, {10, 10}})));
Test_Turbine_Charactersistics T6(Hn=300) annotation(
    Placement(transformation(origin = {-60, -10}, extent = {{-10, -10}, {10, 10}})));
Test_Turbine_Charactersistics T7(Hn=400) annotation(
    Placement(transformation(origin = {-60, -10}, extent = {{-10, -10}, {10, 10}})));
Test_Turbine_Charactersistics T8(Hn=500) annotation(
    Placement(transformation(origin = {-60, -10}, extent = {{-10, -10}, {10, 10}})));
Test_Turbine_Charactersistics T9(Hn=600) annotation(
    Placement(transformation(origin = {-60, -10}, extent = {{-10, -10}, {10, 10}})));
equation
//
annotation(
    experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-06, Interval = 0.005));
end Test_All;
