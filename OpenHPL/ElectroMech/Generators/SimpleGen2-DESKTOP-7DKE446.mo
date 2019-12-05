within OpenHPL.ElectroMech.Generators;
model SimpleGen2 "Model of a simple generator"
  outer Parameters para "Using standard class with constants";
  import Modelica.Constants.pi;
  extends OpenHPL.Icons.Generator;
  parameter Modelica.SIunits.MomentOfInertia Jg = 2e5 "Moment of inertia of the generator";
  parameter Modelica.SIunits.MomentOfInertia Jt = 2e5 "Moment of inertia of the turbine";
  parameter Modelica.Electrical.Machines.Losses.FrictionParameters Ploss(PRef=1000, wRef=para.f*4*pi/p)
                                                                         "Friction losses of generator and turbine combined";
  parameter Integer p = 12 "Number of poles";
  parameter Modelica.SIunits.AngularVelocity w_0 = para.f * 4 * pi / p "Initial angular velocity" annotation (
    Dialog(group = "Initialization"));
  parameter Boolean UseFrequencyOutput = true "If checked - get a connector for frequency output" annotation (
    choices(checkBox = true));

  Modelica.Blocks.Interfaces.RealInput Pload(unit="W") "Electrical load power demand" annotation (Placement(
      visible=true,
      transformation(extent={{-140,-20},{-100,20}}, rotation=0),
      iconTransformation(extent={{-120,-20},{-80,20}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput f=SI.Conversions.to_Hz(w*p/2) if UseFrequencyOutput "Output of generator frequency"
                                                                                             annotation (
    Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput Pturbine(unit="W") "Input of mechanical power from the turbine" annotation (Placement(visible=true, transformation(
        origin={3.55271e-15,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Modelica.Blocks.Interfaces.RealOutput w "Angular velocity of the generator"         annotation (
    Placement(visible = true, transformation(origin={110,60},    extent={{-10,-10},
            {10,10}},                                                                             rotation=0)));
  Modelica.Mechanics.Rotational.Components.Inertia turbineIntertia(J=Jt, w(start=w_0,fixed=true)) annotation (Placement(transformation(extent={{40,-10},{20,10}})));
  Modelica.Blocks.Math.Division loadPtoT annotation (Placement(transformation(extent={{-50,36},{-70,56}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,20})));
  Modelica.Mechanics.Rotational.Components.Inertia generatorInertia(J=Jg, w(start=w_0,fixed=true)) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Electrical.Machines.Losses.Friction friction(frictionParameters=Ploss) annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed annotation (Placement(transformation(extent={{-10,-42},{10,-22}})));
  Modelica.Mechanics.Rotational.Sources.Torque turbineTorque annotation (Placement(transformation(extent={{70,-10},{50,10}})));
  Modelica.Mechanics.Rotational.Sources.Torque generatorTorque annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Modelica.Blocks.Math.Division turbinePtoT annotation (Placement(transformation(extent={{40,36},{60,56}})));

  Modelica.Blocks.Math.Gain neg(k=-1) annotation (Placement(transformation(extent={{-66,64},{-54,76}})));
equation
  connect(friction.support, fixed.flange) annotation (Line(points={{0,-20},{0,-32}}, color={0,0,0}));
  connect(friction.flange, speedSensor.flange) annotation (Line(points={{0,0},{0,10},{-1.77636e-15,10}}, color={0,0,0}));
  connect(generatorInertia.flange_b, friction.flange) annotation (Line(points={{-20,0},{0,0}}, color={0,0,0}));
  connect(turbineIntertia.flange_b, friction.flange) annotation (Line(points={{20,0},{0,0}}, color={0,0,0}));
  connect(turbineIntertia.flange_a, turbineTorque.flange) annotation (Line(points={{40,0},{50,0}}, color={0,0,0}));
  connect(generatorInertia.flange_a, generatorTorque.flange) annotation (Line(points={{-40,0},{-50,0}}, color={0,0,0}));
  connect(speedSensor.w, loadPtoT.u2) annotation (Line(points={{0,31},{0,40},{-48,40}}, color={0,0,127}));
  connect(turbinePtoT.u2, loadPtoT.u2) annotation (Line(points={{38,40},{-48,40}}, color={0,0,127}));
  connect(Pturbine, turbinePtoT.u1) annotation (Line(points={{3.55271e-15,120},{3.55271e-15,54},{0,54},{0,52},{38,52}}, color={0,0,127}));
  connect(loadPtoT.y, generatorTorque.tau) annotation (Line(points={{-71,46},{-80,46},{-80,0},{-72,0}}, color={0,0,127}));
  connect(turbinePtoT.y, turbineTorque.tau) annotation (Line(points={{61,46},{80,46},{80,0},{72,0}}, color={0,0,127}));
  connect(w, loadPtoT.u2) annotation (Line(points={{110,60},{90,60},{90,20},{20,20},{20,40},{-48,40}}, color={0,0,127}));
  connect(loadPtoT.u1, neg.y) annotation (Line(points={{-48,52},{-40,52},{-40,70},{-53.4,70}}, color={0,0,127}));
  connect(neg.u, Pload) annotation (Line(points={{-67.2,70},{-90,70},{-90,0},{-120,0}}, color={0,0,127}));
  annotation (
    Documentation(info="<html><p>Simple model of an ideal generator with friction.</p>
<p>This model has inputs as electric power available on the grid and the turbine shaft power.
This model based on the angular momentum balance, which depends on the turbine shaft power,
 the friction loss in the aggregate rotation and the power taken up by the generator.</p>
<p align=\"center\">
<img src=\"modelica://OpenHPL/Resources/Images/simplegen.png\">
</p>
</html>"));
end SimpleGen2;
