within OpenHPL.Icons;
partial class Pipe "Pipe icon"
  parameter Boolean vertical=false "Display vertical icon instead"
    annotation(Dialog(group = "Icon"),
    choices(checkBox = true));
  annotation (
    Icon(coordinateSystem(grid={1,1}),
         graphics={
        Rectangle(
          extent={{-90,40},{90,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175}),
        Rectangle(
          extent={{-90,30},{90,-30}},
          lineColor={28,108,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-90,90},{90,-90}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=vertical),
        Rectangle(
          extent={{-85,30},{85,-30}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175},
          origin={0,0},
          rotation=-45,
          visible=vertical),
        Rectangle(
          extent={{-85,20},{85,-20}},
          lineColor={28,108,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          origin={0,0},
          rotation=-45,
          visible=vertical),
                     Text(
          lineColor={28,108,200},
          extent={{-150,140},{150,100}},
          textString="%name",
          textStyle={TextStyle.Bold})}));
end Pipe;
