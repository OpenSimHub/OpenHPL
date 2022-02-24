within OpenHPL.ElectroMech.PowerSystem;
model Grid "Model of a mechanical grid equivalent"
  extends OpenHPL.Icons.Pylon;


  parameter SI.Power Pgrid=1000000000        "Active power capacity of the grid" annotation (Dialog(group="Electrical"));
  parameter Boolean useLambda=false "If checked, specify Lambda, otherwise the droop Rgrid is used"
    annotation (choices(checkBox = true), Dialog(group="Electrical"));
  parameter Types.Lambda Lambda=Pgrid/(Rgrid*data.f_0) "Network Power-Frequency Characteristic (bias factor)"
    annotation (Dialog(group="Electrical",enable=useLambda));
  parameter SI.PerUnit Rgrid=0.1 "Equivalent droop setting of the grid"
    annotation (Dialog(group="Electrical",enable=not useLambda));
  parameter Real mu=0 "Self-regulation [%/Hz]" annotation (Dialog(group="Electrical"));

  extends BaseClasses.Power2Torque(
    final Pmax=Pgrid,
    final Ploss=0,                 final enable_nomSpeed=false,
                                   power(y=dP2.y));


  Modelica.Blocks.Interfaces.RealInput Pload(unit="W") "Electrical load power demand" annotation (Placement(
      visible=true,
      transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120}),
      iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Math.Add P(k1=-1, k2=-Lambda) annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(extent={{40,-70},{20,-50}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=data.f_0) annotation (Placement(transformation(extent={{0,-90},{20,-70}})));
  Modelica.Blocks.Math.Add dP1(k1=mu/100, k2=-1) annotation (Placement(transformation(extent={{-50,60},{-30,80}})));
  Modelica.Blocks.Sources.RealExpression lambda(y=Lambda)
                                               annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Math.Product product annotation (Placement(transformation(extent={{-24,62},{-14,72}})));
  Modelica.Blocks.Math.Add dP2(k2=-1) annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=0,
        origin={-20,30})));
equation
  connect(feedback.u1, toHz.y) annotation (Line(points={{38,-60},{88.6,-60},{88.6,-40}}, color={0,0,127}));
  connect(realExpression.y, feedback.u2) annotation (Line(points={{21,-80},{30,-80},{30,-68}}, color={0,0,127}));
  connect(feedback.y, P.u2) annotation (Line(points={{21,-60},{-90,-60},{-90,64},{-82,64}}, color={0,0,127}));
  connect(Pload, P.u1) annotation (Line(points={{0,120},{0,88},{-90,88},{-90,76},{-82,76}}, color={0,0,127}));
  connect(P.y, dP1.u1) annotation (Line(points={{-59,70},{-56,70},{-56,76},{-52,76}}, color={0,0,127}));
  connect(lambda.y, dP1.u2) annotation (Line(points={{-59,50},{-56,50},{-56,64},{-52,64}}, color={0,0,127}));
  connect(dP1.y, product.u1) annotation (Line(points={{-29,70},{-25,70}}, color={0,0,127}));
  connect(product.u2, P.u2) annotation (Line(points={{-25,64},{-28,64},{-28,44},{-90,44},{-90,64},{-82,64}}, color={0,0,127}));
  connect(Pload, dP2.u2) annotation (Line(points={{0,120},{0,26.4},{-12.8,26.4}}, color={0,0,127}));
  connect(product.y, dP2.u1) annotation (Line(points={{-13.5,67},{-8,67},{-8,33.6},{-12.8,33.6}}, color={0,0,127}));
  annotation (
    Documentation(info="<html>
<h4>Primary control</h4>
<h5>Network Power-Frequency Characteristic</h5>
<p align=\"center\">
<img src=\"modelica://OpenHPL/Resources/Images/equations/NetworkPowerFreqChar_lambda.svg\">
</p>
<h5>Self-regulation</h5>
<p>Inductive loads like motors cause the system load to be slightly frequency dependent.</>
<p align=\"center\">
<img src=\"modelica://OpenHPL/Resources/Images/equations/NetworkPowerFreqChar_mu.svg\">
</p>
<dl>
  <dt>&mu;</dt>
    <dd>The self regulation effect of the load P [%/Hz]</dd>
  <dt>&Delta;P'</dt>
    <dd>The change in the power consumption of the loads because of the change in frequency &Delta;f [MW].</dd>
  <dt>P</dt>
    <dd>The value of the original load of the system plus the change &Delta;P at the orginal system frequency [MW].</dd>
</dl>
</html>"), Icon(graphics={
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}), Ellipse(
          extent={{-20,20},{20,-20}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Text(
          lineColor={127,0,0},
          extent={{-100,-110},{100,-150}},
          textStyle={TextStyle.Bold},
          textString="%name")}));
end Grid;
