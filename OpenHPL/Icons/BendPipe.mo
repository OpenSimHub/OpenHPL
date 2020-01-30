within OpenHPL.Icons;
partial class BendPipe "Bend pipes icon."
  parameter Boolean vertical=false "Display vertical icon instead"
    annotation(Dialog(group = "Icon"),
    choices(checkBox = true));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, grid={1,1}), graphics={
        Text(lineColor={28,108,200},
          extent={{-145,111},{155,71}},
          textString="%name",
          textStyle={TextStyle.Bold}),
        Rectangle(
          extent={{-76,50},{28,1}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175}),
        Rectangle(
          extent={{-54.75,24.75},{54.75,-24.75}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          origin={51.75,-4.25},
          rotation=90),
        Ellipse(
          extent={{-89,52},{-54,0}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175},
          startAngle=0,
          endAngle=360),
        Ellipse(
          extent={{-15.5,25.5},{15.5,-25.5}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175},
          origin={51.5,-60.5},
          rotation=90),
        Ellipse(
          extent={{-85,46},{-59,6}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360,
          closure=EllipseClosure.Chord),
        Ellipse(
          extent={{-13,20},{13,-20}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360,
          closure=EllipseClosure.Chord,
          origin={52,-61},
          rotation=90)}));
end BendPipe;
