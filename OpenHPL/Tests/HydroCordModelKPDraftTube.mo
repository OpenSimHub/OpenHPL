within OpenHPL.Tests;
model HydroCordModelKPDraftTube "Model of HP system with simplified models for penstock, turbine, etc."
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(H_r=46.5, UseInFlow=false) annotation (Placement(visible=true, transformation(
        origin={-94,64},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = -0.05, offset = 0.9, startTime = 600) annotation (
    Placement(visible = true, transformation(origin = {16, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe intake1(
    D_i=6.3,
    D_o=6.3,
    H=9,
    L=81.5,
    eps=0.1) annotation (Placement(visible=true, transformation(extent={{-80,50},{-60,70}}, rotation=0)));
  OpenHPL.Waterway.Pipe discharge1(
    D_i=6.3,
    D_o=6.3,
    H=3.5,
    L=601,
    eps=0.075) annotation (Placement(visible=true, transformation(extent={{44,-24},{64,-4}}, rotation=0)));
  OpenHPL.Waterway.Reservoir tail(H_r=2, Input_level=true) annotation (Placement(visible=true, transformation(
        origin={94,0},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.SurgeTank surgeTank(
    D=3.4,
    H=75.5,
    L=87,
    eps=0.1,
    h_0=62.5) annotation (Placement(visible=true, transformation(
        origin={-4,66},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner OpenHPL.Parameters para(V_0=0.000400824, beta_total=1/997/1422^2) annotation (Placement(visible=true, transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.ElectroMech.Turbines.Turbine turbine(
    C_v=6.5,
    ConstEfficiency=false,
    WaterCompress=true) annotation (Placement(visible=true, transformation(
        origin={32,-6},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe intake2(
    D_i=6.3,
    D_o=6.3,
    H=-2,
    L=395,
    eps=0.1) annotation (Placement(visible=true, transformation(
        origin={-48,66},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe intake3(
    D_i=6.3,
    D_o=6.3,
    H=9,
    L=4020,
    eps=0.5) annotation (Placement(visible=true, transformation(
        origin={-26,60},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Fitting fitting1(D_1=4.7, D_2=3.3) annotation (Placement(visible=true, transformation(
        origin={10,26},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe discharge2(
    D_i=6.3,
    D_o=6.3,
    H=-8.5,
    L=21,
    eps=0.05) annotation (Placement(visible=true, transformation(
        origin={74,-8},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.PenstockKP penstock1(
    D_i=4.7,
    D_o=4.7,
    H=233,
    L=363,
    N=5,
    PipeElasticity=false,
    eps=0.0005,
    h_s0=62.5) annotation (Placement(visible=true, transformation(
        origin={18,52},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.PenstockKP penstock2(
    D_i=3.3,
    D_o=3.3,
    H=102.5 + 2.5,
    L=145,
    N=5,
    PipeElasticity=false,
    eps=0.0005,
    h_s0=62.5 + 233) annotation (Placement(visible=true, transformation(
        origin={8,4},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.CombiTimeTable servo_pos(columns = {2}, fileName = "C:/Users/liubomyr/OneDrive/Documents/PhD/HydroCord/Servo_pos.txt", tableName = "position", tableOnFile = true) annotation (
    Placement(visible = true, transformation(origin = {-86, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable tail_level(columns = {2}, fileName = "C:/Users/liubomyr/OneDrive/Documents/PhD/HydroCord/Tail_level.txt", tableName = "level", tableOnFile = true) annotation (
    Placement(visible = true, transformation(origin = {58, -64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain per_gain(k = 1 / 100) annotation (
    Placement(visible = true, transformation(origin = {-22, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter1(limitsAtInit = true, uMax = 100, uMin = 0.001) annotation (
    Placement(visible = true, transformation(origin = {-54, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1(k2 = -1) annotation (
    Placement(visible = true, transformation(origin = {90, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant const_level(k = 22.6) annotation (
    Placement(visible = true, transformation(origin = {58, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe draftTube(
    D_i=2.2,
    D_o=3.04,
    H=12,
    L=draftTube.H,
    eps=0.001) annotation (Placement(visible=true, transformation(extent={{44,0},{64,20}}, rotation=0)));
equation
  connect(draftTube.n, discharge1.p) annotation (
    Line(points = {{64, 10}, {64, 10}, {64, 0}, {44, 0}, {44, -14}, {44, -14}}, color = {28, 108, 200}));
  connect(turbine.n, draftTube.p) annotation (
    Line(points = {{42, -6}, {42, -6}, {42, 10}, {44, 10}}, color = {28, 108, 200}));
  connect(add1.y, tail.Level_in) annotation (
    Line(points={{90,-33},{90,-33},{90,5},{106,5}},             color = {0, 0, 127}));
  connect(const_level.y, add1.u2) annotation (
    Line(points={{69,-88},{96,-88},{96,-56},{96,-56}},          color = {0, 0, 127}));
  connect(tail_level.y[1], add1.u1) annotation (
    Line(points={{69,-64},{84,-64},{84,-56},{84,-56}},          color = {0, 0, 127}, thickness = 0.5));
  connect(per_gain.y, turbine.u_t) annotation (
    Line(points={{-11,-44},{40,-44},{40,14},{32,14},{32,6},{32,6}},              color = {0, 0, 127}));
  connect(limiter1.y, per_gain.u) annotation (
    Line(points={{-43,-42},{-40,-42},{-40,-44},{-34,-44},{-34,-44}},            color = {0, 0, 127}));
  connect(servo_pos.y[1], limiter1.u) annotation (
    Line(points={{-75,-40},{-68,-40},{-68,-42},{-66,-42}},          color = {0, 0, 127}, thickness = 0.5));
  connect(fitting1.n, penstock2.p) annotation (
    Line(points = {{20, 26}, {26, 26}, {26, 16}, {-10, 16}, {-10, 4}, {-2, 4}, {-2, 4}, {-2, 4}}, color = {28, 108, 200}));
  connect(penstock1.n, fitting1.p) annotation (
    Line(points = {{28, 52}, {30, 52}, {30, 40}, {-4, 40}, {-4, 26}, {0, 26}, {0, 26}}, color = {28, 108, 200}));
  connect(surgeTank.n, penstock1.p) annotation (
    Line(points = {{6, 66}, {8, 66}, {8, 52}, {8, 52}}, color = {28, 108, 200}));
  connect(penstock2.n, turbine.p) annotation (
    Line(points = {{18, 4}, {22, 4}, {22, -6}, {22, -6}}, color = {28, 108, 200}));
  connect(discharge2.n, tail.n) annotation (
    Line(points={{84,-8},{84,6.66134e-16}},
                                       color = {28, 108, 200}));
  connect(discharge1.n, discharge2.p) annotation (
    Line(points = {{64, -14}, {64, -14}, {64, -8}, {64, -8}}, color = {28, 108, 200}));
  connect(intake3.n, surgeTank.p) annotation (
    Line(points={{-16,60},{-14,60},{-14,66}},        color = {28, 108, 200}));
  connect(intake2.n, intake3.p) annotation (
    Line(points={{-38,66},{-36,66},{-36,60}},        color = {28, 108, 200}));
  connect(intake1.n, intake2.p) annotation (
    Line(points={{-60,60},{-58,60},{-58,66}},        color = {28, 108, 200}));
  connect(reservoir.n, intake1.p) annotation (
    Line(points={{-84,64},{-79.95,64},{-79.95,60},{-80,60}},                color = {28, 108, 200}));
  annotation (
    experiment(StopTime = 3600, StartTime = 0, Tolerance = 0.0001, Interval = 1.0));
end HydroCordModelKPDraftTube;
