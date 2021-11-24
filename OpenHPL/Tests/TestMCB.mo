within OpenHPL.Tests;
model TestMCB "Testing the operation of the MCB"
  extends Modelica.Icons.Example;
  ElectroMech.Generators.MCB mCB(deltaSpeed=0.01) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Rotational.Components.Inertia grid(J=1e6) annotation (Placement(transformation(extent={{22,-10},{42,10}})));
  inner Data data annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Mechanics.Rotational.Components.Inertia gen(J=1e3, w(start=0.9*2*C.pi*data.f_0, fixed=true)) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStep(
    stepTorque=10e6,
    offsetTorque=0,
    startTime=110) annotation (Placement(transformation(extent={{-72,-12},{-52,8}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed(displayUnit="Hz") = 2*C.pi*data.f_0) annotation (Placement(transformation(extent={{74,-10},{54,10}})));
equation
  connect(mCB.gridFlange, grid.flange_a) annotation (Line(points={{9.8,0},{22,0}}, color={0,0,0}));
  connect(constantSpeed.flange, grid.flange_b) annotation (Line(points={{54,0},{42,0}}, color={0,0,0}));
  connect(gen.flange_b, mCB.genFlange) annotation (Line(points={{-20,0},{-10,0}}, color={0,0,0}));
  connect(torqueStep.flange, gen.flange_a) annotation (Line(points={{-52,-2},{-46,-2},{-46,0},{-40,0}}, color={0,0,0}));
  annotation (experiment(StopTime=400));
end TestMCB;
