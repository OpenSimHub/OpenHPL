within OpenHPL.ElectroMech.BaseClasses;
partial model Power2Torque "Converts a power signal to a torque in the rotational domain"
  outer Data data "Using standard class with global parameters";

  parameter Boolean useH= false "if checked, calculate the inertia from a given H value"
   annotation (Dialog(group = "Mechanical"), choices(checkBox=true));
  parameter SI.Power Pmax = 100e6 "Maximum rated power (for torque limiting and H calculation)"
   annotation (Dialog(group = "Mechanical"));
  parameter SI.Time H = 2.75 "Inertia constant H, typical 2s (high-head hydro) to 6s (gas or low-head hydro) production units"
    annotation (Dialog(group = "Mechanical", enable=useH));
  parameter SI.MomentOfInertia J = 2e5 "Moment of inertia of the unit"
    annotation (Dialog(group = "Mechanical", enable=not useH));
  parameter Integer p = 12 "Number of poles (for speed and inertia calculation)"
   annotation (Dialog(group = "Mechanical"));
  parameter SI.Power Ploss = 0 "Friction losses of generator at nominal speed"
    annotation (Dialog(group = "Mechanical"));
  parameter SI.AngularVelocity w_0 = data.f_0 * 4 * C.pi / p "Initial angular velocity"
    annotation (Dialog(group = "Initialization"));
  parameter Boolean enable_w = false "If checked, get a connector for angular velocity output"
    annotation (choices(checkBox = true), Dialog(group = "Outputs"));
  parameter Boolean enable_f = false "If checked, get a connector for frequency output"
    annotation (choices(checkBox = true), Dialog(group = "Outputs"));

  Modelica.Blocks.Math.Division power2torque annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={40,-20})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=if useH then 2*H*Pmax/w_0^2 else J,  w(start=w_0, fixed=true)) annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Electrical.Machines.Losses.Friction friction(frictionParameters(PRef=Ploss, wRef=data.f_0*4*C.pi/p))
                                                        annotation (Placement(transformation(extent={{30,40},{50,20}})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed annotation (Placement(transformation(extent={{10,30},{30,50}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Nonlinear.Limiter div0protect(uMax=Modelica.Constants.inf, uMin=Modelica.Constants.small) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={-40,-40})));
  Modelica.Blocks.Math.Gain toHz(k=SI.Conversions.to_Hz(p/2)) annotation (Placement(transformation(extent={{74,-46},{86,-34}})));
  Modelica.Blocks.Nonlinear.Limiter torqueLimit(uMax=Pmax/w_0) annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={-40,0})));
  Modelica.Blocks.Interfaces.RealOutput f(unit="Hz") if enable_f "Output of generator frequency"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}}),
                iconTransformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.RealOutput w if enable_w "Angular velocity of the generator"
    annotation (Placement(transformation(extent={{100,30},{120,50}},                                                                             rotation=0),
      iconTransformation(extent={{100,30},{120,50}})));

  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange "Flange of right shaft" annotation (Placement(transformation(extent={{70,-10},{90,10}}),  iconTransformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.RealExpression power annotation (Placement(transformation(extent={{-60,20},{-80,40}})));
equation
  connect(toHz.u, speedSensor.w) annotation (Line(
      points={{72.8,-40},{40,-40},{40,-31}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(w, speedSensor.w) annotation (Line(
      points={{110,40},{60,40},{60,-40},{40,-40},{40,-31}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(div0protect.y, power2torque.u2) annotation (Line(points={{-46.6,-40},{-90,-40},{-90,-6},{-82,-6}}, color={0,0,127}));
  connect(f,toHz. y) annotation (Line(points={{110,-40},{86.6,-40}},
                                                               color={0,0,127}));
  connect(power2torque.y, torqueLimit.u) annotation (Line(points={{-59,0},{-54,0},{-54,1.11022e-15},{-47.2,1.11022e-15}}, color={0,0,127}));
  connect(torqueLimit.y, torque.tau) annotation (Line(points={{-33.4,-4.44089e-16},{-28,-4.44089e-16},{-28,0},{-22,0}}, color={0,0,127}));
  connect(speedSensor.w,div0protect. u) annotation (Line(points={{40,-31},{40,-40},{-32.8,-40}},
                                                                                         color={0,0,127}));
  connect(inertia.flange_b, speedSensor.flange) annotation (Line(points={{30,0},{40,0},{40,-10}}, color={0,0,0}));
  connect(friction.support, fixed.flange) annotation (Line(points={{40,40},{40,50},{20,50},{20,40}}, color={0,0,0}));
  connect(friction.flange, inertia.flange_b) annotation (Line(points={{40,20},{40,0},{30,0}}, color={0,0,0}));
  connect(flange, inertia.flange_b) annotation (Line(points={{80,0},{30,0}},  color={0,0,0}));
  connect(torque.flange, inertia.flange_a) annotation (Line(points={{0,0},{10,0}}, color={0,0,0}));
  connect(w, w) annotation (Line(points={{110,40},{105,40},{105,40},{110,40}}, color={0,0,127}));
  connect(power.y, power2torque.u1) annotation (Line(points={{-81,30},{-90,30},{-90,6},{-82,6}}, color={0,0,127}));
  annotation (Icon(graphics={
        Text(
          visible=enable_w,
          extent={{80,50},{100,30}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="w"),
        Text(
          visible=enable_f,
          extent={{80,-30},{100,-50}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="f")}));
end Power2Torque;
