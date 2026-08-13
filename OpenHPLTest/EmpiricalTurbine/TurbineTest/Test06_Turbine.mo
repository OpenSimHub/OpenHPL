within OpenHPLTest.EmpiricalTurbine.TurbineTest;
model Test06_Turbine
  extends Test05_Turbine(data(SteadyState=true, Vdot_0=0), ramp(height=1, offset=0));

end Test06_Turbine;
