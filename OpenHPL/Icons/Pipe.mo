within OpenHPL.Icons;
partial class Pipe "Pipe icon"
  parameter Boolean slanted=false "Display slanted icon instead"
    annotation(Dialog(group = "Icon"),
    choices(checkBox = true));
  annotation (
    preferredView="icon",
    Icon(graphics={
        Rectangle(
          extent={{-90,40},{90,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175},
          visible=not slanted),
        Rectangle(
          extent={{-90,30},{90,-30}},
          lineColor={28,108,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          visible=not slanted),
        Rectangle(
          extent={{-85,30},{85,-30}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175},
          rotation=-45,
          visible=slanted),
        Rectangle(
          extent={{-85,20},{85,-20}},
          lineColor={28,108,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          rotation=-45,
          visible=slanted),
        Text(
          textColor={28,108,200},
          extent={{-150,140},{150,100}},
          textString="%name",
          textStyle={TextStyle.Bold},
          visible=slanted),
        Text(
          textColor={28,108,200},
          extent={{-150,90},{150,50}},
          textString="%name",
          textStyle={TextStyle.Bold},
          visible=not slanted)}));
end Pipe;
