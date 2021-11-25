within OpenHPL.ElectroMech.PowerSystem;
model Grid
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(points={{0,90},{-20,70},{-20,-50},{40,-80},{20,-50},{-40,-80},{-20,-50},{20,-50},{-20,-10},{20,30},{-20,70},{20,70},{20,-50},{-20,-50},{20,-10},{-20,30},{20,70},{0,90}},
                                                                                                                                        color={0,0,0}),
        Line(points={{-20,70},{-52,50},{52,50},{20,70},{-20,70}}, color={0,0,0}),
        Line(points={{-20,10},{-72,-10},{72,-10},{20,10},{-20,10}},
                                                                color={0,0,0}),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
        Text(
          lineColor={28,108,200},
          extent={{-100,-110},{100,-150}},
          textString="%name",
          textStyle={TextStyle.Bold})}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Grid;
