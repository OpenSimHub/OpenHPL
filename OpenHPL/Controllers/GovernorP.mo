within OpenHPL.Controllers;
block GovernorP
  extends Modelica.Icons.UnderConstruction;
outer Data data;
  parameter Modelica.SIunits.Time T_p = 0.04 "pilot servomotor time constant";
  parameter Modelica.SIunits.Time T_g = 0.2 "main servomotor integration time";
  parameter Modelica.SIunits.Time T_r = 1.75 "transient droop time constant";
  parameter Real droop = 0.1 "droop";
  parameter Real delta = 0.04 "transient droop";
  parameter Real Y_gv_max = 0.05 "Max guide vane opening rat  e";
  parameter Real Y_gv_min = 0.2 "Max guide vane closing rate";
  parameter Modelica.SIunits.Frequency f_ref = 50 "Reference frequency";
  parameter Real deadBand = 0.01;
  Modelica.Blocks.Interfaces.RealInput P annotation (
    Placement(visible = true, transformation(extent = {{-122, -16}, {-90, 16}}, rotation = 0), iconTransformation(extent = {{-120, -20}, {-80, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Y_gv annotation (
    Placement(transformation(extent = {{98, -10}, {118, 10}}), iconTransformation(extent = {{80, -20}, {120, 20}})));
  Modelica.Blocks.Interfaces.RealInput f annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, 104}), iconTransformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {3.55271e-015, 100})));
  Modelica.Blocks.Math.Gain powerfactor(k = 0.000000009215729) annotation (
    Placement(transformation(extent = {{-86, -4}, {-78, 4}})));
  Modelica.Blocks.Math.Add Y_gv_ref annotation (
    Placement(transformation(extent = {{-68, -16}, {-48, 4}})));
  Modelica.Blocks.Sources.Constant losses(k = 0.012086289473684) annotation (
    Placement(transformation(extent = {{-90, -20}, {-80, -10}})));
  Modelica.Blocks.Math.Add3 error(k1 = -1, k3 = -1) annotation (
    Placement(transformation(extent = {{-24, -12}, {-12, 0}})));
  Modelica.Blocks.Math.Division freq_dif annotation (
    Placement(transformation(extent = {{-8, 64}, {-28, 84}})));
  Modelica.Blocks.Sources.Constant ref_f(k = f_ref) annotation (
    Placement(transformation(extent = {{26, 74}, {6, 94}})));
  Modelica.Blocks.Math.Add one_freq_dif(k2 = -1) annotation (
    Placement(transformation(extent = {{-7, -7}, {7, 7}}, rotation = 270, origin = {-47, 53})));
  Modelica.Blocks.Sources.Constant one(k = 1) annotation (
    Placement(transformation(extent = {{-80, 64}, {-60, 84}})));
  Modelica.Blocks.Continuous.TransferFunction TF_control(a = {T_p, 1}, b = {0, 1}) annotation (
    Placement(transformation(extent = {{-4, -14}, {12, 2}})));
  Modelica.Blocks.Math.Gain u(k = 1 / T_g) annotation (
    Placement(transformation(extent = {{20, -12}, {32, 0}})));
  Modelica.Blocks.Continuous.TransferFunction TF_Y_gv(a = {1, 0}, b = {0, 1}, initType = Modelica.Blocks.Types.Init.InitialOutput, y_start = 0.7493) annotation (
    Placement(transformation(extent = {{56, -6}, {68, 6}})));
  Modelica.Blocks.Math.Add add(k1 = -1, k2 = +1) annotation (
    Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 270, origin = {-32, -48})));
  Modelica.Blocks.Math.Gain droop_k1(k = droop) annotation (
    Placement(transformation(extent = {{4, -4}, {-4, 4}}, rotation = 270, origin = {-32, -24})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 1, uMin = 0) annotation (
    Placement(transformation(extent = {{76, -6}, {88, 6}})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax = Y_gv_max, uMin = -Y_gv_min) annotation (
    Placement(transformation(extent = {{38, -6}, {50, 6}})));
  Modelica.Blocks.Nonlinear.DeadZone deadZone(uMax = deadBand / f_ref) annotation (
    Placement(transformation(extent = {{-9, -9}, {9, 9}}, rotation = 270, origin = {-47, 29})));
  Modelica.Blocks.Continuous.TransferFunction TF_mech(b = {delta * T_r, 0}, a = {T_r, 1}, initType = Modelica.Blocks.Types.Init.InitialOutput, y_start = 0.03) annotation (
    Placement(transformation(extent = {{48, -48}, {28, -28}})));
equation
  connect(powerfactor.y, Y_gv_ref.u1) annotation (
    Line(points = {{-77.6, 0}, {-70, 0}}, color = {0, 0, 127}));
  connect(Y_gv_ref.u2, losses.y) annotation (
    Line(points = {{-70, -12}, {-76, -12}, {-76, -15}, {-79.5, -15}}, color = {0, 0, 127}));
  connect(P, powerfactor.u) annotation (
    Line(points = {{-106, 0}, {-86.8, 0}}, color = {0, 0, 127}));
  connect(f, freq_dif.u1) annotation (
    Line(points = {{0, 104}, {0, 80}, {-6, 80}}, color = {0, 0, 127}));
  connect(freq_dif.u2, ref_f.y) annotation (
    Line(points = {{-6, 68}, {2, 68}, {2, 84}, {5, 84}}, color = {0, 0, 127}));
  connect(freq_dif.y, one_freq_dif.u1) annotation (
    Line(points = {{-29, 74}, {-42.8, 74}, {-42.8, 61.4}}, color = {0, 0, 127}));
  connect(one.y, one_freq_dif.u2) annotation (
    Line(points = {{-59, 74}, {-51.2, 74}, {-51.2, 61.4}}, color = {0, 0, 127}));
  connect(error.y, TF_control.u) annotation (
    Line(points = {{-11.4, -6}, {-11.4, -6}, {-5.6, -6}}, color = {0, 0, 127}));
  connect(TF_control.y, u.u) annotation (
    Line(points = {{12.8, -6}, {12.8, -6}, {18.8, -6}}, color = {0, 0, 127}));
  connect(add.y, droop_k1.u) annotation (
    Line(points = {{-32, -37}, {-32, -37}, {-32, -28.8}}, color = {0, 0, 127}));
  connect(droop_k1.y, error.u2) annotation (
    Line(points = {{-32, -19.6}, {-32, -19.6}, {-32, -6}, {-25.2, -6}}, color = {0, 0, 127}));
  connect(Y_gv_ref.y, add.u2) annotation (
    Line(points = {{-47, -6}, {-46, -6}, {-46, -72}, {-38, -72}, {-38, -60}}, color = {0, 0, 127}));
  connect(Y_gv, limiter.y) annotation (
    Line(points = {{108, 0}, {98, 0}, {88.6, 0}}, color = {0, 0, 127}));
  connect(limiter.u, TF_Y_gv.y) annotation (
    Line(points = {{74.8, 0}, {68.6, 0}}, color = {0, 0, 127}));
  connect(u.y, limiter1.u) annotation (
    Line(points = {{32.6, -6}, {34, -6}, {34, 0}, {36.8, 0}}, color = {0, 0, 127}));
  connect(TF_Y_gv.u, limiter1.y) annotation (
    Line(points = {{54.8, 0}, {52, 0}, {50.6, 0}}, color = {0, 0, 127}));
  connect(add.u1, limiter.y) annotation (
    Line(points = {{-26, -60}, {-26, -72}, {92, -72}, {92, 0}, {88.6, 0}}, color = {0, 0, 127}));
  connect(one_freq_dif.y, deadZone.u) annotation (
    Line(points = {{-47, 45.3}, {-47, 39.8}}, color = {0, 0, 127}));
  connect(deadZone.y, error.u1) annotation (
    Line(points = {{-47, 19.1}, {-34, 19.1}, {-34, -1.2}, {-25.2, -1.2}}, color = {0, 0, 127}));
  connect(TF_mech.y, error.u3) annotation (
    Line(points = {{27, -38}, {6, -38}, {-12, -38}, {-12, -16}, {-30, -16}, {-30, -10.8}, {-25.2, -10.8}}, color = {0, 0, 127}));
  connect(TF_mech.u, limiter.y) annotation (
    Line(points = {{50, -38}, {92, -38}, {92, 0}, {88.6, 0}}, color = {0, 0, 127}));
end GovernorP;
