within OpenHPL.Examples;
model SimpleGen "Model of a hydropower system with a simple turbine turbine and generator"
  extends Simple(turbine(
      enable_nomSpeed=false,
      enable_P_out=true));
  ElectroMech.Generators.SimpleGen simpleGen annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Modelica.Blocks.Math.Gain loadLevel(k=1) annotation (Placement(transformation(extent={{72,70},{52,90}})));
equation
  connect(turbine.P_out,loadLevel. u) annotation (Line(points={{34,21},{34,30},{86,30},{86,80},{74,80}}, color={0,0,127}));
  connect(loadLevel.y,simpleGen. Pload) annotation (Line(points={{51,80},{30,80},{30,72}}, color={0,0,127}));
  connect(simpleGen.flange, turbine.flange) annotation (Line(
      points={{30,60},{30,10}},
      color={0,0,0}));
  annotation (experiment(StopTime=1000));
end SimpleGen;
