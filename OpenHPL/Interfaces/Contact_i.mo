within OpenHPL.Interfaces;
connector Contact_i "Inlet contact"
  extends Contact;
    annotation (defaultComponentName="i",
              Diagram(graphics={Ellipse(
          extent={{-40,40},{40,-40}},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid), Text(extent={{-150,110},{150,50}},
            textString="%name")}),
       Icon(graphics={Ellipse(
          extent={{-100,100},{100,-100}},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,128,255})}));
end Contact_i;
