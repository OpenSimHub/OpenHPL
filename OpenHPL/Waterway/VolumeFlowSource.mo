within OpenHPL.Waterway;
model VolumeFlowSource "Volume flow source (either fixed or variable)"
  extends Icons.RunOff;
  outer Data data "using standard class with constants";

  parameter Boolean useInput=false "If checked, the outlet flow is determined by the input connector."
    annotation (choices(checkBox = true));
  parameter SI.VolumeFlowRate Vdot_0=1 "Fixed outlet flow" annotation (Dialog(enable=not useInput));
 // SI.VolumeFlowRate Vdot "Volume flow rate";

  Interfaces.Contact_o o "Outlet flow connector"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput outFlow if useInput "Conditional input for defining the outlet flow [m3/s]"
                                                            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Sources.RealExpression constantVolumeFlow(y=Vdot_0) if not useInput annotation (Placement(transformation(extent={{-60,30},{-40,50}})));

protected
  Modelica.Blocks.Interfaces.RealOutput Vdot "Outlet flow" annotation (Placement(transformation(extent={{60,-20},{100,20}})));

equation
  o.mdot = -data.rho*Vdot;
  connect(constantVolumeFlow.y, Vdot) annotation (Line(
      points={{-39,40},{0,40},{0,0},{80,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(outFlow, Vdot) annotation (Line(
      points={{-120,0},{80,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Documentation(info="<html>
Can be used as an ideal volume flow source. Either with a fixed volume flow defined by <code>Vdot_0</code>
or via the input connector <code>inFlow</code>.
</html>"));
end VolumeFlowSource;
