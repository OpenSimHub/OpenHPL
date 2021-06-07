within OpenHPL.Interfaces;
partial model TwoContact "Model of two connectors"
  Contact i "Inlet contact" annotation (
    Placement(transformation(extent={{-110,-10},{-90,10}})));
  Contact o "Outlet contact" annotation (
    Placement(transformation(extent={{90,-10},{110,10}})));
  annotation (
    Documentation(info = "<html>
    <p>TwoContact is a partial model, which consists of two Contacts <em>i</em>and <em>o</em>. 
    Can be used in cases where model is needed inlet and outlet Contacts, but do not need
    any specification about mass flow rate and pressures between these Contacts.</p>
</html>"));
end TwoContact;
