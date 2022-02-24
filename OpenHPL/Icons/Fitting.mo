within OpenHPL.Icons;
partial class Fitting "Pipe fitting icon"
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, grid={1,1}),
                                                        graphics={
        Rectangle(
          extent={{-90,60},{10,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175}),
        Rectangle(
          extent={{9,30},{90,-30}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175},
          pattern=LinePattern.None),
        Rectangle(
          extent={{-90,50},{0,-50}},
          lineColor={28,108,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
                     Text(
          lineColor={28,108,200},
          extent={{-150,140},{150,100}},
          textString="%name",
          textStyle={TextStyle.Bold}),
        Rectangle(
          extent={{0,20},{90,-21}},
          lineColor={28,108,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(points={{10,25}}, color={0,0,0}),
        Line(points={{10,30},{90,30},{90,20},{0,20},{0,50},{-90,50}}, color={0,0,0}),
        Line(points={{-90,-50},{0,-50},{0,-21},{90,-21},{90,-30},{10,-30}}, color={0,0,0})}),
    Diagram(coordinateSystem(preserveAspectRatio=false, grid={1,1})));
end Fitting;
