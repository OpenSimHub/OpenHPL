within OpenHPL.ElectroMech.BaseClasses;
partial model BaseValve "Simple hydraulic valve (base class)"
  outer Data data "Using standard class with global parameters";
  extends OpenHPL.Interfaces.TwoContacts;

  parameter Boolean ValveCapacity = true "If checked the valve capacity C_v should be specified,
    otherwise specify the nominal values (net head and flow rate)"
    annotation (Dialog(group = "Nominal values"), choices(checkBox = true));
  parameter Real C_v = 1 "Valve capacity"
    annotation (Dialog(group = "Nominal values", enable = ValveCapacity));
  parameter SI.Height H_n = 100 "Nominal net head"
    annotation (Dialog(group = "Nominal values", enable = not ValveCapacity));
  parameter SI.VolumeFlowRate Vdot_n = 3 "Nominal flow rate"
    annotation (Dialog(group = "Nominal values", enable = not ValveCapacity));
  parameter SI.PerUnit u_n = 0.95 "Nominal opening"
    annotation (Dialog(group = "Nominal values", enable = not ValveCapacity));
  parameter Boolean ConstEfficiency = true "If checked the constant efficiency eta_h is used,
    otherwise specify lookup table for efficiency"
    annotation (Dialog(group = "Efficiency data"), choices(checkBox = true));
  parameter SI.Efficiency eta_h = 0.9 "Hydraulic efficiency"
    annotation (Dialog(group = "Efficiency data", enable = ConstEfficiency));
  parameter Real lookup_table[:, :] = [0, 0.4; 0.2, 0.7; 0.5, 0.9; 0.95, 0.95; 1.0, 0.93]
    "Look-up table for the turbine/valve efficiency, described by a table matrix,
     where the first column is a pu value of the guide vane opening,
     and the second column is a pu value of the turbine efficiency."
    annotation (Dialog(group = "Efficiency data", enable = not ConstEfficiency));
  parameter Boolean WaterCompress = false "If checked, the water is compressible"
    annotation (Dialog(tab = "Advanced"), choices(checkBox = true));

  SI.Pressure dp "Pressure drop";
  SI.EnergyFlowRate Kdot_i_tr "Kinetic energy flow";
  SI.MassFlowRate mdot "Mass flow rate";
  SI.VolumeFlowRate Vdot "Flow rate";
  Real C_v_ "Valve capacity";

  output SI.EnergyFlowRate Wdot_s "Valve power";
  Modelica.Blocks.Tables.CombiTable1Dv look_up_table(table=lookup_table);
protected
  Modelica.Blocks.Interfaces.RealInput u(min=0, max=1)
    "=1: completely open, =0: completely closed"
  annotation (Placement(transformation(
        origin={0,70},
        extent={{-10,-10},{10,10}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,80})));
equation
  i.mdot+o.mdot=0;
  mdot = i.mdot;
  Vdot = if WaterCompress then mdot / (data.rho * (1 + data.beta * (i.p - data.p_a))) else mdot / data.rho
    "Checking for water compressibility";
  look_up_table.u[1] = u "Link the valve opening";
  C_v_ = if ValveCapacity then C_v else Vdot_n/sqrt(H_n*data.g*data.rho/data.p_a)/u_n
    "Define 'valve capacity' base on the nominal values";
  dp = Vdot ^ 2 * data.p_a / (C_v_ * max(1e-6, u)) ^ 2 "Valve equation for pressure drop";
  dp = i.p - o.p "Link the pressure drop to the ports";
  Kdot_i_tr = dp * Vdot "Energy balance";
  if ConstEfficiency then
    Wdot_s = eta_h * Kdot_i_tr;
  else
    Wdot_s = look_up_table.y[1] * Kdot_i_tr;
  end if;

annotation (
    Documentation(info="<html><p>
This is a simple model of hydraulic valve.
The model can use a constant efficiency or varying
efficiency from a lookup-table.
</p>
<p>
This model is based on the energy balance of a valve.
The valve capacity can either be specified
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
