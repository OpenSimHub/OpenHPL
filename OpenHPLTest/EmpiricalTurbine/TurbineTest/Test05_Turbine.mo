within OpenHPLTest.EmpiricalTurbine.TurbineTest;
model Test05_Turbine
  extends Modelica.Icons.Example;
  extends Test01_Turbine(
    Hn=600,
    turbine(J=2e3),
    ramp(offset=opening, startTime=1e6));
end Test05_Turbine;
