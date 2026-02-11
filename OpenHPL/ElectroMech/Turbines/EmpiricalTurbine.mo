within OpenHPL.ElectroMech.Turbines;

model EmpiricalTurbine
 extends OpenHPL.ElectroMech.BaseClasses.TorqueEquation(torque.y=Tt,speedSensor.w=2*nrps*C.pi);
  extends OpenHPL.Interfaces.TurbineContacts(u_t=opening);
  extends OpenHPL.Icons.Turbine;
  //
  parameter Boolean SteadyState = false "If true, starts in steady state" annotation(
    Dialog(group = "Initialization"));
  parameter OpenHPL.Types.HillChart hillChart;
  parameter OpenHPL.Types.TurbineData turbineData;
  SI.Length Ht "Turbine head";
  SI.VolumeFlowRate Qt "Turbine flow rate";
  
  SI.Torque Tt "Turbine torque";
protected
  Real opening;
  SI.Frequency nrps "Rotational speed (in rotations per seconds)";
equation
  Ht = (i.p - o.p)/(data.rho*data.g);
  i.mdot + o.mdot = 0;
  i.mdot = Qt*data.rho;
  (Qt, Tt) = OpenHPL.Functions.TurbineLookUp(Ht, nrps, opening, turbineData, hillChart);  
annotation(
    Documentation(info = "<html><head></head><body>Turbine model based on normalized, empirical turbine characteristics and turbine data for the best efficiency point.</body></html>"));
end EmpiricalTurbine;
