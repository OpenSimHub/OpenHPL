within OpenHPL.Interfaces;
partial model TurbineContacts "Model of turbine connectors"
  extends Interfaces.ContactPort;
  input Modelica.Blocks.Interfaces.RealInput u_t "[Guide vane|nozzle] opening of the turbine" annotation (
    Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = -90, origin={0,120})));
  Modelica.Blocks.Interfaces.RealOutput P_out "Mechanical Output power" annotation (
    Placement(transformation(origin={0,-110}, extent={{-10,-10},{10,10}},      rotation = 270)));
end TurbineContacts;
