within OpenHPL.ElectroMech.Turbines;
model EmpiricalTurbine
  parameter SI.Height H_n = 100 "Nominal net head" annotation (Dialog(group = "Nominal values"));
  parameter SI.Power P_n (displayUnit = "MW")= 1.e+06 "Nominal power"  annotation (Dialog(group = "Nominal values"));
  extends OpenHPL.ElectroMech.BaseClasses.TorqueEquation;
  extends OpenHPL.Interfaces.TurbineContacts;
  extends OpenHPL.Icons.Turbine;

  SI.VolumeFlowRate Vdot "Turbine flow rate";
  SI.Pressure dp "Pressure drop"; 
  SI.Torque Tt "Turbine torque";
  Modelica.Blocks.Sources.RealExpression realExpression(y=Tt) annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));

  protected
  constant Real eps=1.0e-08;
  parameter SI.Density rho=data.rho;
  parameter SI.Acceleration g=data.g;
  constant Real eta0=0.90 "Full load efficiency. Hard coded at the moment. Can be parametrized in the future";
  parameter SI.VolumeFlowRate Vdot_n=P_n/(eta0*rho*g*H_n) "Nominal discharge";
  parameter SI.Torque Tt_n=P_n/(2*C.pi*nrps_n) "Noninal turbine torque";
  
  parameter Real NQE=4.0*H_n^(-2./3.) "Specific speed based on empirical relartion";
  parameter Real kappa=1.351-0.857*NQE;
  parameter Real nRA=1.5+NQE*5 "Normalized runaway speed us function of specific speed";
  parameter Real dQdn=0.4222+0.3179*Modelica.Math.log(NQE);
  parameter SI.Frequency nrps_n=2*data.f_grid/p "Nominal turbine speed [rps]";
  SI.Frequency nrps=speedSensor.w/(2*C.pi) "Rotational speed (in revolutions per seconds)";
  parameter Real Ct =Vdot_n/sqrt(H_n*g*rho) "Nominal turbine coefficient";
  constant Real alpha=1.5;
  constant Real beta=3.5;
  constant Real epsilon = 5.0e-5 "Constant to ensure robust expression for dp vs flow. Trial and error to find suitable value.";
equation
  i.mdot + o.mdot = 0;
  i.mdot = Vdot*rho;
  dp = i.p - o.p;
  
  Vdot*abs(Vdot)= dp*(Ct*max(epsilon, abs(u_t)^alpha)*(1+dQdn*(max(nrps/(nrps_n*nRA),epsilon)^beta)))^2;
  Tt=Tt_n*(dp/(H_n*(rho*g)))*(Vdot/Vdot_n)*(1-(nrps/(nrps_n*nRA*1.2))^5);
  connect(realExpression.y, torque.tau) annotation (Line(points={{-49,0},{-37.2,0}}, color={0,0,127}));
annotation (
    Documentation(info = "<html><head></head><body><p>Simplified empirical turbine model for single-regulated reaction turbine (Francis and propeller turbine). The turbine is specified by giving the nominal head H_n and nominale power P_n. All remaining values are determined from empirical relations. The throtling effect of high head Francis turbines is included in the model. However, the exact characteristics should be treated with caution and will need more empirical tuning in future releases.

</p><p align=\"center\">
<img src=\"modelica://OpenHPL/Resources/Images/EmpiricalTurbine.svg\">
</p>
<p><em>Figure: Example of throtling effect for a high head Francis unit. Discharge as function of speed (pu).</em></p>
   
<p></p></body></html>"));
end EmpiricalTurbine;
