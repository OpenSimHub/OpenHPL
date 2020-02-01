within OpenHPL.Examples;
model TorpaHPPAirCushionTest
  "Test case for air cushion surge tank from Torpa hydro power plant."
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(H_r=200)
                                               annotation (Placement(visible=true, transformation(
        origin={-90,30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = -0.04615, offset = 0.7493, startTime = 600) annotation (
    Placement(visible = true, transformation(origin={-10,70},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe intake(
    H=266.4,
    L=9350,
    D_i=6.56)                        annotation (Placement(visible=true, transformation(extent={{-70,20},{-50,40}}, rotation=0)));
  OpenHPL.Waterway.Pipe discharge(
    H=5,
    L=10000,
    D_i=6.56)                                   annotation (Placement(visible=true, transformation(extent={{50,-10},{70,10}}, rotation=0)));
  OpenHPL.Waterway.Reservoir tail(H_r=20,Input_level=false) annotation (Placement(visible=true, transformation(
        origin={90,0},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.Pipe penstock(
    D_i=6.56,
    D_o=6.56,
    H=8.6,
    L=250,
    vertical=true,
    p_eps=0.005)   annotation (Placement(visible=true, transformation(
        origin={0,30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.SurgeTank surgeTank(
    SurgeTankType=OpenHPL.Types.SurgeTank.STAirCushion,
    H=15,
    L=10,
    D=45,
    p_eps=0.005,
    h_0=2,
    p_ac=4100000,
    T_ac(displayUnit="K") = 287)                 annotation (Placement(visible=true, transformation(
        origin={-26,34},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Turbines.Turbine turbine(
    ValveCapacity=false,               C_v=3.7,
    H_n=430,
    Vdot_n=40,                                  ConstEfficiency=false) annotation (Placement(visible=true, transformation(
        origin={30,10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  connect(turbine.o, discharge.i) annotation (
    Line(points={{40,10},{44,10},{44,0},{50,0}},            color = {28, 108, 200}));
  connect(control.y, turbine.u_t) annotation (
    Line(points={{1,70},{30,70},{30,22}},         color = {0, 0, 127}));
  connect(penstock.o, turbine.i) annotation (
    Line(points={{10,30},{14.95,30},{14.95,10},{20,10}},                         color = {28, 108, 200}));
  connect(reservoir.o, intake.i) annotation (
    Line(points={{-80,30},{-70,30}},                                              color = {28, 108, 200}));
  connect(intake.o, surgeTank.i) annotation (
    Line(points={{-50,30},{-44,30},{-44,34},{-36,34}},                            color = {28, 108, 200}));
  connect(surgeTank.o, penstock.i) annotation (
    Line(points={{-16,34},{-14,34},{-14,30},{-10,30}},                            color = {28, 108, 200}));
  connect(discharge.o, tail.o) annotation (Line(points={{70,0},{80,0}}, color={28,108,200}));
  annotation (
    experiment(StopTime=500, Interval=1));
end TorpaHPPAirCushionTest;
