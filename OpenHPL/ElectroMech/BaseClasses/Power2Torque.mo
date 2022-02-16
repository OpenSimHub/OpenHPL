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
  parameter Integer p(min=2) = 12 "Number of poles for mechanical speed calculation"
   annotation (Dialog(group = "Mechanical"),
               choices( choice = 2 "2,[3000|3600] rpm",
                        choice = 4 "4,[1500|1800] rpm",
                        choice = 6 "6,[1000|1200] rpm",
                        choice = 8 "8,[750|900] rpm",
                        choice = 10 "10,[600|720] rpm",
                        choice = 12 "12,[500|600] rpm",
                        choice = 14 "14,[429|514] rpm",
                        choice = 16 "16,[375|450] rpm",
                        choice = 18 "18,[333|400] rpm",
                        choice = 20 "20,[300|360] rpm",
                        choice = 22 "22,[273|327] rpm",
                        choice = 24 "24,[250|300] rpm",
                        choice = 26 "26,[231|277] rpm",
                        choice = 28 "28,[214|257] rpm",
                        choice = 30 "30,[200|240] rpm",
                        choice = 28 "32,[187.5|225] rpm"));
    parameter SI.Power Ploss = 0 "Friction losses of the unit at nominal speed"
    annotation (Dialog(group = "Mechanical"));
  parameter SI.AngularVelocity w_0 = data.f_0 * 4 * C.pi / p "Initial mechanical angular velocity"
    annotation (Dialog(group = "Initialization"));
  parameter Boolean enable_nomSpeed = false "If checked, turbine runs with nominal angular velocity w_0"
    annotation (choices(checkBox = true), Dialog(group = "Initialization"));
  parameter Boolean enable_w = false "If checked, get a connector for angular velocity output"
    annotation (choices(checkBox = true), Dialog(group = "Outputs"));
  parameter Boolean enable_f = false "If checked, get a connector for frequency output"
    annotation (choices(checkBox = true), Dialog(group = "Outputs"));

  Modelica.Blocks.Math.Division power2torque annotation (Placement(transformation(extent={{-66,-6},{-54,6}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={20,-20})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=if useH then 2*H*Pmax/w_0^2 else J,  w(start=w_0, fixed=not enable_nomSpeed)) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Machines.Losses.Friction friction(frictionParameters(PRef=Ploss, wRef=data.f_0*4*C.pi/p))
                                                        annotation (Placement(transformation(extent={{10,60},{30,40}})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed annotation (Placement(transformation(extent={{30,50},{50,70}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque annotation (Placement(transformation(extent={{-26,-6},{-14,6}})));
  Modelica.Blocks.Nonlinear.Limiter div0protect(uMax=Modelica.Constants.inf, uMin=Modelica.Constants.small) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={-40,-40})));
  Modelica.Blocks.Math.Gain toHz(k=SI.Conversions.to_Hz(p/2)) annotation (Placement(transformation(extent={{76,-46},{88,-34}})));
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

  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange "Flange of right shaft" annotation (Placement(transformation(extent={{50,-10},{70,10}}),  iconTransformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.RealExpression power annotation (Placement(transformation(extent={{-50,20},{-70,40}})));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor frictionLoss annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={20,20})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed nomSpeed(w_fixed=w_0*p/2) if
                                                                                  enable_nomSpeed annotation (Placement(transformation(extent={{86,-6},{74,6}})));
  Modelica.Mechanics.Rotational.Components.IdealGear toSysSpeed(ratio=2/p) "Converts to system speed based on p = 2" annotation (Placement(transformation(extent={{34,-6},{46,6}})));
equation
  connect(toHz.u, speedSensor.w) annotation (Line(
      points={{74.8,-40},{20,-40},{20,-31}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(w, speedSensor.w) annotation (Line(
      points={{110,40},{50,40},{50,-40},{20,-40},{20,-31}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(div0protect.y, power2torque.u2) annotation (Line(points={{-46.6,-40},{-80,-40},{-80,-3.6},{-67.2,-3.6}},
                                                                                                             color={0,0,127}));
  connect(f,toHz. y) annotation (Line(points={{110,-40},{88.6,-40}},
                                                               color={0,0,127}));
  connect(power2torque.y, torqueLimit.u) annotation (Line(points={{-53.4,0},{-54,0},{-54,8.88178e-16},{-47.2,8.88178e-16}},
                                                                                                                          color={0,0,127}));
  connect(torqueLimit.y, torque.tau) annotation (Line(points={{-33.4,-6.66134e-16},{-32,-6.66134e-16},{-32,0},{-27.2,0}},
                                                                                                                        color={0,0,127}));
  connect(speedSensor.w,div0protect. u) annotation (Line(points={{20,-31},{20,-40},{-32.8,-40}},
                                                                                         color={0,0,127}));
  connect(inertia.flange_b, speedSensor.flange) annotation (Line(points={{10,0},{20,0},{20,-10}}, color={0,0,0}));
  connect(friction.support, fixed.flange) annotation (Line(points={{20,60},{20,70},{40,70},{40,60}}, color={0,0,0}));
  connect(torque.flange, inertia.flange_a) annotation (Line(points={{-14,0},{-10,0}},
                                                                                   color={0,0,0}));
  connect(w, w) annotation (Line(points={{110,40},{105,40},{105,40},{110,40}}, color={0,0,127}));
  connect(power.y, power2torque.u1) annotation (Line(points={{-71,30},{-80,30},{-80,3.6},{-67.2,3.6}},
                                                                                                 color={0,0,127}));
  connect(frictionLoss.flange_a, inertia.flange_b) annotation (Line(points={{20,10},{20,0},{10,0}}, color={0,0,0}));
  connect(frictionLoss.flange_b, friction.flange) annotation (Line(points={{20,30},{20,40}}, color={0,0,0}));
  connect(nomSpeed.flange, flange) annotation (Line(points={{74,0},{60,0}}, color={0,0,0},
      pattern=LinePattern.Dash));
  connect(flange, toSysSpeed.flange_b) annotation (Line(points={{60,0},{46,0}}, color={0,0,0}));
  connect(toSysSpeed.flange_a, inertia.flange_b) annotation (Line(points={{34,0},{10,0}}, color={0,0,0}));
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
