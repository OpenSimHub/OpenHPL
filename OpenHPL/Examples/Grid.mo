within OpenHPL.Examples;
model Grid "Example to demonstrate the influence of lambda and mu"
  extends Modelica.Icons.Example;
  OpenHPL.ElectroMech.PowerSystem.Grid grid(
    Pgrid(displayUnit="MW") = 400000000,
    useLambda=true,
    Lambda=266.6e6,
    mu=0,
    enable_f=true)                          annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.Step loadStep(
    height=133.3e6,
    offset=100e6,
    startTime=10) annotation (Placement(transformation(extent={{0,20},{20,40}})));
  OpenHPL.ElectroMech.Generators.SimpleGen simpleGen annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Sources.Constant PowerInput(k=0)     annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
equation
  connect(loadStep.y, grid.Pload) annotation (Line(points={{21,30},{30,30},{30,12}}, color={0,0,127}));
  connect(simpleGen.flange, grid.flange) annotation (Line(points={{-30,0},{30,0}}, color={0,0,0}));
  connect(PowerInput.y, simpleGen.Pload) annotation (Line(points={{-39,30},{-30,30},{-30,12}}, color={0,0,127}));
  annotation (                                experiment(StopTime=20, __Dymola_NumberOfIntervals=5000), Documentation(info="<html>
<h4>Example 5.8 [Schavemaker 2008]</h4>

 
</html>"));
end Grid;
