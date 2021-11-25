within OpenHPL.ElectroMech.Grid;
model MCB "Mechanical equivalent of an electrical Main Circuit Breaker"
  parameter SI.Time t_close = 100 "Time at which the MCB should close";
  parameter SI.Time t_open = 300 "Time at which the MCB should open";
  parameter SI.PerUnit deltaSpeed = 0.01 "Max allowed speed difference for closing the MCB";

  Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid(rising=0.01)
                                                                annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Blocks.Sources.Clock clock annotation (Placement(transformation(extent={{-92,-46},{-80,-34}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold closeMCB(threshold=t_close) annotation (Placement(transformation(extent={{-66,-34},{-54,-22}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold openMCB(threshold=t_open) annotation (Placement(transformation(extent={{-66,-58},{-54,-46}})));
  Modelica.Blocks.Logical.RSFlipFlop rSFlipFlop annotation (Placement(transformation(extent={{0,-56},{20,-36}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=deltaSpeed*2*C.pi*data.f_0)
                                                                                      annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={0,50})));
  Modelica.Blocks.Logical.And and1 annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Modelica.Mechanics.Rotational.Sensors.RelSpeedSensor relSpeedSensor annotation (Placement(transformation(extent={{60,40},{80,20}})));
  Modelica.Mechanics.Rotational.Components.Clutch clutch(fn_max=1e12)
                                                         annotation (Placement(transformation(extent={{60,10},{80,-10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a genFlange "Flange to be connected with the generator" annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b gridFlange "Flange to be connected with the grid" annotation (Placement(transformation(extent={{88,-10},{108,10}})));

  inner Data data annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation
  connect(clock.y, closeMCB.u) annotation (Line(points={{-79.4,-40},{-72,-40},{-72,-28},{-67.2,-28}},
                                                                                                  color={0,0,127}));
  connect(rSFlipFlop.R, openMCB.y) annotation (Line(points={{-2,-52},{-53.4,-52}},                            color={255,0,255}));
  connect(relSpeedSensor.flange_a, clutch.flange_a) annotation (Line(points={{60,30},{50,30},{50,0},{60,0}},   color={0,0,0}));
  connect(relSpeedSensor.flange_b, clutch.flange_b) annotation (Line(points={{80,30},{88,30},{88,0},{80,0}},   color={0,0,0}));
  connect(clutch.flange_a, genFlange) annotation (Line(points={{60,0},{-100,0}}, color={0,0,0}));
  connect(clutch.flange_b, gridFlange) annotation (Line(points={{80,0},{98,0}}, color={0,0,0}));
  connect(relSpeedSensor.w_rel, lessThreshold.u) annotation (Line(points={{70,41},{70,50},{12,50}},                       color={0,0,127}));
  connect(triggeredTrapezoid.y, clutch.f_normalized) annotation (Line(points={{61,-40},{70,-40},{70,-11}},
                                                                                                        color={0,0,127}));
  connect(clock.y, openMCB.u) annotation (Line(points={{-79.4,-40},{-72,-40},{-72,-52},{-67.2,-52}},
                                                                                                 color={0,0,127}));
  connect(rSFlipFlop.Q, triggeredTrapezoid.u) annotation (Line(points={{21,-40},{38,-40}}, color={255,0,255}));
  connect(and1.y, rSFlipFlop.S) annotation (Line(points={{-19,-20},{-10,-20},{-10,-40},{-2,-40}}, color={255,0,255}));
  connect(closeMCB.y, and1.u2) annotation (Line(points={{-53.4,-28},{-42,-28}}, color={255,0,255}));
  connect(lessThreshold.y, and1.u1) annotation (Line(points={{-11,50},{-50,50},{-50,-20},{-42,-20}}, color={255,0,255}));
  annotation (Icon(graphics={
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
        Polygon(
          points={{6,-20},{-14,-44},{1.375,-44},{-14,-62},{14,-38},{0,-38},{20,-20},{6,-20}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,0},{-40,0},{32,60}}, color={0,0,0}),
        Line(points={{38,0},{88,0}}),
        Text(
          lineColor={28,108,200},
          extent={{-100,-110},{100,-150}},
          textString="%name",
          textStyle={TextStyle.Bold}),
        Text(
          extent={{-90,30},{-50,8}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          textString="gen"),
        Text(
          extent={{50,32},{90,10}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          textString="grid")}));
end MCB;
