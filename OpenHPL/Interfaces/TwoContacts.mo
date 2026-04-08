within OpenHPL.Interfaces;
partial model TwoContacts "Model of two connectors"
  outer Data data;
  Contact_i i(showElevation=data.showElevation) "Inlet contact (positive design flow direction is from i to o)"
                              annotation (
    Placement(transformation(extent={{-110,-10},{-90,10}})));
  Contact_o o(showElevation=data.showElevation) "Outlet contact (positive design flow direction is from i to o)"
                               annotation (
    Placement(transformation(extent={{90,-10},{110,10}})));
equation
  o.gz = i.gz "Elevation auxiliary variable: propagate gz from inlet to outlet";
  annotation (
    Documentation(info = "<html>
    <p>TwoContact is a partial model, which consists of two Contacts <em>i</em>and <em>o</em>.
    Can be used in cases where model is needed inlet and outlet Contacts, but do not need
    any specification about mass flow rate and pressures between these Contacts.</p>
</html>"));
end TwoContacts;
