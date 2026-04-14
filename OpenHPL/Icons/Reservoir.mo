within OpenHPL.Icons;
partial class Reservoir "Reservoir icon"
  input SI.Position h_abs_ds "Absolut height of watercolumn in the surge shaft (for DynamicSelect)";
  input Boolean show "Show additional level info";

  annotation (
    preferredView="icon",
    Icon(graphics={Rectangle(lineColor = {28, 108, 200}, extent = {{-100, 100}, {100, -100}}),
        Text(
          textColor={28,108,200},
          extent={{-150,90},{150,50}},
          textString="%name",
          textStyle={TextStyle.Bold}),
        Line(
          points={{-80,20}},
          color={28,108,200},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Line(
          points={{-80,10},{-60,30},{-20,-10},{20,30},{60,-10},{80,10}},
          color={28,108,200},
          smooth=Smooth.Bezier),
        Line(
          points={{-80,-20},{-60,0},{-20,-40},{20,0},{60,-40},{80,-20}},
          color={28,108,200},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Text(
          visible = show,
          textColor={28,108,200},
          origin = {0, -60},
          extent = {{-100, 20}, {100, -20}},
          textString = DynamicSelect("(level)", "("+String(h_abs_ds, ".1f") + ")"),
          textStyle = {TextStyle.Italic})}));
end Reservoir;