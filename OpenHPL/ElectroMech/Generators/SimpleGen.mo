within OpenHPL.ElectroMech.Generators;
model SimpleGen "Model of a simple generator with mechanical connectors"
  extends BaseClasses.Power2Torque(final enable_nomSpeed=false, power(y=-Pload));
  extends OpenHPL.Icons.Generator;

  Modelica.Blocks.Interfaces.RealInput Pload(unit="W") "Electrical load power demand" annotation (Placement(
      transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120}),
      iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));

  annotation (
    Documentation(info="<html>
<h4>Simple model of an ideal generator with friction.</h4>

<p>This model based on the angular momentum balance, which depends on the turbine shaft power,
 the friction loss in the aggregate rotation and the power taken up by the generator.</p>
<p>
The generator can be loaded either:</p>
<ul>
<li>via the mechanical shaft connector (e.g., using the
<a href=\"OpenHPL.ElectroMech.PowerSystem.Grid\">Grid</a> model).
 The input <code>Pload</code> should be set to 0 in this case.</li>
<li>or via the input connector <code>Pload</code> specifying the connected electrical load.</li>
</ul>
<p align=\"center\">
<img src=\"modelica://OpenHPL/Resources/Images/simplegen.svg\">
</p>
</html>"), Icon(graphics={
        Text(
          extent={{-20,100},{20,86}},
          textColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="P_load")}));
end SimpleGen;
