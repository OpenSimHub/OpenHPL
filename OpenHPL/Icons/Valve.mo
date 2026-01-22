within OpenHPL.Icons;
partial class Valve "Valve icon"
  annotation (
    preferredView="icon",
    Icon(graphics={
        Text(
          textColor={28,108,200},
          extent={{-100,-60},{100,-100}},
          textString="%name",
          textStyle={TextStyle.Bold}),
        Polygon(
          points={{-90,40},{0,10},{90,40},{90,30},{0,0},{-90,30},{-90,40}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-90,-30},{0,0},{90,-30},{90,-40},{0,-10},{-90,-40},{-90,-30}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-90,-30},{-90,30},{0,0},{-90,-30}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{90,-30},{90,30},{0,0},{90,-30}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,60},{20,50}},
          fillPattern=FillPattern.Solid),
        Line(points={{0,50},{0,0}})}));
end Valve;
