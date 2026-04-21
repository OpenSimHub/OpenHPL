within OpenHPLTest.EmpiricalTurbine.TurbineTest;
model Test03_Turbine
   extends Test01_Turbine(Hn=600, turbin(p=8));
annotation (
    Documentation(info = "<html><head></head><body>Basic test of EpiricalTurbine model. Opening is kept constant.<div>Initial speed f_0 is set to 0.2 and the turbine is permitted to speed up as function of computed turbine torque Tt.<br><div><br></div></div></body></html>"),
    experiment(StartTime = 0, StopTime = 30, Tolerance = 1e-06, Interval = 0.001));
end Test03_Turbine;
