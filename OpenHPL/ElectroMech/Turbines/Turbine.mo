within OpenHPL.ElectroMech.Turbines;
model Turbine "Simple turbine model with mechanical connectors"
  outer Data data "Using standard class with global parameters";
  extends Icons.Turbine;

  parameter Boolean ValveCapacity =  true "If checked the guide vane capacity C_v should be specified, 
    otherwise specify the nominal turbine parameters (net head and flow rate)"
    annotation (Dialog(group = "Nominal turbine parameters"), choices(checkBox = true));
  parameter Real C_v = 3.7 "Guide vane 'valve capacity'"
    annotation (Dialog(group = "Nominal turbine parameters", enable = ValveCapacity));
  parameter SI.Height H_n = 460 "Nominal net head"
    annotation (Dialog(group = "Nominal turbine parameters", enable = not ValveCapacity));
  parameter SI.VolumeFlowRate Vdot_n = 23.4 "Nominal flow rate"
    annotation (Dialog(group = "Nominal turbine parameters", enable = not ValveCapacity));
  parameter SI.PerUnit u_n = 0.95 "Nominal guide vane opening"
    annotation (Dialog(group = "Nominal turbine parameters", enable = not ValveCapacity));
  parameter Boolean ConstEfficiency = true "If checked the constant efficiency eta_h is used,
    otherwise specify lookup table for efficiency"
    annotation (Dialog(group = "Efficiency data"), choices(checkBox = true));
  parameter SI.Efficiency eta_h = 0.9 "Turbine hydraulic efficiency"
    annotation (Dialog(group = "Efficiency data", enable = ConstEfficiency));
  parameter Real lookup_table[:, :] = [0, 0.4; 0.2, 0.7; 0.5, 0.9; 0.95, 0.95; 1.0, 0.93]
    "Look-up table for the turbine efficiency, described by a table matrix, 
     where the first column is a pu value of the guide vane opening,
     and the second column is a pu value of the turbine efficiency."
    annotation (Dialog(group = "Efficiency data", enable = not ConstEfficiency));
  parameter Boolean WaterCompress = false "If checked the water is compressible in the penstock"
    annotation (Dialog(tab = "Advanced"),  choices(checkBox = true));

  extends BaseClasses.Power2Torque(power(y=Wdot_s));
  extends OpenHPL.Interfaces.TurbineContacts2;

  SI.Pressure dp "Turbine pressure drop";
  SI.EnergyFlowRate Kdot_i_tr "Kinetic energy flow";
  SI.VolumeFlowRate Vdot "Flow rate";
  Real C_v_ "Guide vane 'valve capacity'";

  output SI.EnergyFlowRate Wdot_s "Shaft power";
  Modelica.Blocks.Tables.CombiTable1D look_up_table(table = lookup_table);
  Modelica.Blocks.Math.Feedback lossCorrection annotation (Placement(transformation(extent={{-10,70},{10,90}})));
equation
  Vdot = if WaterCompress then mdot / (data.rho * (1 + data.beta * (i.p - data.p_a))) else mdot / data.rho
    "Checking for water compressibility";
  look_up_table.u[1] = u_t "Link the guide vane opening";
  C_v_ = if ValveCapacity then C_v else Vdot_n/sqrt(H_n*data.g*data.rho/data.p_a)/u_n
    "Define guide vane 'valve capacity' base on the Nominal turbine parameters";
  dp = Vdot ^ 2 * data.p_a / (C_v_ * u_t) ^ 2 "turbine valve equation for pressure drop";
  dp = i.p - o.p "Link the pressure drop to the ports";
  Kdot_i_tr = dp * Vdot "Turbine energy balance";
  if ConstEfficiency then
    Wdot_s = eta_h * Kdot_i_tr;
  else
    Wdot_s = look_up_table.y[1] * Kdot_i_tr;
  end if;

  /* // for temperature variation, not finished...
  i.T = o.T; */

  connect(P_out, lossCorrection.y) annotation (Line(
      points={{40,110},{40,80},{9,80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(lossCorrection.u1, power.y) annotation (Line(points={{-8,80},{-90,80},{-90,30},{-81,30}}, color={0,0,127}));
  connect(frictionLoss.power, lossCorrection.u2) annotation (Line(points={{29,12},{0,12},{0,72}}, color={0,0,127}));
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
</p><h5>References</h5><p>More info about the model can be found in:&nbsp;<a href=\"Resources/Report/Report.docx\">Resources/Report/Report.docx</a></p>
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
