within OpenHPL.Tests;
model VolumeFlowSource
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir tail1(h_0=10) annotation (Placement(transformation(extent={{60,30},{40,50}})));
  inner OpenHPL.Data data annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=volumeFlowSource1.o.mdot) annotation (Placement(transformation(extent={{28,-66},{48,-46}})));
  Modelica.Blocks.Continuous.Integrator integrator annotation (Placement(transformation(extent={{58,-66},{78,-46}})));
  OpenHPL.Waterway.VolumeFlowSource volumeFlowSource1 annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
  Waterway.Pipe pipe1(H=0) annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Waterway.Pipe pipe2(H=0) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  OpenHPL.Waterway.Reservoir tail2(h_0=100)
                                           annotation (Placement(transformation(extent={{60,-10},{40,10}})));
  OpenHPL.Waterway.VolumeFlowSource volumeFlowSource2(useInput=true) annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
  Modelica.Blocks.Sources.Sine sine(amplitude=100, freqHz=0.001) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(realExpression.y, integrator.u) annotation (Line(points={{49,-56},{56,-56}}, color={0,0,127}));
  connect(pipe1.o, tail1.o) annotation (Line(points={{10,40},{40,40}}, color={0,128,255}));
  connect(volumeFlowSource1.o, pipe1.i) annotation (Line(points={{-30,40},{-10,40}}, color={0,128,255}));
  connect(volumeFlowSource2.o, pipe2.i) annotation (Line(points={{-28,0},{-10,0}}, color={0,128,255}));
  connect(pipe2.o, tail2.o) annotation (Line(points={{10,0},{40,0}}, color={0,128,255}));
  connect(sine.y, volumeFlowSource2.outFlow) annotation (Line(points={{-59,0},{-50,0}}, color={0,0,127}));
  annotation (experiment(StopTime=1000, __Dymola_NumberOfIntervals=50000));
end VolumeFlowSource;
