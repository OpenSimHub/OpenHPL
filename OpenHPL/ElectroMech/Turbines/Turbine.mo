within OpenHPL.ElectroMech.Turbines;
model Turbine "Simple turbine model with mechanical connectors"
  extends BaseClasses.BaseValve;
  extends BaseClasses.Power2Torque(f_0=data.f_0, power(y=Wdot_s));
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
  Modelica.Blocks.Tables.CombiTable1Dv efficiencyCurve(
    table=lookup_table,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints)
    "Efficiency curve of the turbine"
    annotation (Placement(transformation(origin={-70,-70}, extent={{-10,-10},{10,10}})));
  output Modelica.Units.SI.EnergyFlowRate Wdot_s "Turbine power";

protected
  SI.EnergyFlowRate Kdot_i_tr "Gross hydraulic power";

equation
  efficiencyCurve.u[1] = u "Link the opening";
  if ConstEfficiency then
    Wdot_s = eta_h * Kdot_i_tr;
  else
    Wdot_s =efficiencyCurve.y[1]*Kdot_i_tr;
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
<h4>Simple Turbine Model</h4>

<p>This is a simple model of the turbine that gives possibilities for simplified
modelling of the turbine unit. The model is based on a look-up table for turbine efficiency
vs. guide vane opening.</p>

<p align=\"center\">
<img src=\"modelica://OpenHPL/Resources/Images/turbinepic.svg\">
</p>
<p><em>Figure: Simple turbine model schematic.</em></p>

<h5>Power Calculation</h5>

<p>The mechanical turbine shaft power is:</p>
<p>$$ \\dot{W}_\\mathrm{tr} = \\eta_\\mathrm{h} \\Delta p_\\mathrm{tr} \\dot{V}_\\mathrm{tr} $$</p>
<p>where η<sub>h</sub> is hydraulic efficiency (from lookup table or constant value),
Δp<sub>tr</sub> is pressure drop, and V̇<sub>tr</sub> is volumetric flow rate.</p>

<p>The turbine efficiency is in per-unit values from 0 to 1, where 1 means that there are
no losses. The model can use a constant efficiency or varying efficiency from a lookup-table.</p>

<h5>Flow Relationship</h5>

<p>This model is based on the energy balance and a simple valve-like expression.
The turbine flow rate relates to pressure drop through:</p>
<p>$$ \\dot{V}_\\mathrm{tr} = C_\\mathrm{v} u_\\mathrm{v} \\sqrt{\\frac{\\Delta p_\\mathrm{tr}}{p^\\mathrm{atm}}} $$</p>
<p>where C<sub>v</sub> is the guide vane \"valve capacity\", u<sub>v</sub> is guide vane opening
signal (0 to 1), and p<sup>atm</sup> is atmospheric pressure.</p>

<p>The guide vane valve capacity can either be specified directly by the user via <code>C_v</code>
or it will be calculated from the nominal turbine net head <code>H_n</code> and nominal flow rate
<code>Vdot_n</code>.</p>

<h5>Usage</h5>

<p>Besides hydraulic input and output, there are inputs as the control signal for the valve
opening and also output as the turbine shaft power.</p>

<h5>More Information</h5>
<p>More info about the model can be found in: <a href=\"modelica://OpenHPL/Resources/Documents/Report.docx\">Resources/Report/Report.docx</a>
and <a href=\"modelica://OpenHPL.UsersGuide.References\">[Vytvytskyi2019]</a>.</p>
</html>"), Icon(graphics={Text(
          visible=enable_P_out,
          extent={{30,100},{50,80}},
          textColor={0,0,0},
          textString="P"), Text(
          extent={{-96,100},{-60,80}},
          textColor={0,0,0},
          textString="Opening")}));
end Turbine;
