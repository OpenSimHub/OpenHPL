within OpenHPL.Tests;
model HydroCordModelFrancisDraftTube "Model of HP system with simplified models for penstock, turbine, etc."
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(h_0=46.5, UseInFlow=false) annotation (Placement(visible=true, transformation(
        origin={-94,64},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = -0.05, offset = 0.00001, startTime = 6000) annotation (
    Placement(visible = true, transformation(origin = {16, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe intake1(
    D_i=6.3,
    D_o=6.3,
    H=9,
    L=81.5,
    p_eps=0.1) annotation (Placement(visible=true, transformation(extent={{-80,50},{-60,70}}, rotation=0)));
  OpenHPL.Waterway.Pipe discharge1(
    D_i=6.3,
    D_o=6.3,
    H=3.5,
    L=601,
    p_eps=0.075) annotation (Placement(visible=true, transformation(extent={{44,-24},{64,-4}}, rotation=0)));
  OpenHPL.Waterway.Reservoir tail(h_0=2, Input_level=true) annotation (Placement(visible=true, transformation(
        origin={94,0},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.Pipe penstock1(
    D_i=4.7,
    D_o=4.7,
    H=233,
    L=363,
    p_eps=0.0005) annotation (Placement(visible=true, transformation(
        origin={10,50},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  OpenHPL.Waterway.SurgeTank surgeTank(
    D=3.4,
    H=75.5,
    L=87,
    h_0=62.5,
    p_eps=0.1) annotation (Placement(visible=true, transformation(
        origin={-4,66},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner OpenHPL.Data data(Vdot_0=0.0058466) annotation (Placement(visible=true, transformation(
        origin={-86,92},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe intake2(
    D_i=6.3,
    D_o=6.3,
    H=-2,
    L=395,
    p_eps=0.1) annotation (Placement(visible=true, transformation(
        origin={-48,66},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe intake3(
    D_i=6.3,
    D_o=6.3,
    H=9,
    L=4020,
    p_eps=0.5) annotation (Placement(visible=true, transformation(
        origin={-26,60},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Fitting fitting1(D_1=4.7, D_2=3.3) annotation (Placement(visible=true, transformation(
        origin={14,30},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  OpenHPL.Waterway.Pipe penstock2(
    D_i=3.3,
    D_o=3.3,
    H=102.5 + 2.5,
    L=145,
    p_eps=0.0005) annotation (Placement(visible=true, transformation(
        origin={18,10},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  OpenHPL.Waterway.Pipe discharge2(
    D_i=6.3,
    D_o=6.3,
    H=-8.5,
    L=21,
    p_eps=0.05) annotation (Placement(visible=true, transformation(
        origin={74,-8},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.ElectroMech.Turbines.Francis Francis(
    GivenData=false,
    GivenServoData=false,
    Given_losses=true,
    H_n=371,
    P_n=130,
    R_Y_=3.2,
    Vdot_n=37,
    k_ft1_=2e5,
    k_ft2_=1e2,
    k_ft3_=8e3,
    k_ft4=1.2e6,
    n_n=375,
    r_Y_=1.4,
    r_v_=1.3,
    u_end_=2.44,
    u_start_=2.28832) annotation (Placement(visible=true, transformation(
        origin={32,0},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Constant const1(k = 375 * Modelica.Constants.pi / 30) annotation (
    Placement(visible = true, transformation(origin = {56, -34}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable servo_pos(columns = {2}, fileName = "C:/Users/liubomyr/OneDrive/Documents/PhD/HydroCord/Servo_pos.txt", tableName = "position", tableOnFile = true) annotation (
    Placement(visible = true, transformation(origin = {-82, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable rotation(columns = {2}, fileName = "C:/Users/liubomyr/OneDrive/Documents/PhD/HydroCord/Rotation.txt", tableName = "rotation", tableOnFile = true) annotation (
    Placement(visible = true, transformation(origin = {-80, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable tail_level(columns = {2}, fileName = "C:/Users/liubomyr/OneDrive/Documents/PhD/HydroCord/Tail_level.txt", tableName = "level", tableOnFile = true) annotation (
    Placement(visible = true, transformation(origin = {58, -64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain rot_gain(k = Modelica.Constants.pi / 30) annotation (
    Placement(visible = true, transformation(origin = {-46, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain per_gain(k = 1 / 100) annotation (
    Placement(visible = true, transformation(origin = {-18, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=100, uMin=0.01) annotation (Placement(visible=true, transformation(
        origin={-50,-70},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Math.Add add1(k2 = -1) annotation (
    Placement(visible = true, transformation(origin = {90, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant const_level(k = 22.6) annotation (
    Placement(visible = true, transformation(origin = {58, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe draftTube(
    D_i=2.2,
    D_o=3.04,
    H=12,
    L=draftTube.H,
    p_eps=0.001) annotation (Placement(visible=true, transformation(extent={{44,4},{64,24}}, rotation=0)));
equation
  connect(penstock2.n, Francis.p) annotation (
    Line(points = {{18, 0}, {22, 0}}, color = {28, 108, 200}));
  connect(rot_gain.y, Francis.w_in) annotation (
    Line(points={{-35,-42},{20,-42},{20,-8}},         color = {0, 0, 127}));
  connect(per_gain.y, Francis.u_t) annotation (
    Line(points={{-7,-72},{38,-72},{38,14},{32,14},{32,12}},            color = {0, 0, 127}));
  connect(Francis.n, draftTube.p) annotation (
    Line(points = {{42, 0}, {42, 14}, {44, 14}}, color = {28, 108, 200}));
  connect(draftTube.n, discharge1.p) annotation (
    Line(points = {{64, 14}, {64, 14}, {64, 0}, {44, 0}, {44, -14}, {44, -14}, {44, -14}}, color = {28, 108, 200}));
  connect(add1.y, tail.level) annotation (Line(points={{90,-33},{88,-33},{88,5},{106,5}}, color={0,0,127}));
  connect(rotation.y[1], rot_gain.u) annotation (
    Line(points = {{-69, -44}, {-63, -44}, {-63, -42}, {-58, -42}}, color = {0, 0, 127}, thickness = 0.5));
  connect(const_level.y, add1.u2) annotation (
    Line(points={{69,-88},{96,-88},{96,-56},{96,-56}},          color = {0, 0, 127}));
  connect(tail_level.y[1], add1.u1) annotation (
    Line(points={{69,-64},{84,-64},{84,-56},{84,-56}},          color = {0, 0, 127}, thickness = 0.5));
  connect(servo_pos.y[1], limiter1.u) annotation (
    Line(points={{-71,-68},{-69,-68},{-69,-68},{-67,-68},{-67,-70},{-61,-70},{-61,-71},{-62,-71},{-62,-70}},                    color = {0, 0, 127}, thickness = 0.5));
  connect(limiter1.y, per_gain.u) annotation (
    Line(points={{-39,-70},{-35,-70},{-35,-72},{-29,-72},{-29,-72},{-30,-72},{-30,-72}},                color = {0, 0, 127}));
  connect(discharge2.n, tail.n) annotation (
    Line(points={{84,-8},{84,6.66134e-16}},
                                       color = {28, 108, 200}));
  connect(discharge1.n, discharge2.p) annotation (
    Line(points = {{64, -14}, {64, -14}, {64, -8}, {64, -8}}, color = {28, 108, 200}));
  connect(fitting1.n, penstock2.p) annotation (
    Line(points={{14,20},{17.9,20},{17.9,20},{18,20}},                      color = {28, 108, 200}));
  connect(penstock1.n, fitting1.p) annotation (
    Line(points={{10,40},{13.9,40},{13.9,40},{14,40}},                     color = {28, 108, 200}));
  connect(surgeTank.n, penstock1.p) annotation (
    Line(points = {{6, 66}, {10, 66}, {10, 60}}, color = {28, 108, 200}));
  connect(intake3.n, surgeTank.p) annotation (
    Line(points={{-16,60},{-14,60},{-14,66}},        color = {28, 108, 200}));
  connect(intake2.n, intake3.p) annotation (
    Line(points={{-38,66},{-36,66},{-36,60}},        color = {28, 108, 200}));
  connect(intake1.n, intake2.p) annotation (
    Line(points={{-60,60},{-58,60},{-58,66}},        color = {28, 108, 200}));
  connect(reservoir.n, intake1.p) annotation (
    Line(points={{-84,64},{-79.95,64},{-79.95,60},{-80,60}},                color = {28, 108, 200}));
  annotation (
    experiment(StopTime = 3600, StartTime = 0, Tolerance = 0.0001, Interval = 1));
end HydroCordModelFrancisDraftTube;
