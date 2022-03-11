within OpenHPL.Waterway;
model VolumeFlowSource "Volume flow source (either fixed or variable)"
  extends Icons.RunOff;
  outer Data data "using standard class with constants";

  parameter SI.VolumeFlowRate Vdot_0=1 "Fixed outlet flow."
    annotation (Dialog(enable=not useInput));
  parameter Boolean useInput=false "If checked, the outlet flow is determined by the input connector."
    annotation (choices(checkBox = true));
  parameter Boolean useFilter=false "If checked, pass the inpput signal through a first order filter."
    annotation (choices(checkBox = true),Dialog(enable=useInput));
  parameter SI.Time T_f=0.01 "Time constant of the first order filter."
    annotation (Dialog(enable=useInput and useFilter));

  Interfaces.Contact_o o "Outlet flow connector"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput outFlow if useInput "Conditional input for defining the outlet flow [m3/s]"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Sources.RealExpression constantVolumeFlow(y=Vdot_0) if not useInput
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    T=T_f,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=data.Vdot_0) if                                   useFilter
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
protected
  Modelica.Blocks.Interfaces.RealOutput Vdot "Outlet flow"
    annotation (Placement(transformation(extent={{60,-20},{100,20}})));
  Modelica.Blocks.Interfaces.RealOutput feedthrough if useInput and not useFilter "direct feedthrough"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Interfaces.RealOutput filtered if useFilter "filtered input"
    annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
equation
  connect(filtered, Vdot) annotation (Line(
      points={{10,-20},{40,-20},{40,0},{80,0}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  o.mdot = -data.rho*Vdot;
  connect(constantVolumeFlow.y, Vdot) annotation (Line(points={{-39,40},{40,40},{40,0},{80,0}}, color={0,0,127}));
  connect(firstOrder.u, outFlow) annotation (Line(
      points={{-62,-20},{-80,-20},{-80,0},{-120,0}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(Vdot, feedthrough) annotation (Line(
      points={{80,0},{10,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(feedthrough, outFlow) annotation (Line(
      points={{10,0},{-120,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(firstOrder.y, filtered) annotation (Line(
      points={{-39,-20},{10,-20}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  annotation (Documentation(info="<html>
Can be used as an ideal volume flow source. Either with a fixed volume flow defined by <code>Vdot_0</code>
or via the input connector <code>inFlow</code>. 
In addition the input can be passed through a first order filter which is sometimes necessary 
for numerical reasons depending on the nature of the input data stream.
</html>"));
end VolumeFlowSource;
