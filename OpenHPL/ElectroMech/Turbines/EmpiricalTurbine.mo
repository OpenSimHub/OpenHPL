within OpenHPL.ElectroMech.Turbines;
model EmpiricalTurbine
 extends OpenHPL.ElectroMech.BaseClasses.TorqueEquation;
  extends OpenHPL.Interfaces.TurbineContacts;
  extends OpenHPL.Icons.Turbine;

  parameter OpenHPL.Types.TurbineCharacteristics turbineCharacteristics;
  parameter OpenHPL.Types.TurbineData turbineData;
  SI.Length Ht(start=10) "Turbine head";
  SI.VolumeFlowRate Qt "Turbine flow rate";

  SI.Torque Tt "Turbine torque";
  Modelica.Blocks.Sources.RealExpression realExpression(y=Tt) annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
protected
  Real opening=u_t;
  SI.Frequency nrps=speedSensor.w/(2*C.pi) "Rotational speed (in revolutions per seconds)";
equation
  Ht = abs(i.p - o.p)/(data.rho*data.g);
  i.mdot + o.mdot = 0;
  i.mdot = Qt*data.rho;
  (Qt, Tt) = OpenHPL.Functions.TurbineLookUp2(Ht, nrps, opening, turbineData, turbineCharacteristics);
  connect(realExpression.y, torque.tau) annotation (Line(points={{-49,0},{-37.2,0}}, color={0,0,127}));
annotation (
    Documentation(info = "<html>
<p>Turbine model based on normalized, empirical turbine characteristics and turbine data for the best efficiency point.</p>
<p>In this intial release, the turbine characteristics and tubine data must be constructed separately passed to the model. This may change in future releases.</p>
</html>"));
end EmpiricalTurbine;
