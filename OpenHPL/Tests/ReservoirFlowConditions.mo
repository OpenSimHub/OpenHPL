within OpenHPL.Tests;
model ReservoirFlowConditions

  OpenHPL.Waterway.Reservoir reservoir(
    H_r=10,
    UseInFlow=false,
    Input_level=true) annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  OpenHPL.Waterway.Reservoir reservoir1(H_r=10) annotation (Placement(transformation(extent={{40,0},{20,20}})));
  OpenHPL.Waterway.Pipe pipe(H=0) annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  inner OpenHPL.Data data annotation (Placement(transformation(extent={{-92,76},{-72,96}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=1,
    duration=1,
    offset=10,
    startTime=50) annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
equation
  connect(pipe.o, reservoir1.o) annotation (Line(points={{0,10},{20,10}}, color={0,128,255}));
  connect(reservoir.o, pipe.i) annotation (Line(points={{-40,10},{-20,10}}, color={0,128,255}));
  connect(ramp.y, reservoir.Level_in) annotation (Line(points={{-79,10},{-72,10},{-72,15},{-62,15}}, color={0,0,127}));
  annotation (experiment(StopTime=100));
end ReservoirFlowConditions;
