within OpenHPL.Icons;
partial class Generator "Generator icon"
  annotation (
    Icon(graphics={
        Text(
          textColor={127,0,0},
          extent={{-100,-110},{100,-150}},
          textStyle={TextStyle.Bold},
          textString="%name"),
        Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          pattern=LinePattern.None),
        Text(
          extent={{-40,70},{40,10}},
          textColor={0,0,0},
          textString="G"),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
        Line(
          points={{-40,-40},{-20,-20},{20,-60},{40,-40}},
          color={238,46,47},
          smooth=Smooth.Bezier),
        Polygon(
          points={{6,-20},{-14,-44},{1.375,-44},{-14,-62},{14,-38},{0,-38},{20,-20},{6,-20}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid)}));
end Generator;
