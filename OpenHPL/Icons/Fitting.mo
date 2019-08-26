within OpenHPL.Icons;
partial class Fitting "Pipe fitting icon"
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, grid={1,1}),
                                                        graphics={
        Rectangle(
          extent={{-58,-42},{58,42}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.HorizontalCylinder,
          rotation=-5,
          radius=50,
          origin={28,0}),
        Ellipse(
          extent={{-32.3168,40.6108},{32.3168,-40.6108}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360,
          rotation=-5,
          origin={1.65436,1.72713}),
        Rectangle(
          extent={{-49,-29},{49,29}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.HorizontalCylinder,
          rotation=-5,
          radius=50,
          origin={-26,5}),
        Ellipse(
          extent={{-21.7712,28.6149},{21.7712,-28.6149}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360,
          rotation=-5,
          origin={-54.8056,7.5965}),
        Ellipse(
          extent={{-17.5173,23.3007},{17.5173,-23.3007}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360,
          rotation=-5,
          origin={-55.5801,7.26125}),
        Text(lineColor={28,108,200},
          extent={{-150,100},{150,60}},
          textString="%name",
          textStyle={TextStyle.Bold})}),
    Diagram(coordinateSystem(preserveAspectRatio=false, grid={1,1})));
end Fitting;
