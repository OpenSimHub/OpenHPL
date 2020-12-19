within OpenHPL.Examples;
model HPDetailed "Model of waterway of the HP system with detailed model for the penstock (using KP scheme) and simplified models for others conduits, turbine, etc."
  extends Modelica.Icons.Example;
  Waterway.Reservoir reservoir(H_r=48) annotation (Placement(visible=true, transformation(
        origin={-90,10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = -0.04615, offset = 0.7493, startTime = 600) annotation (
    Placement(visible = true, transformation(origin={0,50},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner OpenHPL.Data data(V_0=19.12, rho(displayUnit="kg/m3") = 997) annotation (Placement(visible=true, transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.Pipe intake(H=23) annotation (Placement(visible=true, transformation(extent={{-70,0},{-50,20}},  rotation=0)));
  Waterway.Pipe discharge(H=0.5, L=600) annotation (Placement(visible=true, transformation(extent={{50,-10},{70,10}},rotation=0)));
  Waterway.Reservoir tail(H_r=5) annotation (Placement(visible=true, transformation(
        origin={90,0},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  ElectroMech.Turbines.Turbine turbine(
    C_v=3.7,
    ConstEfficiency=false,
    WaterCompress=true) annotation (Placement(visible=true, transformation(extent={{20,-10},{40,10}}, rotation=0)));
  Waterway.SurgeTank surgeTank(h_0=69.9) annotation (Placement(visible=true, transformation(extent={{-40,0},{-20,20}},  rotation=0)));
  Waterway.PenstockKP penstockKP(
    D_i=3,
    D_o=3,
    H=428.5,
    PipeElasticity=false,
    h_s0=69.9,
    vertical=true) annotation (Placement(transformation(extent={{-10,0},{10,20}})));
equation
  connect(discharge.o, tail.o) annotation (
    Line(points={{70,0},{80,0}},                                        color = {28, 108, 200}));
  connect(turbine.o, discharge.i) annotation (Line(points={{40,0},{50,0}}, color={28,108,200}));
  connect(turbine.i, penstockKP.o) annotation (Line(points={{20,0},{14,0},{14,10},{10,10}}, color={28,108,200}));
  connect(surgeTank.o, penstockKP.i) annotation (
    Line(points={{-20,10},{-10,10}},                             color = {28, 108, 200}));
  connect(intake.o, surgeTank.i) annotation (
    Line(points={{-50,10},{-40,10}},                                        color = {28, 108, 200}));
  connect(reservoir.o, intake.i) annotation (
    Line(points={{-80,10},{-70,10}},                                        color = {28, 108, 200}));
  connect(turbine.u_t, control.y) annotation (Line(points={{22,12},{22,50},{11,50}}, color={0,0,127}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPDetailed;
