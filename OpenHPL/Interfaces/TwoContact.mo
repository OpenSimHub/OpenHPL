within OpenHPL.Interfaces;
partial model TwoContact "Model of two connectors"
  Contact p "Inlet contact" annotation (
    Placement(transformation(extent={{-110,-10},{-90,10}})));
  Contact n "Outlet contact" annotation (
    Placement(transformation(extent={{90,-10},{110,10}})));
  annotation (
    Documentation(info = "<html>
<p>TwoContact is a partial model, which consists of two Contacts <i>p </i>and <i>n</i>. Can be used in cases where model is needed inlet and outlet Contacts, but don&apos;t need any specification about mass flow rate and pressures between these Contacts.</p>
</html>"));
end TwoContact;
