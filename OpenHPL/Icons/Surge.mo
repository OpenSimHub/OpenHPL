within OpenHPL.Icons;

partial class Surge "Surge tank/shaft icon"
  input SI.Length h_ds "Height of watercolumn in the surge shaft (for DynamicSelect)";
  input SI.Length H_ds "Height of the surge shaft (for DynamicSelect)";
  input SI.Position h_abs_ds "Absolut height of watercolumn in the surge shaft (for DynamicSelect)";
  input Boolean show "Show additional level info";

  annotation(
    preferredView = "icon",
    Icon(
      coordinateSystem(preserveAspectRatio = false, grid = {1, 1}),
      graphics = {
        Text(
          origin = {0, 10},
          textColor = {28, 108, 200},
          extent = {{-150, -60}, {150, -100}},
          textString = "%name",
          textStyle = {TextStyle.Bold}
        ),
        Rectangle(
          origin = {0, 10},
          fillColor = {175, 175, 175},
          fillPattern = FillPattern.Solid,
          extent = {{-90, 30}, {90, -50}}
        ),
        Rectangle(
          origin = {0, 10},
          lineColor = {28, 108, 200},
          fillColor = {0, 128, 255},
          fillPattern = FillPattern.Solid,
          extent = {{-90, 20}, {90, -40}}
        ),
        Rectangle(
          origin = {0, 10},
          fillColor = {175, 175, 175},
          pattern = LinePattern.None,
          fillPattern = FillPattern.Solid,
          extent = {{-40, 90}, {40, 30}}
        ),
        Rectangle(
          origin = {0, 10},
          fillColor = {255, 255, 255},
          pattern = LinePattern.None,
          fillPattern = FillPattern.Solid,
          extent = {{-30, 90}, {30, 20}}
        ),
        Rectangle(
          lineColor = {28, 108, 200},
          fillColor = {0, 128, 255},
          pattern = LinePattern.None,
          fillPattern = FillPattern.Solid,
          extent = DynamicSelect({{-30, 60}, {30, 30}}, {{-30, 30 + 70*h_ds/H_ds}, {30, 30}})
        ),
        Rectangle(
          origin = {0, 10},
          pattern = LinePattern.None,
          extent = {{-30, 90}, {30, 80}}
        ),
        Line(
          origin = {0, 10},
          points = {{-40, 30}, {-40, 90}, {-30, 90}, {-30, 20}, {-90, 20}}
        ),
        Line(
          origin = {0, 10},
          points = {{-90, -41}}
        ),
        Line(
          origin = {0, 10},
          points = {{-90, -40}, {90, -40}}
        ),
        Line(
          origin = {0, 10},
          points = {{40, 30}, {40, 90}, {30, 90}, {30, 20}, {90, 20}}
        ),
        Text(
          visible = show,
          textColor = {255, 255, 255},
          extent = {{-30, 50}, {30, 30}},
          textString = DynamicSelect("(level)", "(" + String(h_abs_ds, ".1f") + ")")
        )
      }
    )
  );
end Surge;