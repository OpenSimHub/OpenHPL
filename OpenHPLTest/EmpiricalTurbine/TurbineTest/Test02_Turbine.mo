within OpenHPLTest.EmpiricalTurbine.TurbineTest;
model Test02_Turbine
extends Test01_Turbine(Hn=300, turbine(p=14));
annotation (
    Documentation(info="<html>
<p>Basic test of EpiricalTurbine model. Opening is kept constant.</p>
<p>Initial speed f_0 is set to 0.2 and the turbine is permitted to speed up as function of computed turbine torque Tt.</p>
</html>"),
    experiment(StartTime = 0, StopTime = 30, Tolerance = 1e-06, Interval = 0.001));

end Test02_Turbine;
