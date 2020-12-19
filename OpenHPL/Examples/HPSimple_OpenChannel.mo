within OpenHPL.Examples;
model HPSimple_OpenChannel "Example with the open channel"
  extends Modelica.Icons.Example;
  Waterway.Reservoir reservoir annotation (Placement(visible=true, transformation(
        origin={-90,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = -0.04615, offset = 0.7493,
    startTime=600)                                                                                        annotation (
    Placement(visible = true, transformation(origin={-90,-30},  extent={{-10,-10},{10,10}},      rotation = 0)));
  Waterway.Pipe discharge(     L=600, H=-5)
                                      annotation (Placement(visible=true, transformation(extent={{-40,-10},{-20,10}},
                                                                                                                   rotation=0)));
  Waterway.Reservoir tail(H_r=5)  annotation (Placement(visible=true, transformation(
        origin={90,0},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Waterway.Pipe penstock(
    vertical=true,
    D_i=3.3,
    D_o=3.3,
    H=420,
    L=600) annotation (Placement(visible=true, transformation(
        origin={0,40},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ElectroMech.Turbines.Turbine2 turbine(C_v=3.7) annotation (Placement(visible=true, transformation(
        origin={-60,0},
        extent={{-10,10},{10,-10}},
        rotation=0)));
  inner OpenHPL.Data data(V_0=18.9979) annotation (Placement(visible=true, transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.Pipe pipe            annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
  Waterway.OpenChannel openChannel(
    N=100,
    w=50,
    h0=vector([ones(68)*0.30417; 0.3045; 0.3089; 0.33; 0.398; linspace(
        0.519,
        5.00164,
        28)]))                                  annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Waterway.SurgeTank surgeTank(h_0=73.9171)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Waterway.Pipe pipe1(H=0, L=10)
                                annotation (Placement(transformation(extent={{40,-10},{60,10}})));
equation
  connect(reservoir.o, pipe.i) annotation (Line(points={{-80,50},{-70,50}}, color={28,108,200}));
  connect(pipe.o, surgeTank.i) annotation (Line(points={{-50,50},{-40,50}}, color={28,108,200}));
  connect(surgeTank.o, penstock.o) annotation (Line(points={{-20,50},{-16,50},{-16,40},{-10,40}}, color={28,108,200}));
  connect(discharge.o, openChannel.i) annotation (Line(points={{-20,0},{0,0}}, color={28,108,200}));
  connect(openChannel.o, pipe1.i) annotation (Line(points={{20,0},{40,0}}, color={28,108,200}));
  connect(turbine.o, discharge.i) annotation (Line(points={{-50,0},{-40,0}}, color={28,108,200}));
  connect(pipe1.o, tail.o) annotation (Line(points={{60,0},{70,0},{70,7.21645e-16},{80,7.21645e-16}}, color={28,108,200}));
  connect(penstock.i, turbine.i) annotation (Line(points={{10,40},{18,40},{18,20},{-80,20},{-80,0},{-70,0}}, color={28,108,200}));
  connect(control.y, turbine.u_t) annotation (Line(points={{-79,-30},{-68,-30},{-68,-12}}, color={0,0,127}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPSimple_OpenChannel;
