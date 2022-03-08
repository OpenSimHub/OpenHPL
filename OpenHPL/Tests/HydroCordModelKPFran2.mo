within OpenHPL.Tests;
model HydroCordModelKPFran2 "Model of HP system with simplified models for penstock, turbine, etc."
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(h_0=46.5, UseInFlow=false) annotation (Placement(visible=true, transformation(
        origin={-94,64},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = -0.05, offset = 0.9, startTime = 600) annotation (
    Placement(visible = true, transformation(origin = {16, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe intake1(
    D_i=6.3,
    D_o=6.3,
    H=9,
    L=81.5) annotation (Placement(visible=true, transformation(extent={{-80,50},{-60,70}}, rotation=0)));
  OpenHPL.Waterway.Pipe discharge1(
    D_i=6.3,
    D_o=6.3,
    H=3.5,
    L=601) annotation (Placement(visible=true, transformation(extent={{44,-24},{64,-4}}, rotation=0)));
  OpenHPL.Waterway.Reservoir tail(h_0=2, Input_level=true) annotation (Placement(visible=true, transformation(
        origin={94,0},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.SurgeTank surgeTank(
    D=3.4,
    H=75.5,
    L=87,
    h_0=62.4945) annotation (Placement(visible=true, transformation(
        origin={-4,66},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner OpenHPL.Data data(Vdot_0=2.044) annotation (Placement(visible=true, transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe intake2(
    D_i=6.3,
    D_o=6.3,
    H=-2,
    L=395) annotation (Placement(visible=true, transformation(
        origin={-48,66},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe intake3(
    D_i=6.3,
    D_o=6.3,
    H=9,
    L=4020) annotation (Placement(visible=true, transformation(
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
    L=21) annotation (Placement(visible=true, transformation(
        origin={74,-8},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.PenstockKP penstockKP1(
    D_i=4.7,
    D_o=4.7,
    H=233,
    L=363,
    N=5,
    PipeElasticity=false,
    h_s0=62.4945) annotation (Placement(visible=true, transformation(
        origin={18,52},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.PenstockKP penstockKP2(
    D_i=3.3,
    D_o=3.3,
    H=102.5 + 2.5,
    L=145,
    N=5,
    PipeElasticity=false,
    h_s0=62.4945 + 233) annotation (Placement(visible=true, transformation(
        origin={8,4},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.CombiTimeTable servo_pos(columns = {2}, fileName = "C:/Users/liubomyr/OneDrive/Documents/PhD/HydroCord/Servo_pos_short.txt", tableName = "position", tableOnFile = true) annotation (
    Placement(visible = true, transformation(origin = {-84, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable tail_level(columns = {2}, fileName = "C:/Users/liubomyr/OneDrive/Documents/PhD/HydroCord/Tail_level_short.txt", tableName = "level", tableOnFile = true) annotation (
    Placement(visible = true, transformation(origin = {58, -64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable rotation(columns = {2}, fileName = "C:/Users/liubomyr/OneDrive/Documents/PhD/HydroCord/Rotation_short.txt", tableName = "rotation", tableOnFile = true) annotation (
    Placement(visible = true, transformation(origin = {-84, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain rot_gain(k = Modelica.Constants.pi / 30) annotation (
    Placement(visible = true, transformation(origin = {-50, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain per_gain(k = 1 / 100) annotation (
    Placement(visible = true, transformation(origin = {-20, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter1(limitsAtInit = true, uMax = 100, uMin = 0.01) annotation (
    Placement(visible = true, transformation(origin = {-52, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1(k2 = -1) annotation (
    Placement(visible = true, transformation(origin = {90, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant const_level(k = 22.6) annotation (
    Placement(visible = true, transformation(origin = {58, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.ElectroMech.Turbines.Francis francis1(
    GivenData=false,
    GivenServoData=false,
    H_n=371,
    P_n=130,
    R_Y_=3.2,
    Vdot_n=37,
    WaterCompress=true,
    k_ft1_=2e5,
    k_ft2_=1e2,
    k_ft3_=8e3,
    k_ft4=1.1e6,
    n_n=375,
    r_Y_=1.4,
    r_v_=1.3,
    u_end_=2.44,
    u_start_=2.28832) annotation (Placement(visible=true, transformation(
        origin={30,-4},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  //francis1.u_t = 4.54929515955115/100;
  //francis1.w_in = 375.12178419695*Modelica.Constants.pi/30;
  //tail.Level_in = 24.65206211-22.6;
  connect(per_gain.y, francis1.u_t) annotation (
    Line(points={{-9,-70},{40,-70},{40,14},{30,14},{30,8},{30,8}},              color = {0, 0, 127}));
  connect(rotation.y[1], rot_gain.u) annotation (
    Line(points={{-73,-38},{-68,-38},{-68,-36},{-62,-36},{-62,-36}},            color = {0, 0, 127}, thickness = 0.5));
  connect(rot_gain.y, francis1.w_in) annotation (
    Line(points={{-39,-36},{4,-36},{4,-12},{18,-12}},            color = {0, 0, 127}));
  connect(servo_pos.y[1], limiter1.u) annotation (
    Line(points={{-73,-66},{-67,-66},{-67,-68},{-64,-68}},          color = {0, 0, 127}, thickness = 0.5));
  connect(limiter1.y, per_gain.u) annotation (
    Line(points={{-41,-68},{-40,-68},{-40,-68},{-39,-68},{-39,-70},{-33,-70},
          {-33,-73},{-33,-70},{-32,-70}},                                                                                       color = {0, 0, 127}));
  connect(francis1.n, discharge1.p) annotation (
    Line(points = {{40, -4}, {44, -4}, {44, -14}, {44, -14}}, color = {28, 108, 200}));
  connect(penstockKP2.n, francis1.p) annotation (
    Line(points = {{18, 4}, {20, 4}, {20, -4}, {20, -4}}, color = {28, 108, 200}));
  connect(add1.y, tail.level) annotation (Line(points={{90,-33},{90,-33},{90,5},{106,5}}, color={0,0,127}));
  connect(const_level.y, add1.u2) annotation (
    Line(points={{69,-88},{96,-88},{96,-56},{96,-56}},          color = {0, 0, 127}));
  connect(tail_level.y[1], add1.u1) annotation (
    Line(points={{69,-64},{84,-64},{84,-56},{84,-56}},          color = {0, 0, 127}, thickness = 0.5));
  connect(fitting1.n, penstockKP2.p) annotation (
    Line(points = {{20, 26}, {26, 26}, {26, 16}, {-10, 16}, {-10, 4}, {-2, 4}, {-2, 4}, {-2, 4}}, color = {28, 108, 200}));
  connect(penstockKP1.n, fitting1.p) annotation (
    Line(points = {{28, 52}, {30, 52}, {30, 40}, {-4, 40}, {-4, 26}, {0, 26}, {0, 26}}, color = {28, 108, 200}));
  connect(surgeTank.n, penstockKP1.p) annotation (
    Line(points = {{6, 66}, {8, 66}, {8, 52}, {8, 52}}, color = {28, 108, 200}));
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
    experiment(StopTime = 1794, StartTime = 0, Tolerance = 0.0001, Interval = 1.0));
end HydroCordModelKPFran2;
