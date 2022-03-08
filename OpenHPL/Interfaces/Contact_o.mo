within OpenHPL.Interfaces;
connector Contact_o "Outlet contact"
  extends Contact;
    annotation (defaultComponentName="o",
              Diagram(graphics={Ellipse(
          extent={{-40,40},{40,-40}},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid), Text(extent={{-150,110},{150,50}},
            textString="%name"),
        Ellipse(
          extent={{-30,30},{30,-30}},
          lineColor={0,127,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
       Icon(graphics={Ellipse(
          extent={{-100,100},{100,-100}},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,128,255}),
        Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={0,127,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}));
end Contact_o;
