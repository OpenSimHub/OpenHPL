within OpenHPL.Interfaces;
partial model ContactNode "Model of two connectors and node pressure"
  SI.Pressure p_n "Node pressure";
  //SI.Temperature T_n "Node temperature";
  SI.MassFlowRate mdot "Mass flow rate";
  extends TwoContact;
equation
  p_n = i.p;
  i.p = o.p;
  //T_n = i.T;
  //i.T = o.T;
  mdot = i.mdot + o.mdot;
  annotation (
    Documentation(info = "<html>
    <p>ContactNode is a superclass, which has two Contacts <code>i</code>, <code>o</code> and assumes
    that inlet pressure of <code>i</code> is equal to outlet at <code>o</code>.
    This node pressure is determined by <code>p_n</code>.
    Also the mass flow rate in this node is <code>mdot</code>.</p>
</html>"));
end ContactNode;
