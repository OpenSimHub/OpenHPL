within OpenHPL.Icons;
partial class Pipe "Pipe icon"
  parameter Boolean vertical=false "Display vertical icon instead"
    annotation(Dialog(group = "Icon"),
    choices(checkBox = true));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, grid={1,1}),
                                                        graphics={
        Rectangle(
          extent={{-86.6068,-42.7109},{86.6068,42.7109}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-0.000257904,-4.99992},
          rotation=-5,
          radius=50),
        Ellipse(
          extent={{-32.8116,42.3012},{32.8116,-42.3012}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360,
          origin={-54,-0.999955},
          rotation=-5),
        Ellipse(
          extent={{-27.8931,37.7122},{27.8931,-37.7122}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360,
          origin={-54,0},
          rotation=-5),
        Rectangle(
          extent={{-90,60},{90,-90}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=vertical),
        Rectangle(
          extent={{-86.0196,-30.0189},{86.0196,30.0189}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={13.5,-15.5},
          rotation=-50,
          radius=50,
          visible=vertical),
        Ellipse(
          extent={{-25,29.5},{25,-29.5}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360,
          origin={54,-62.5},
          rotation=-50,
          visible=vertical),
        Ellipse(
          extent={{-19.5,24},{19.5,-24}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360,
          origin={54.5,-63},
          rotation=-50,
          visible=vertical),
        Text(lineColor={28,108,200},
          extent={{-150,100},{150,60}},
          textString="%name",
          textStyle={TextStyle.Bold})}));
end Pipe;
