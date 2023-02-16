within OpenHPL.Tests;
model OpenChannel "Model of a hydropower system with open channel model"
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(h_0=5) annotation (Placement(transformation(
        origin={-70,0},
        extent={{-10,-10},{10,10}})));
  OpenHPL.Waterway.Pipe discharge(H=0, L=10) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  OpenHPL.Waterway.Reservoir tail(h_0=5) annotation (Placement(transformation(
        origin={70,0},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  inner OpenHPL.Data data(
    SteadyState=false,
    Vdot_0=0,
    f_0(displayUnit="Hz"), TempUse=false)
                          annotation (Placement(transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}})));
  Waterway.OpenChannel openChannel(N=10, H={0,0})
               annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Waterway.Pipe pipe(H=0, L=10) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation
  connect(discharge.o, openChannel.i) annotation (Line(points={{-20,0},{-10,0}}, color={0,128,255}));
  connect(openChannel.o, pipe.i) annotation (Line(points={{10,0},{20,0}}, color={0,128,255}));
  connect(reservoir.o, discharge.i) annotation (Line(points={{-60,0},{-40,0}}, color={0,128,255}));
  connect(pipe.o, tail.o) annotation (Line(points={{40,0},{60,0}}, color={0,128,255}));
  annotation (experiment(StopTime=1000));
end OpenChannel;
