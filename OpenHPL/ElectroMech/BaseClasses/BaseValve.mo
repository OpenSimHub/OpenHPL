within OpenHPL.ElectroMech.BaseClasses;
partial model BaseValve "Simple hydraulic valve (base class)"
   extends OpenHPL.Interfaces.TwoContacts;
  outer OpenHPL.Data data "Using standard class with global parameters";

  parameter Boolean ValveCapacity = true
    "If checked, the valve capacity C_v should be specified,
    otherwise specify the nominal values (net head and flow rate at nominal opening)"
    annotation (Dialog(group = "Nominal values"), choices(checkBox = true));
  parameter Real C_v = 1 "Valve capacity"
    annotation (Dialog(group = "Nominal values", enable = ValveCapacity));
  parameter SI.Height H_n = 100 "Nominal net head"
    annotation (Dialog(group = "Nominal values", enable = not ValveCapacity));
  parameter SI.VolumeFlowRate Vdot_n = 3 "Nominal volume flow rate"
    annotation (Dialog(group = "Nominal values", enable = not ValveCapacity));
  parameter SI.PerUnit u_n = 1 "Nominal opening"
    annotation (Dialog(group = "Nominal values", enable = not ValveCapacity));
  parameter Real alpha=1 "Exponent of closing curve (if different from 1, the closing law will be non-linear)" annotation(Dialog(tab="Advanced", group = "Closing law"));

  SI.Pressure dp "Pressure drop";
  SI.MassFlowRate mdot "Mass flow rate";
  SI.VolumeFlowRate Vdot "Volume flow rate";

protected
  parameter Real C_v_ = if ValveCapacity then C_v else Vdot_n/sqrt(H_n*data.g*data.rho)/u_n
    "Define 'valve capacity' based on the nominal values";
  Modelica.Blocks.Interfaces.RealInput u(min = 0, max = 1) "=1: completely open, =0: completely closed"
    annotation (Placement(transformation(origin = {0, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 270), iconTransformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {0, 80})));
  constant Real epsilon = 5.0e-5 "Constant to ensure robust expression for dp vs flow. Trial and error to find suitable value.";

equation
  i.mdot + o.mdot = 0;
  mdot = i.mdot;
  Vdot = mdot/data.rho;
  dp*(C_v_*max(epsilon, u^alpha))^2 = Vdot*abs(Vdot) "Valve equation for pressure drop";
  dp = i.p - o.p "Link the pressure drop to the ports";
  annotation (preferredView="info", Documentation(info="<html>
<p>
This is a partial, simple model of hydraulic valve. &nbsp;</p><p>This model is based on the energy balance of a valve.
</p>
<ul>
<li>Mass flow is equal at inflow and outflow</li>
<li>The head loss and pressure difference is proportional to square of velocity</li>
</ul>
<p>
Specifically:
</p>
<p>$$ \\Delta p \\cdot f(\\mathrm{opening}) = \\nu \\cdot | \\nu | $$</p>
<p>
The function f(opening) is expressed as:
</p>
<p>$$ f(\\mathrm{opening}) = \\left( C_\\mathrm{v} \\cdot \\mathrm{max}(\\epsilon, u^\\alpha)\\right)^2 $$</p>
<p>
When \\(\\alpha\\) is 1, this implies a linear relation between closing and head loss.
</p>
<p>The valve capacity can either be specified
directly by the user by specifying <code>C_v</code> or it will be calculated from
the nominal head <code>H_n</code> and nominal flow rate <code>Vdot_n</code>.
</p>
<p>
The valve efficiency is in per-unit values from 0 to 1, where 1 means that there are no losses in the valve.
The valve power is defined as the product of the valve power and valve efficiency.
</p>
<p>
Besides hydraulic input and output,
there is an input <code>u</code> for controlling the valve opening.
</p>
</html>"));
end BaseValve;
