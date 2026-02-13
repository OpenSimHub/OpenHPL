within OpenHPL;
package Interfaces "Basic interface components"
  extends Modelica.Icons.InterfacesPackage;
annotation (Documentation(info="<html>
<h4>Interfaces</h4>
<p>
 In the <strong>OpenHPL</strong>, 
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
  annotation (...);
end Contact;
</pre>

<h5>Extensions of Contact Connector</h5>
<p>
In addition, some extensions of this water flow connector are developed for better use in the library:
</p>

<h6>TwoContacts</h6>
<p>
<code>TwoContacts</code> is an extension from the <code>Contact</code> model which provides a model of 
two connectors of inlet and outlet contacts:
</p>
<pre>
partial model TwoContact \"Model of two connectors\"
  Contact i \"Inlet contact\";
  Contact o \"Outlet contact\";
end TwoContact;
</pre>

<h6>TurbineContacts</h6>
<p>
<code>TurbineContacts</code> is an extension from <code>TwoContacts</code> model and provides the real 
input and output connectors, additionally. This model is used for turbine modelling:
</p>
<pre>
partial model TurbineContacts \"Model of turbine connectors\"
  extends TwoContacts;
  input Modelica.Blocks.Interfaces.RealInput u_t  \"[Guide vane|nozzle] opening of the turbine\" ;
  Modelica.Blocks.Interfaces.RealOutput P_out \"Mechanical Output power\" ;
end TurbineContacts;
</pre>
</html>"));
end Interfaces;
