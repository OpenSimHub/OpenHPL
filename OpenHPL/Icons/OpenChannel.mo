within OpenHPL.Icons;
partial class OpenChannel "Open channel icon"
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, grid={1,1}),
                                                        graphics={
        Text(lineColor={28,108,200},
          extent={{-150,100},{150,60}},
          textString="%name",
          textStyle={TextStyle.Bold}),
        Polygon(
          points={{-70,-10},{-60,-10},{-60,-50},{-20,-50},{-20,-10},{-10,-10},{-10,-60},{-70,-60},{-70,-10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={215,215,215}),
        Polygon(
          points={{-70,-10},{20,50},{27,50},{-60,-10},{-70,-10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={215,215,215}),
        Polygon(
          points={{-20,-10},{54,50},{60,50},{-10,-10},{-20,-10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={215,215,215}),
        Polygon(
          points={{-60,-11},{-60,-11}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={215,215,215}),
        Polygon(
          points={{-60,-10},{-60,-20},{27,43},{27,50},{-60,-10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={215,215,215}),
        Polygon(
          points={{-10,-10},{-10,-60},{60,21},{60,50},{-10,-10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={215,215,215}),
        Polygon(
          points={{-59,-20},{-59,-20}},
          lineColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={28,108,200}),
        Polygon(
          points={{-60,-20},{27,43},{46,43},{-20,-10},{-20,-20},{-60,-20}},
          lineColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={28,108,200}),
        Rectangle(
          extent={{-60,-20},{-20,-50}},
          lineColor={0,128,255},
          fillPattern=FillPattern.Backward,
          fillColor={85,170,255})}),
    Diagram(coordinateSystem(preserveAspectRatio=false, grid={1,1})));
end OpenChannel;
