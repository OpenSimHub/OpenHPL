within OpenHPL.Examples;
model Grid "Example to demonstrate the influence of lambda and mu"
  extends Modelica.Icons.Example;
  OpenHPL.ElectroMech.PowerSystem.Grid grid(
    Pgrid(displayUnit="MW") = 400000000,
    useLambda=true,
    Lambda=266.6e6,
    J=1e6,
    enable_f=true)                          annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.Step loadStep(
    height=133.3e6,
    offset=100e6,
    startTime=10) annotation (Placement(transformation(extent={{0,20},{20,40}})));
  OpenHPL.ElectroMech.Generators.SimpleGen simpleGen(Pmax(displayUnit="MW") = 110000000)
                                                     annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Sources.Constant PowerInput(k=-100e6)
                                                       annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  inner Data data annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation
  connect(loadStep.y, grid.Pload) annotation (Line(points={{21,30},{30,30},{30,12}}, color={0,0,127}));
  connect(simpleGen.flange, grid.flange) annotation (Line(points={{-30,0},{30,0}}, color={0,0,0}));
  connect(PowerInput.y, simpleGen.Pload) annotation (Line(points={{-39,30},{-30,30},{-30,12}}, color={0,0,127}));
  annotation (                                experiment(StopTime=20, __Dymola_NumberOfIntervals=5000), Documentation(info="<html>
<h4>Example 5.8 [Schavemaker 2008]</h4>
<p>
The given grid has a bias factor of &lambda;=266.6&nbsp;MW/Hz.
The <code>simpleGen</code> is generating 100&nbsp;MW in order to supply the the
internal grid load of 100&nbsp;MW. The system is in balance.
</p>
<p>
At <code>t=10s</code> the grid loses 133.3 MW of production
(see <code>loadStep</code> parameters>) and now two different cases can be investigated:
</p>
<h5>No self-regulation</h5>
<p>
When simulating the system with the setting of <code>grid.mu=0</code> one should expect
the frequency difference &Delta;F (see <code>grid.dF.y</code>) to settle down at
&Delta;f = -0.5 Hz.
</p>
<h5>With self-regulation</h5>
<p>
Changing the setting of the self-regulation to <code>grid.mu=2</code> should now
result in a frequency difference &Delta;f (see <code>grid.dF.y</code>) that settles down at
a slighly lower &Delta;f &asymp; -0.496 Hz.
</p>
<p>
Note: When doing the calculation based by hand and calculating the new &lambda; which includes
the effect of self-regulation based on &Delta;f = -0.5 Hz one will get a smaller expected &Delta;f
than the simulation shows. Can you think why?
</p>
</html>"));
end Grid;
