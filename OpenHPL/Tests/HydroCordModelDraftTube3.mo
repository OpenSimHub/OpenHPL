within OpenHPL.Tests;
model HydroCordModelDraftTube3 "Model of HP system with simplified models for penstock, turbine, etc."
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(H_r=418.5 - 372, UseInFlow=false) annotation (Placement(visible=true, transformation(
        origin={-94,64},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe intake1(
    D_i=6.3,
    D_o=6.3,
    H=372 - 363,
    L=81.5,
    eps=0.1) annotation (Placement(visible=true, transformation(extent={{-80,50},{-60,70}}, rotation=0)));
  OpenHPL.Waterway.Pipe discharge1(
    D_i=6.3,
    D_o=6.3,
    H=17.5 - 14,
    L=601,
    eps=0.075) annotation (Placement(visible=true, transformation(extent={{60,-20},{80,0}}, rotation=0)));
  OpenHPL.Waterway.Reservoir tail(
    H_r=24.5 - 22.6,
    UseInFlow=false,
    Input_level=true) annotation (Placement(visible=true, transformation(
        origin={94,14},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.Pipe penstock1(
    D_i=4.7,
    D_o=4.7,
    H=356 - 123,
    L=363,
    eps=0.0005) annotation (Placement(visible=true, transformation(
        origin={8,50},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  OpenHPL.Waterway.SurgeTank surgeTank(
    D=3.4,
    H=431.5 - 356,
    L=87,
    eps=0.1,
    h_0=62.5) annotation (Placement(visible=true, transformation(
        origin={-4,66},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.ElectroMech.Turbines.Turbine turbine(C_v=6.5, ConstEfficiency=false) annotation (Placement(visible=true, transformation(
        origin={32,-6},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe intake2(
    D_i=6.3,
    D_o=6.3,
    H=363 - 365,
    L=395,
    eps=0.1) annotation (Placement(visible=true, transformation(
        origin={-48,66},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe intake3(
    D_i=6.3,
    D_o=6.3,
    H=365 - 356,
    L=4020,
    eps=0.5) annotation (Placement(visible=true, transformation(
        origin={-26,60},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Fitting fitting1(
    D_1=4.7,
    D_2=3.3,
    fit_type=OpenHPL.Functions.Fitting.FittingType.SquareReduction) annotation (Placement(visible=true, transformation(
        origin={14,30},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  OpenHPL.Waterway.Pipe penstock2(
    D_i=3.3,
    D_o=3.3,
    H=123 - 20.5 + 2.5,
    L=145,
    eps=0.0005) annotation (Placement(visible=true, transformation(
        origin={18,10},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  OpenHPL.Waterway.Pipe discharge2(
    D_i=6.3,
    D_o=6.3,
    H=14 - 22.6,
    L=21,
    eps=0.05) annotation (Placement(visible=true, transformation(
        origin={72,6},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.CombiTimeTable servo_pos(columns = {2}, fileName = "C:/Users/liubomyr/OneDrive/Documents/PhD/HydroCord/Servo_pos.txt", tableName = "position", tableOnFile = true) annotation (
    Placement(visible = true, transformation(origin = {86, 80}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable tail_level(columns = {2}, fileName = "C:/Users/liubomyr/OneDrive/Documents/PhD/HydroCord/Tail_level.txt", tableName = "level", tableOnFile = true) annotation (
    Placement(visible = true, transformation(origin = {48, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain per_gain(k = 1 / 100) annotation (
    Placement(visible = true, transformation(origin = {30, 80}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter1(limitsAtInit = true, uMax = 100, uMin = 0.001) annotation (
    Placement(visible = true, transformation(origin = {58, 80}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1(k2 = -1) annotation (
    Placement(visible = true, transformation(origin = {76, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const_level(k = 22.6) annotation (
    Placement(visible = true, transformation(origin = {26, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner OpenHPL.Constants Const(V_0 = 0.00040045) annotation (
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe draftTube(
    D_i=2.2,
    D_o=3.04,
    H=12,
    L=draftTube.H,
    eps=0.001) annotation (Placement(visible=true, transformation(extent={{38,-28},{58,-8}}, rotation=0)));
equation
  connect(const_level.y, add1.u2) annotation (
    Line(points = {{37, -50}, {64, -50}}, color = {0, 0, 127}));
  connect(add1.y, tail.Level_in) annotation (
    Line(points={{87,-44},{106,-44},{106,19}},     color = {0, 0, 127}));
  connect(tail_level.y[1], add1.u1) annotation (
    Line(points = {{59, -38}, {64, -38}}, color = {0, 0, 127}, thickness = 0.5));
  connect(discharge2.n, tail.n) annotation (
    Line(points = {{82, 6}, {82, 12.9}, {84, 12.9}, {84, 14}}, color = {28, 108, 200}));
  connect(discharge1.n, discharge2.p) annotation (
    Line(points = {{80, -10}, {80, -3}, {62, -3}, {62, 6}}, color = {28, 108, 200}));
  connect(draftTube.n, discharge1.p) annotation (
    Line(points = {{58, -18}, {58, -14}, {60, -14}, {60, -10}}, color = {28, 108, 200}));
  connect(turbine.n, draftTube.p) annotation (
    Line(points = {{42, -6}, {42, -12}, {38, -12}, {38, -18}}, color = {28, 108, 200}));
  connect(servo_pos.y[1], limiter1.u) annotation (
    Line(points = {{75, 80}, {70, 80}}, color = {0, 0, 127}, thickness = 0.5));
  connect(limiter1.y, per_gain.u) annotation (
    Line(points = {{47, 80}, {42, 80}}, color = {0, 0, 127}));
  connect(per_gain.y, turbine.u_t) annotation (
    Line(points={{19,80},{12,80},{12,60},{32,60},{32,6}},            color = {0, 0, 127}));
  connect(surgeTank.n, penstock1.p) annotation (
    Line(points = {{6, 66}, {8, 66}, {8, 60}}, color = {28, 108, 200}));
  connect(penstock1.n, fitting1.p) annotation (
    Line(points={{8,40},{11.9,40},{11.9,40},{14,40}},                color = {28, 108, 200}));
  connect(turbine.p, penstock2.n) annotation (
    Line(points = {{22, -6}, {22, 0}, {18, 0}}, color = {28, 108, 200}));
  connect(fitting1.n, penstock2.p) annotation (
    Line(points={{14,20},{17.9,20},{17.9,20},{18,20}},                      color = {28, 108, 200}));
  connect(intake3.n, surgeTank.p) annotation (
    Line(points={{-16,60},{-14,60},{-14,66}},        color = {28, 108, 200}));
  connect(intake2.n, intake3.p) annotation (
    Line(points={{-38,66},{-36,66},{-36,60}},        color = {28, 108, 200}));
  connect(intake1.n, intake2.p) annotation (
    Line(points={{-60,60},{-58,60},{-58,66}},        color = {28, 108, 200}));
  connect(reservoir.n, intake1.p) annotation (
    Line(points={{-84,64},{-79.95,64},{-79.95,60},{-80,60}},                color = {28, 108, 200}));
  annotation (
    experiment(StopTime = 3600, StartTime = 0, Tolerance = 0.0001, Interval = 1),
    Diagram(graphics={  Rectangle(origin = {17, 10}, extent = {{1, -2}, {-1, 2}})}));
end HydroCordModelDraftTube3;
