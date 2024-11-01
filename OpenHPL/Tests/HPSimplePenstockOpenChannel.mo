within OpenHPL.Tests;
model HPSimplePenstockOpenChannel "testing open channel"
  extends Modelica.Icons.Example;
  Waterway.Reservoir reservoir annotation (Placement(transformation(
        origin={-90,44},
        extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = -0.04615, offset = 0.7493,
    startTime=60000) annotation (
    Placement(transformation(origin={-38,86}, extent = {{-10, -10}, {10, 10}})));
  Waterway.Pipe discharge( L=600, H=-5)
                                      annotation (Placement(transformation(extent={{6,0},{
            26,20}})));
  Waterway.Reservoir tail(h_0=5) annotation (Placement(transformation(
        origin={90,10},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Waterway.Pipe penstock(
    D_i=3.3,
    D_o=3.3,
    H=420,
    L=600) annotation (Placement(transformation(
        origin={-30,26},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  ElectroMech.Turbines.Turbine turbine(C_v=3.7) annotation (Placement(transformation(
        origin={-12,14},
        extent={{-10,-10},{10,10}})));
  inner OpenHPL.Data data(Vdot_0=18.9979) annotation (Placement(transformation(
        origin={-90,92},
        extent={{-10,-10},{10,10}})));
  Waterway.Pipe pipe annotation (Placement(transformation(extent={{-74,34},
            {-54,54}})));
  Waterway.OpenChannel openChannel(
    N=100,
    W=50,
    h_0=vector([ones(68)*0.30417; 0.3045; 0.3089; 0.33; 0.398; linspace(
        0.519,
        5.00164,
        28)])) annotation (Placement(transformation(extent={{30,2},{50,22}})));
  Waterway.Pipe pipe1(H=0, L=10)
                                annotation (Placement(transformation(extent={{54,-2},
            {74,18}})));
  Waterway.SurgeTank surgeTank(h_0=73.9171)
    annotation (Placement(transformation(extent={{-52,38},{-32,58}})));
equation
  connect(turbine.p, penstock.n) annotation (
    Line(points={{-22,14},{-30,14},{-30,16}}));
  connect(control.y, turbine.u_t) annotation (
    Line(points={{-27,86},{-12,86},{-12,26}}, color = {0, 0, 127}));
  connect(reservoir.n, pipe.p) annotation (
    Line(points={{-80,44},{-74,44}}, color = {28, 108, 200}));
  connect(turbine.n, discharge.p)
    annotation (Line(points={{-2,14},{6,14},{6,10}}, color={28,108,200}));
  connect(discharge.n, openChannel.p)
    annotation (Line(points={{26,10},{28,10},{28,12},{30,12}},
                                               color={28,108,200}));
  connect(openChannel.n, pipe1.p) annotation (Line(points={{50,12},{52,12},{52,
          8},{54,8}},
                    color={28,108,200}));
  connect(tail.n, pipe1.n) annotation (Line(points={{80,10},{78,10},{78,8},{74,
          8}}, color={28,108,200}));
  connect(pipe.n, surgeTank.p)
    annotation (Line(points={{-54,44},{-54,48},{-52,48}}, color={28,108,200}));
  connect(penstock.p, surgeTank.n)
    annotation (Line(points={{-30,36},{-32,36},{-32,48}}, color={28,108,200}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPSimplePenstockOpenChannel;
