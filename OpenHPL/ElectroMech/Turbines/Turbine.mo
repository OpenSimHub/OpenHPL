within OpenHPL.ElectroMech.Turbines;
model Turbine "Simple turbine model with mechanical connectors"
  extends BaseClasses.BaseValve;
  extends BaseClasses.Power2Torque(power(y=Wdot_s));
  extends Interfaces.TurbineContacts;
  extends Icons.Turbine;

  parameter Boolean ConstEfficiency = true
    "If checked the constant efficiency eta_h is used,
     otherwise specify lookup table for efficiency"
    annotation (Dialog(group = "Efficiency data"), choices(checkBox = true));
  parameter SI.Efficiency eta_h = 0.9 "Hydraulic efficiency"
    annotation (Dialog(group = "Efficiency data", enable = ConstEfficiency));
  parameter Real lookup_table[:, :] = [0, 0.4; 0.2, 0.7; 0.5, 0.9; 0.95, 0.95; 1.0, 0.93]
    "Look-up table for the turbine/valve efficiency, described by a table matrix, where the first column is a pu value of the guide vane opening, and the second column is a pu value of the turbine efficiency."
    annotation (Dialog(group = "Efficiency data", enable = not ConstEfficiency));
  Modelica.Blocks.Math.Feedback lossCorrection
  annotation (Placement(transformation(extent={{-50,70},{-30,90}})));
  Modelica.Blocks.Tables.CombiTable1Dv look_up_table(table = lookup_table, smoothness = Modelica.Blocks.Types.Smoothness.ContinuousDerivative, extrapolation = Modelica.Blocks.Types.Extrapolation.LastTwoPoints) annotation(Placement(transformation(origin = {-76, -74}, extent={{-10,-10},{10,10}})));
  output Modelica.Units.SI.EnergyFlowRate Wdot_s "Turbine power";

protected
  SI.EnergyFlowRate Kdot_i_tr "Gross hydraulic power";

equation
  look_up_table.u[1] = u "Link the valve opening";
  if ConstEfficiency then
    Wdot_s = eta_h * Kdot_i_tr;
  else
    Wdot_s = look_up_table.y[1] * Kdot_i_tr;
  end if;
  Kdot_i_tr = dp * Vdot "Energy balance";

  connect(P_out, lossCorrection.y) annotation (Line(
      points={{40,110},{40,80},{-31,80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(lossCorrection.u1, power.y) annotation (Line(points={{-48,80},{-88,80},{-88,30},{-81,30}},color={0,0,127}));
  connect(frictionLoss.power, lossCorrection.u2) annotation (Line(points={{-1,12},{-40,12},{-40,72}},color={0,0,127}));
  connect(u_t, u) annotation (Line(points={{-80,120},{-80,90},{0,90},{0,70}},color={0,0,127}));
  annotation (
    Documentation(info="<html>
<p>
This is a simple model of the turbine that give possibilities for simplified
modelling of the turbine unit. The model can use a constant efficiency or varying
efficiency from a lookup-table.
This model does not include any information about rotational speed of the runner.
</p>
<p>
This model is based on the energy balance and a simple valve-like expression.
The guide vane 'valve capacity' should be used for this valve-like expression and can either be specified
directly by the user by specifying <code>C_v</code> or it will be calculated from
the Nominal turbinenet head <code>H_n</code> and nominal flow rate
<code>Vdot_n</code>.
</p>
<p>
The turbine efficiency is in per-unit values from 0 to 1, where 1 means that there are no losses in the turbine.
The output mechanical power is defined as multiplication of the turbine efficiency and the total possible power:
</p>
<blockquote>
<pre>turbine_pressure_drop * turbine_flow_rate</pre>
</blockquote>
<p>Besides hydraulic input and output,
there are inputs as the control signal for the valve opening and also output as the turbine shaft power.
</p>

<p align=\"center\">
<img src=\"modelica://OpenHPL/Resources/Images/turbinepic.svg\">
</p><h5>References</h5><p>More info about the model can be found in:&nbsp;<a href=\"modelica://OpenHPL/Resources/Documents/Report.docx\">Resources/Report/Report.docx</a></p>
</html>"), Icon(graphics={Text(
          visible=enable_P_out,
          extent={{30,100},{50,80}},
          textColor={0,0,0},
          textString="P"), Text(
          extent={{-96,100},{-60,80}},
          textColor={0,0,0},
          textString="Opening")}));
end Turbine;
