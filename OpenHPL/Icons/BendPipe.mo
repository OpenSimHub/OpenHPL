within OpenHPL.Icons;
partial class BendPipe "Bend pipes icon."

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, grid={1,1}), graphics={
        Rectangle(
          extent={{-70,50},{34,0}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175}),
        Ellipse(
          extent={{-90,50},{-50,0}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175},
          startAngle=0,
          endAngle=360),
        Ellipse(
          extent={{-86,45},{-55,5}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360,
          closure=EllipseClosure.Chord),
        Text(lineColor={28,108,200},
          extent={{-150,100},{150,60}},
          textString="%name",
          textStyle={TextStyle.Bold}),
        Ellipse(
          extent={{10,50},{60,0}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={175,175,175},
          startAngle=0,
          endAngle=360),
        Rectangle(
          extent={{-45.5,25},{45.5,-25}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          origin={35,-19.5},
          rotation=90),
        Ellipse(
          extent={{-25,25},{25,-25}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175},
          origin={35,-65},
          rotation=90),
        Ellipse(
          extent={{-19.5,20},{19.5,-20}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360,
          closure=EllipseClosure.Chord,
          origin={35,-65.5},
          rotation=90)}));
end BendPipe;
