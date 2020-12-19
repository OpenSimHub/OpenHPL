within OpenHPL.ElectroMech.Generators;
model SimpleGen "Model of a simple generator with mechanical connectors"
  extends BaseClasses.ConvertToRotational(power(y=-P_load));
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
<p>This model has inputs as electric power available on the grid and the turbine shaft power.
This model based on the angular momentum balance, which depends on the turbine shaft power,
 the friction loss in the aggregate rotation and the power taken up by the generator.</p>
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
