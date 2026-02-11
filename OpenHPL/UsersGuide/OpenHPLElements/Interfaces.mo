within OpenHPL.UsersGuide.OpenHPLElements;
class Interfaces "Interface Connectors"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<h4>Interfaces</h4>
<p>
A detailed description of the interface connectors is provided here. In the <strong>OpenHPL</strong>, 
two types of connectors are typically used. The first type is the standard Modelica real input/output 
connector, the other type is a set of connectors that represent the water flow and are modelled similar 
to the connection in an electrical circuit with voltage and current, or similar to the idea of potential 
and flow in Bond Graph models.
</p>

<h5>Contact Connector</h5>
<p>
The water flow connector which is called <code>Contact</code> in the library, contains information about 
the pressure in the connector and mass flow rate that flows through the connector. An example of a 
Modelica code for defining the <code>Contact</code> connector looks as follows:
</p>
<pre>
connector Contact \"Water flow connector\"
  Modelica.SIunits.Pressure p \"Contact pressure\";
  flow Modelica.SIunits.MassFlowRate mdot \"Mass flow rate through the contact\";
  annotation (Icon(graphics={Ellipse(extent={{-100,-100},{100,100}}, 
    lineColor={28,108,200}, fillColor={0,128,255}, 
    fillPattern=FillPattern.Solid)}));
end Contact;
</pre>

<h5>Extensions of Contact Connector</h5>
<p>
In addition, some extensions of this water flow connector are developed for better use in the library:
</p>

<h6>TwoContact</h6>
<p>
<code>TwoContact</code> is an extension from the <code>Contact</code> model which provides a model of 
two connectors of inlet and outlet contacts:
</p>
<pre>
partial model TwoContact \"Model of two connectors\"
  Contact i \"Inlet contact\" 
    annotation(Placement(transformation(extent={{-110,-10},{-90,10}})));
  Contact o \"Outlet contact\" 
    annotation(Placement(transformation(extent={{90,-10},{110,10}})));
end TwoContact;
</pre>

<h6>ContactPort</h6>
<p>
<code>ContactPort</code> is an extension from the <code>TwoContact</code> model which also provides 
information about a mass flow rate between these two connectors. The mass flow rate that flows through 
the inlet connector is equal to the mass flow through the outlet connector. This model is used for the 
pipe modelling:
</p>
<pre>
partial model ContactPort \"Model of two connectors with mass flow rate\"
  Modelica.SIunits.MassFlowRate mdot \"Mass flow rate\";
  extends TwoContact;
equation
  0 = i.mdot + o.mdot;
  mdot = i.mdot;
end ContactPort;
</pre>

<h6>ContactNode</h6>
<p>
<code>ContactNode</code> is an extension from the <code>TwoContact</code> model and provides a node 
pressure that is equal to the pressures from these two connectors. This model also defines the mass flow 
rate that is the sum of the mass flow rates through the inlet and outlet connectors. This model is used 
for the surge tank modelling:
</p>
<pre>
partial model ContactNode \"Model of two connectors and node pressure\"
  Modelica.SIunits.Pressure p_n \"Node pressure\";
  Modelica.SIunits.MassFlowRate mdot \"Mass flow rate\";
  extends TwoContact;
equation
  p_n = i.p;
  i.p = o.p;
  mdot = i.mdot + o.mdot;
end ContactNode;
</pre>

<h6>TurbineContacts</h6>
<p>
<code>TurbineContacts</code> is an extension from <code>ContactPort</code> model and provides the real 
input and output connectors, additionally. This model is used for turbine modelling:
</p>
<pre>
partial model TurbineContacts \"Model of turbine connectors\"
  extends ContactPort;
  input Modelica.Blocks.Interfaces.RealInput u_t 
    \"[Guide vane|nozzle] opening of the turbine\" 
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, 
      rotation=-90, origin={0,120})));
  Modelica.Blocks.Interfaces.RealOutput P_out \"Mechanical Output power\" 
    annotation (Placement(transformation(origin={0,-110}, 
      extent={{-10,-10},{10,10}}, rotation=270)));
end TurbineContacts;
</pre>
</html>"));
end Interfaces;
