within OpenHPL.Icons;
partial class DraftTube "Draft tube icon"
  parameter Boolean vertical=false "Display vertical icon instead"
    annotation(Dialog(group = "Icon"),
    choices(checkBox = true));
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
          extent={{-50,-74},{51,-87}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175}),
        Ellipse(
          extent={{-31,78},{30,63}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175}),
        Ellipse(
          extent={{-25,75},{25,66}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={28,108,200}),
        Ellipse(
          extent={{-35,-76},{37,-85}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={28,108,200})}));
end DraftTube;
