within OpenHPL.Interfaces;
connector Contact "Water flow connector"
  Modelica.SIunits.Pressure p "Contact pressure";
  //Modelica.SIunits.Temperature T "Contact temperature";
  flow Modelica.SIunits.MassFlowRate mdot "Mass flow rate through the contact";
  annotation (
    Icon(graphics={  Ellipse(extent={{-100,-100},{100,100}},  lineColor = {28, 108, 200}, fillColor = {0, 128, 255},
            fillPattern =                                                                                                          FillPattern.Solid)}),
    Documentation(info = "<html>
<p>Contact is a basic water flow connector, which consists of water pressure and mass flow rate through the connector (positive if water is flowing into connector and negative if flowing out).</p>
</html>"));
end Contact;
