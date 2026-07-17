within OpenHPLTest.EmpiricalTurbine.TurbineTest;
model Test07_Turbine
  extends Test06_Turbine(data(SteadyState=true, Vdot_0=0), ramp(height=1, offset=0));

end Test07_Turbine;
