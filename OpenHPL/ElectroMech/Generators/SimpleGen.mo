within OpenHPL.ElectroMech.Generators;
model SimpleGen "Model of a simple generator with mechanical connectors"
  extends BaseClasses.Power2Torque(power(y=-P_load));
  extends OpenHPL.Icons.Generator;

  Modelica.Blocks.Interfaces.RealInput P_load(unit="W") "Electrical load power demand" annotation (Placement(
      visible=true,
      transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120}),
      iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));

  annotation (
    Documentation(info="<html><p>Simple model of an ideal generator with friction.</p>
<p>This model based on the angular momentum balance, which depends on the turbine shaft power,
 the friction loss in the aggregate rotation and the power taken up by the generator.</p>
<p>
The generator can be loaded either:</p>
<ul>
<li>via the mechanical shaft connector (e.g., another <code>SimpleGen</code> as representation 
of an electric grid. The input <code>P_load</code> should be set to 0 in this case.</li>
<li>or via the input connector <code>P_load</code> specifying the connected electrical load.
</ul>
<p align=\"center\">
<img src=\"modelica://OpenHPL/Resources/Images/simplegen.svg\">
</p>
</html>"), Icon(graphics={
        Text(
          extent={{-20,100},{20,86}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="P_load")}));
end SimpleGen;
