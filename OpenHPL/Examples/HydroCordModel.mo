within OpenHPL.Examples;
model HydroCordModel "Model of Trollheim hydro power plant."
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(H_r=418.5 - 372, UseInFlow=false) annotation (Placement(visible=true, transformation(
        origin={-94,64},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = -0.05, offset = 0.00001, startTime = 60000) annotation (
    Placement(visible = true, transformation(origin = {16, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe intake1(
    D_i=6.3,
    D_o=6.3,
    H=372 - 363,
    L=81.5,
    p_eps=0.05) annotation (Placement(visible=true, transformation(extent={{-78,56},
            {-58,76}},                                                                         rotation=0)));
  OpenHPL.Waterway.Pipe discharge1(
    D_i=6.3,
    D_o=6.3,
    H=17.5 - 14,
    L=601,
    p_eps=0.05) annotation (Placement(visible=true, transformation(extent={{46,-16},
            {66,4}},                                                                          rotation=0)));
  OpenHPL.Waterway.Reservoir tail(
    Input_level=true,
    H_r=24.5 - 22.6,
    UseInFlow=false) annotation (Placement(visible=true, transformation(
        origin={98,8},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.Pipe penstock1(
    D_i=4.7,
    D_o=4.7,
    H=356 - 123,
    L=363,
    p_eps=0.05) annotation (Placement(visible=true, transformation(
        origin={10,54},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  OpenHPL.Waterway.SurgeTank surgeTank(
    D=3.4,
    H=431.5 - 356,
    L=87,
    h_0=62.5,
    p_eps=0.05) annotation (Placement(visible=true, transformation(
        origin={-8,70},
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
    p_eps=0.05) annotation (Placement(visible=true, transformation(
        origin={-48,62},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe intake3(
    D_i=6.3,
    D_o=6.3,
    H=365 - 356,
    L=4020,
    p_eps=0.05) annotation (Placement(visible=true, transformation(
        origin={-26,60},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Fitting fitting1(
    D_1=4.7,
    D_2=3.3,
    fit_type=OpenHPL.Types.Fitting.SquareReduction) annotation (Placement(visible=true, transformation(
        origin={4,32},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  OpenHPL.Waterway.Pipe penstock2(
    D_i=3.3,
    D_o=3.3,
    H=123 - 20.5 + 2.5,
    L=145,
    p_eps=0.05) annotation (Placement(visible=true, transformation(
        origin={22,4},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  OpenHPL.Waterway.Pipe discharge2(
    D_i=6.3,
    D_o=6.3,
    H=14 - 22.6,
    L=21,
    p_eps=0.05) annotation (Placement(visible=true, transformation(
        origin={74,18},
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
  inner OpenHPL.Data data(V_0=0.00040045) annotation (Placement(visible=true, transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  connect(limiter1.y, per_gain.u) annotation (
    Line(points={{-43,-42},{-40,-42},{-40,-44},{-34,-44}},          color = {0, 0, 127}));
  connect(add1.y, tail.Level_in) annotation (
    Line(points={{90,-33},{90,13},{110,13}},                    color = {0, 0, 127}));
  connect(const_level.y, add1.u2) annotation (
    Line(points={{69,-88},{96,-88},{96,-56},{96,-56}},          color = {0, 0, 127}));
  connect(tail_level.y[1], add1.u1) annotation (
    Line(points={{69,-64},{84,-64},{84,-56},{84,-56}},          color = {0, 0, 127}, thickness = 0.5));
  connect(per_gain.y, turbine.u_t) annotation (
    Line(points={{-11,-44},{40,-44},{40,20},{32,20},{32,6}},            color = {0, 0, 127}));
  connect(servo_pos.y[1], limiter1.u) annotation (
    Line(points={{-75,-40},{-72,-40},{-72,-42},{-66,-42},{-66,-42}},            color = {0, 0, 127}, thickness = 0.5));
  connect(reservoir.o, intake1.i) annotation (Line(points={{-84,64},{-80,64},{
          -80,66},{-78,66}}, color={28,108,200}));
  connect(intake2.i, intake1.o)
    annotation (Line(points={{-58,62},{-58,66}}, color={28,108,200}));
  connect(intake3.i, intake2.o)
    annotation (Line(points={{-36,60},{-38,60},{-38,62}}, color={28,108,200}));
  connect(intake3.o, surgeTank.i)
    annotation (Line(points={{-16,60},{-18,60},{-18,70}}, color={28,108,200}));
  connect(surgeTank.o, penstock1.i) annotation (Line(points={{2,70},{6,70},{6,
          64},{10,64}}, color={28,108,200}));
  connect(penstock1.o, fitting1.i) annotation (Line(points={{10,44},{8,44},{8,
          42},{4,42}}, color={28,108,200}));
  connect(penstock2.i, fitting1.o) annotation (Line(points={{22,14},{8,14},{8,
          22},{4,22}}, color={28,108,200}));
  connect(turbine.i, penstock2.o)
    annotation (Line(points={{22,-6},{22,-6}}, color={28,108,200}));
  connect(discharge2.i, discharge1.o)
    annotation (Line(points={{64,18},{64,-6},{66,-6}}, color={28,108,200}));
  connect(turbine.o, discharge1.i)
    annotation (Line(points={{42,-6},{46,-6}}, color={28,108,200}));
  connect(tail.o, discharge2.o) annotation (Line(points={{88,8},{88,10},{84,10},
          {84,18}}, color={28,108,200}));
  annotation (
    experiment(StopTime = 3600, StartTime = 0, Tolerance = 0.0001, Interval = 1),
    Diagram(graphics={  Rectangle(origin = {17, 10}, extent = {{1, -2}, {-1, 2}})}));
end HydroCordModel;
