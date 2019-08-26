within OpenHPL.Interfaces;
partial model ContactNode "Model of two connectors and node pressure"
  Modelica.SIunits.Pressure p_n "Node pressure";
  //Modelica.SIunits.Temperature T_n "Node temperature";
  Modelica.SIunits.MassFlowRate m_dot "Mass flow rate";
  extends TwoContact;
equation
  p_n = p.p;
  p.p = n.p;
  //T_n = p.T;
  //p.T = n.T;
  m_dot = p.m_dot + n.m_dot;
  annotation (
    Documentation(info = "<html>
    <p>ContactNode is a superclass, which has two Contacts <code>p</code>, <code>n</code> and assumes
    that inlet pressure of <code>p</code> is equal to outlet at <code>n</code>.
    This node pressure is determined by <code>p_n</code>.
    Also the mass flow rate in this node is <code>m_dot</code>.</p>
</html>"));
end ContactNode;
