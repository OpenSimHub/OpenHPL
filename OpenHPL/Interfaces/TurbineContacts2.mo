within OpenHPL.Interfaces;
partial model TurbineContacts2 "Model of turbine connectors"
  extends Interfaces.ContactPort;
  parameter Boolean enable_P_out = false "If checked, get a connector for the output power"
    annotation (choices(checkBox = true), Dialog(group="Outputs",tab="I/O"));
  input Modelica.Blocks.Interfaces.RealInput u_t "[Guide vane|nozzle] opening of the turbine" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-80,120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-80,120})));
  Modelica.Blocks.Interfaces.RealOutput P_out(unit="W") if enable_P_out "Mechanical Output power" annotation (
    Placement(transformation(origin={40,110}, extent={{-10,-10},{10,10}}, rotation=90), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,110})));
end TurbineContacts2;
