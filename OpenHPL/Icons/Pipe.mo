within OpenHPL.Icons;
partial class Pipe "Pipe icon"
  parameter Boolean vertical=false "Display vertical icon instead"
    annotation(Dialog(group = "Icon"),
    choices(checkBox = true));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, grid={1,1}), graphics={
        Rectangle(
          extent={{-81.0342,-39.524},{81.0342,39.524}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.HorizontalCylinder,
          rotation=-5,
          radius=50,
          origin={1.8294,-9.311}),
        Ellipse(
          extent={{-27.482,38.7523},{27.482,-38.7523}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360,
          rotation=-5,
          origin={-52.0001,-5.00005}),
        Ellipse(
          extent={{-20.3531,31.8473},{20.3531,-31.8473}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360,
          rotation=-5,
          origin={-52.5,-5.5}),
        Text(lineColor={28,108,200},
          extent={{-150,104},{150,64}},
          textString="%name",
          textStyle={TextStyle.Bold})}));
end Pipe;
