within OpenHPL.ElectroMech.Turbines;
model Turbine "Simple turbine model with mechanical connectors"
  extends BaseClasses.BaseValve;
  extends BaseClasses.Power2Torque(power(y=Wdot_s));
  extends Interfaces.TurbineContacts;
  extends Icons.Turbine;

   Modelica.Blocks.Math.Feedback lossCorrection annotation (Placement(transformation(extent={{-50,70},{-30,90}})));
equation

  connect(P_out, lossCorrection.y) annotation (Line(
      points={{40,110},{40,80},{-31,80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(lossCorrection.u1, power.y) annotation (Line(points={{-48,80},{-88,80},{-88,30},{-81,30}},color={0,0,127}));
  connect(frictionLoss.power, lossCorrection.u2) annotation (Line(points={{-1,12},{-40,12},{-40,72}},
                                                                                                  color={0,0,127}));
  connect(u_t, u) annotation (Line(points={{-80,120},{-80,90},{0,90},{0,70}},    color={0,0,127}));
  annotation (
    Documentation(info="<html><p>
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
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="P"), Text(
          extent={{-96,100},{-60,80}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="GVO")}));
end Turbine;
