within OpenHPL.Icons;
partial class Surge "Surge tank/shaft icon"
  input SI.Length lds "Lenght of watercolumn in the surge shaft(for DynamicSelect)";
  input SI.Length Lds "Length of the surge shaft (for DynamicSelect)";
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, grid={1,1}),
                                                        graphics={
                     Text(
          lineColor={28,108,200},
          extent={{-150,140},{150,100}},
          textString="%name",
          textStyle={TextStyle.Bold}),
        Rectangle(
          extent={{-90,30},{90,-50}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175}),
        Rectangle(
          extent={{-90,20},{90,-40}},
          lineColor={28,108,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,90},{40,30}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175},
          pattern=LinePattern.None),
        Rectangle(
          extent={{-30,90},{30,20}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Rectangle(
          extent=DynamicSelect({{-30,60},{30,18}},
                {{-30,(20+70*lds/Lds)},{30,18}}),
          lineColor={28,108,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-30,90},{30,80}},
          lineColor={0,0,0},
          pattern=LinePattern.None),
        Line(points={{-40,30},{-40,90},{-30,90},{-30,20},{-90,20}}, color={0,0,0}),
        Line(points={{-90,-41}}, color={0,0,0}),
        Line(points={{-90,-40},{90,-40}}, color={0,0,0}),
        Line(points={{40,30},{40,90},{30,90},{30,20},{90,20}}, color={0,0,0})}));
end Surge;
