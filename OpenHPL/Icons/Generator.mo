within OpenHPL.Icons;
partial class Generator "Generator icon"
  annotation (
    Icon(coordinateSystem(preserveAspectRatio = false), graphics={
        Text(lineColor={28,108,200},
          extent={{-90,90},{90,30}},
          textString="%name",
          textStyle={TextStyle.Bold}),
        Polygon(
          points={{6,-38},{-14,-62},{1.375,-62},{-14,-80},{14,-56},{0,-56},{20,-38},{6,-38}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-60,30},{60,-90}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-20,-62},{-8,-50},{10,-72},{20,-62}},
          color={238,46,47},
          smooth=Smooth.Bezier),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          pattern=LinePattern.None),
        Text(
          extent={{-30,22},{30,-18}},
          lineColor={0,0,0},
          textString="G"),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0})}),
    Diagram(coordinateSystem(preserveAspectRatio = false)));
end Generator;
