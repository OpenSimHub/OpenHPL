within OpenHPL.Icons;
partial class RunOff "Run off model icon"
  annotation (
    Icon(coordinateSystem(preserveAspectRatio = false), graphics={
        Text(textColor={28,108,200},
          extent={{-150,100},{150,60}},
          textString="%name",
          textStyle={TextStyle.Bold}),
        Polygon(
          points={{0,48},{20,12},{40,-28},{30,-68},{0,-80},{-30,-68},{-40,-28},{-20,12},{0,48}},
          lineColor={28,108,200},
          smooth=Smooth.Bezier,
          lineThickness=0.5),
        Line(
          points={{-60,0},{-50,-6},{-40,6},{-30,-6},{-20,6},{-10,-6},{0,0}},
          color={28,108,200},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{-60,-20},{-50,-26},{-40,-14},{-30,-26},{-20,-14},{-10,-26},{0,-20}},
          color={28,108,200},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{-60,-40},{-50,-46},{-40,-34},{-30,-46},{-20,-34},{-10,-46},{0,-40}},
          color={28,108,200},
          smooth=Smooth.Bezier,
          thickness=0.5)}));
end RunOff;
