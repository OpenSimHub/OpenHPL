within OpenHPL.Icons;
partial class Reservoir "Reservoir icon"
  annotation (
    Icon(coordinateSystem(preserveAspectRatio = false), graphics={  Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}),
                                                           Text(
          lineColor={28,108,200},
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
          smooth=Smooth.Bezier)}),
    Diagram(coordinateSystem(preserveAspectRatio = false)));
end Reservoir;
