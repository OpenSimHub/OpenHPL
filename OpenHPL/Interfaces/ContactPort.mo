within OpenHPL.Interfaces;
partial model ContactPort "Model of two connectors with mass flow rate"
  Modelica.SIunits.MassFlowRate m_dot "Mass flow rate";
  extends TwoContact;
equation
  0 = i.m_dot + o.m_dot;
  m_dot = i.m_dot;
  annotation (
    Documentation(info = "<html>
    <p>ContactPort is a superclass, which has two Contacts <code>i</code>, <code>o</code> and
    assumes that the inlet mass flow rate of <code>i</code> is identical to the outlet
    mass flow rate of <code>o</code>. This mass flow rate is determined as <code>m_dot</code>.</p>
</html>"));
end ContactPort;
