within OpenHPL.Icons;
partial class BendPipe "Bend pipes icon."

  annotation (
    preferredView="icon",
    Icon(graphics={
        Ellipse(
          extent={{30,50},{80,-10}},
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175},
          lineColor={0,0,0}),
        Rectangle(
          extent={{-80,50},{56,0}},
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175},
          pattern=LinePattern.None),
        Rectangle(
          extent={{-50,25},{50,-25}},
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175},
          origin={55,-30},
          rotation=90,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-80,45},{55,5}},
          fillPattern=FillPattern.Solid,
          fillColor={0,128,255},
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{36,25},{74,-80}},
          fillPattern=FillPattern.Solid,
          fillColor={0,128,255},
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Ellipse(
          extent={{34,45},{74,5}},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
                     Text(
          textColor={28,108,200},
          extent={{-150,100},{150,60}},
          textString="%name",
          textStyle={TextStyle.Bold}),
        Polygon(
          points={{-80,50},{-80,50}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Line(points={{-79,50}}, color={0,0,0}),
        Line(points={{-80,45},{-80,50},{58,50}}, color={0,0,0}),
        Line(points={{-80,5},{-80,0},{30,0},{30,-80},{36,-80}}, color={0,0,0}),
        Line(points={{74,-80},{80,-80},{80,20}}, color={0,0,0})}));
end BendPipe;
