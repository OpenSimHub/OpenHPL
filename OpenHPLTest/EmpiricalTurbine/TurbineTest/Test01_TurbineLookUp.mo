within OpenHPLTest.EmpiricalTurbine.TurbineTest;
model Test01_TurbineLookUp
  extends AbstractTurbineTest;
public
  Real opening;
  SI.Length Ht "Turbine head";
  SI.VolumeFlowRate Qt "Turbine flow rate";
  SI.Frequency nrps "Rotational speed";
  SI.Torque Tt "Turbine torque";
equation
  Ht = 425.0;
  nrps = 1.0e-03 + 8.33*time*1.4;
  opening = 0.6;
  (Qt, Tt) = OpenHPL.Functions.TurbineLookUp(Ht, nrps, opening, turbineData, tc);
  annotation (
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.001),
    Documentation(info = "<html><head></head><body>Basic test of &nbsp;the turbine lookup function. The head is kept constant, the speed is a linear function of time, and the flow and torque is computed from the model.<div>Running the model the turbine flow Qt or turbine torque Tt can be ploted as function of time.</div></body></html>"));
end Test01_TurbineLookUp;
