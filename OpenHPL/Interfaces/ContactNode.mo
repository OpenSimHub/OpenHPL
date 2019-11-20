within OpenHPL.Interfaces;
partial model ContactNode "Model of two connectors and node pressure"
  Modelica.SIunits.Pressure p_n "Node pressure";
  //Modelica.SIunits.Temperature T_n "Node temperature";
  Modelica.SIunits.MassFlowRate m_dot "Mass flow rate";
  extends TwoContact;
equation
  p_n = i.p;
  i.p = o.p;
  //T_n = i.T;
  //i.T = o.T;
  m_dot = i.m_dot + o.m_dot;
  annotation (
    Documentation(info = "<html>
    <p>ContactNode is a superclass, which has two Contacts <code>i</code>, <code>o</code> and assumes
    that inlet pressure of <code>i</code> is equal to outlet at <code>o</code>.
    This node pressure is determined by <code>p_n</code>.
    Also the mass flow rate in this node is <code>m_dot</code>.</p>
</html>"));
end ContactNode;
