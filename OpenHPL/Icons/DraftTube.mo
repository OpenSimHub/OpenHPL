within OpenHPL.Icons;
partial class DraftTube "Draft tube icon"

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, grid={1,1}), graphics={
        Polygon(
          points={{-40,29},{-40,29}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          smooth=Smooth.Bezier,
          fillColor={175,175,175}),
                     Text(
          textColor={28,108,200},
          extent={{-150,140},{150,100}},
          textString="%name",
          textStyle={TextStyle.Bold}),
        Polygon(
          points={{-89,90},{-31,87},{-38,1},{90,21},{90,-82},{-80,-50},{-89,90}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          smooth=Smooth.Bezier),
        Rectangle(
          extent={{-85,90},{-34,49}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{-80,89},{-40,89},{-42,-6},{90,11},{88,-72},{-73,-43},{-80,89}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          smooth=Smooth.Bezier),
        Rectangle(
          extent={{-77,90},{-41,39}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{40,13},{90,-70}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{40,4},{90,-61}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-85,39}},
          color={0,0,0},
          pattern=LinePattern.None),
        Line(points={{-85,49},{-85,90},{-77,90},{-77,48}}, color={0,0,0}),
        Line(points={{-41,49},{-41,90},{-34,90},{-34,49}}, color={0,0,0}),
        Line(points={{46,6}}, color={0,0,0}),
        Line(points={{40,13},{90,13},{90,4},{40,4}}, color={0,0,0}),
        Line(points={{40,-61},{90,-61},{90,-70},{40,-70}}, color={0,0,0})}));
end DraftTube;
