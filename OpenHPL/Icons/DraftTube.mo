within OpenHPL.Icons;
partial class DraftTube "Draft tube icon"

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, grid={1,1}), graphics={
        Polygon(
          points={{-50,-80},{50,-80},{30,70},{-30,70},{-50,-80}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{-40,19},{-40,19}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          smooth=Smooth.Bezier,
          fillColor={175,175,175}),
        Ellipse(
          extent={{-50,-70},{50,-90}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175}),
        Ellipse(
          extent={{-30,80},{30,60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Forward,
          fillColor={175,175,175},
          pattern=LinePattern.Dash),
        Ellipse(
          extent={{-26,77},{26,63}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Forward,
          fillColor={0,128,255}),
        Ellipse(
          extent={{-44,-73},{45,-87}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={0,128,255})}));
end DraftTube;
