within OpenHPL.ElectroMech.Generators;
model SimpleGen2 "Model of a simple generator with mechanical connectors"
  outer Data data "Using standard class with global parameters";
  extends OpenHPL.Icons.Generator;
  parameter SI.Power Pmax = 100e6 "Maximum power (for torque limiting)"
   annotation (Dialog(group = "Mechanical"));
  parameter SI.MomentOfInertia Jg = 2e5 "Moment of inertia of the generator"
    annotation (Dialog(group = "Mechanical"));
  parameter Integer p = 12 "Number of poles (for speed calculation)"
   annotation (Dialog(group = "Mechanical"));
  parameter SI.Power Ploss = 0 "Friction losses of generator at nominal speed"
    annotation (Dialog(group = "Mechanical"));
  parameter SI.AngularVelocity w_0 = data.f_0 * 4 * C.pi / p "Initial angular velocity" annotation (
    Dialog(group = "Initialization"));
  parameter Boolean UseFrequencyOutput = false "If checked - get a connector for frequency output" annotation (
    choices(checkBox = true));

  Modelica.Blocks.Interfaces.RealInput Pload(unit="W") "Electrical load power demand" annotation (Placement(
      visible=true,
      transformation(extent={{-20,-20},{20,20}},    rotation=270,
        origin={0,120}),
      iconTransformation(extent={{-20,-20},{20,20}},   rotation=270,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealOutput f(unit="Hz") if UseFrequencyOutput "Output of generator frequency"
                                                                                             annotation (
    Placement(transformation(extent={{100,-50},{120,-30}}), iconTransformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.RealOutput w "Angular velocity of the generator"         annotation (
    Placement(visible = true, transformation(origin={110,40},    extent={{-10,-10},
            {10,10}},                                                                             rotation=0),
      iconTransformation(extent={{-10,-10},{10,10}}, origin={110,40})));
  Modelica.Blocks.Math.Division loadPtoT annotation (Placement(transformation(extent={{-80,16},{-60,36}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-30,-40})));
  Modelica.Mechanics.Rotational.Components.Inertia generatorInertia(J=Jg, w(start=w_0,fixed=true)) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,0})));
  Modelica.Electrical.Machines.Losses.Friction friction(frictionParameters(PRef=Ploss, wRef=data.f_0*4*C.pi/p))
                                                        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={28,-60})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed annotation (Placement(transformation(extent={{50,-80},{70,-60}})));
  Modelica.Mechanics.Rotational.Sources.Torque generatorTorque annotation (Placement(transformation(extent={{-20,16},{0,36}})));

  Modelica.Blocks.Math.Gain neg(k=-1) annotation (Placement(transformation(extent={{6,-6},{-6,6}},
        rotation=0,
        origin={-30,80})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange "Flange of generator shaft" annotation (Placement(transformation(extent={{-10,-110},{10,-90}}), iconTransformation(extent={{-10,-108},{10,-88}})));
  Modelica.Blocks.Nonlinear.Limiter div0protect(uMax=Modelica.Constants.inf, uMin=Modelica.Constants.small) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={-70,-40})));
  Modelica.Blocks.Math.Gain toHz(k=SI.Conversions.to_Hz(p/2)) annotation (Placement(transformation(extent={{74,-50},{94,-30}})));
  Modelica.Blocks.Nonlinear.Limiter torqueLimit(uMax=Pmax/w_0) annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={-40,26})));
equation
  connect(friction.support, fixed.flange) annotation (Line(points={{38,-60},{60,-60},{60,-70}},
                                                                                     color={0,0,0}));
  connect(loadPtoT.u1, neg.y) annotation (Line(points={{-82,32},{-90,32},{-90,80},{-36.6,80}}, color={0,0,127}));
  connect(neg.u, Pload) annotation (Line(points={{-22.8,80},{0,80},{0,120}},            color={0,0,127}));
  connect(generatorInertia.flange_a, flange) annotation (Line(points={{0,-10},{0,-100}}, color={0,0,0}));
  connect(speedSensor.w, div0protect.u) annotation (Line(points={{-41,-40},{-62.8,-40}}, color={0,0,127}));
  connect(div0protect.y, loadPtoT.u2) annotation (Line(points={{-76.6,-40},{-90,-40},{-90,20},{-82,20}}, color={0,0,127}));
  connect(generatorTorque.flange, generatorInertia.flange_b) annotation (Line(points={{0,26},{0,10}}, color={0,0,0}));
  connect(w, speedSensor.w) annotation (Line(points={{110,40},{42,40},{42,-20},{-46,-20},{-46,-40},{-41,-40}}, color={0,0,127}));
  connect(speedSensor.flange, flange) annotation (Line(points={{-20,-40},{0,-40},{0,-100}}, color={0,0,0}));
  connect(friction.flange, flange) annotation (Line(points={{18,-60},{0,-60},{0,-100}}, color={0,0,0}));
  connect(f,toHz. y) annotation (Line(points={{110,-40},{95,-40}},
                                                               color={0,0,127}));
  connect(toHz.u, w) annotation (Line(points={{72,-40},{42,-40},{42,40},{110,40}},
                                                                               color={0,0,127}));
  connect(loadPtoT.y, torqueLimit.u) annotation (Line(points={{-59,26},{-47.2,26}}, color={0,0,127}));
  connect(torqueLimit.y, generatorTorque.tau) annotation (Line(points={{-33.4,26},{-22,26}}, color={0,0,127}));
  annotation (
    Documentation(info="<html><p>Simple model of an ideal generator with friction.</p>
<p>This model has inputs as electric power available on the grid and the turbine shaft power.
This model based on the angular momentum balance, which depends on the turbine shaft power,
 the friction loss in the aggregate rotation and the power taken up by the generator.</p>
<p align=\"center\">
<img src=\"modelica://OpenHPL/Resources/Images/simplegen.svg\">
</p>
</html>"), Icon(graphics={Text(
          extent={{80,50},{100,30}},
          lineColor={0,0,0},
          textString="w"), Text(
          extent={{80,-30},{100,-50}},
          lineColor={0,0,0},
          textString="f",
          visible=UseFrequencyOutput)}));
end SimpleGen2;
