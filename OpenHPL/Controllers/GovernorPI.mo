within OpenHPL.Controllers;
block GovernorPI
  extends Modelica.Icons.UnderConstruction;
outer Data data;
  parameter Modelica.SIunits.Time T_d = 0.3 "pilot servomotor time constant";
  parameter Modelica.SIunits.Time T_i = 5 "main servomotor integration time";
  parameter Modelica.SIunits.Time T_s = 0.05 "transient droop time constant";
  parameter Modelica.SIunits.Time T_y1 = 0.2 "transient droop time constant";
  parameter Modelica.SIunits.Time T_y2 = 0.2 "transient droop time constant";
  parameter Real droop = 0.1 "droop";
  parameter Real b_t = 0.3 "transient droop";
  parameter Real K_s = 8 "transient droop";
  parameter Real Y_gv_max = 0.05 "Max guide vane opening rat  e";
  parameter Real Y_gv_min = 0.2 "Max guide vane closing rate";
  parameter Modelica.SIunits.Frequency f_ref = 50 "Reference frequency";
  Modelica.Blocks.Interfaces.RealInput P_ref annotation (
    Placement(visible = true, transformation(extent = {{-128, -20}, {-88, 20}}, rotation = 0), iconTransformation(extent = {{-120, -20}, {-80, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Y_gv annotation (
    Placement(transformation(extent = {{96, -10}, {116, 10}}), iconTransformation(extent = {{80, -20}, {120, 20}})));
  Modelica.Blocks.Interfaces.RealInput f annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-80, 102}), iconTransformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {3.55271e-015, 100})));
  Modelica.Blocks.Continuous.TransferFunction derevativPart(b = {T_d, 1}, a = {0.1 * T_d, 1}, initType = Modelica.Blocks.Types.Init.InitialOutput, y_start = 1) annotation (
    Placement(transformation(extent = {{-76, 44}, {-56, 64}})));
  Modelica.Blocks.Sources.Constant ref_f(k = f_ref / f_ref) annotation (
    Placement(transformation(extent = {{-74, 74}, {-54, 94}})));
  Modelica.Blocks.Math.Add add(k2 = -1) annotation (
    Placement(transformation(extent = {{-46, 50}, {-26, 70}})));
  Modelica.Blocks.Continuous.TransferFunction integralPart(b = {T_i, 1}, a = {T_i, 0}) annotation (
    Placement(transformation(extent = {{42, 58}, {62, 78}})));
  Modelica.Blocks.Math.Gain gain(k = 1 / b_t) annotation (
    Placement(transformation(extent = {{14, 58}, {34, 78}})));
  Modelica.Blocks.Math.Feedback feedback annotation (
    Placement(transformation(extent = {{66, 58}, {86, 78}})));
  Modelica.Blocks.Continuous.TransferFunction proportailPart(b = {T_s, 1}, a = {T_s, 0}) annotation (
    Placement(transformation(extent = {{-8, -10}, {12, 10}})));
  Modelica.Blocks.Math.Gain gain1(k = K_s) annotation (
    Placement(transformation(extent = {{-28, -6}, {-16, 6}})));
  Modelica.Blocks.Math.Gain droopM(k = droop) annotation (
    Placement(transformation(extent = {{-46, 20}, {-26, 40}})));
  Modelica.Blocks.Math.Add add1(k2 = +1) annotation (
    Placement(transformation(extent = {{-16, 50}, {4, 70}})));
  Modelica.Blocks.Math.Add Y_dif(k1 = -1, k2 = +1) annotation (
    Placement(transformation(extent = {{-74, 20}, {-54, 40}})));
  Modelica.Blocks.Continuous.TransferFunction servo2(b = {0, 1}, a = {T_y2, 0}, initType = Modelica.Blocks.Types.Init.InitialOutput, y_start = 0.7493) annotation (
    Placement(transformation(extent = {{48, -10}, {68, 10}})));
  Modelica.Blocks.Math.Gain powerfactor(k = 0.000000009215729) annotation (
    Placement(transformation(extent = {{-94, -32}, {-86, -24}})));
  Modelica.Blocks.Math.Add Y_gv_ref annotation (
    Placement(transformation(extent = {{-74, -44}, {-54, -24}})));
  Modelica.Blocks.Sources.Constant losses(k = 0.012086289473684) annotation (
    Placement(transformation(extent = {{-98, -48}, {-88, -38}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 1, uMin = 0) annotation (
    Placement(transformation(extent = {{76, -6}, {88, 6}})));
  Modelica.Blocks.Math.Gain gain2(k = 1 / f_ref) annotation (
    Placement(transformation(extent = {{-6, -6}, {6, 6}}, rotation = 270, origin = {-92, 74})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax = Y_gv_max, uMin = -Y_gv_min) annotation (
    Placement(transformation(extent = {{20, -6}, {32, 6}})));
equation
  connect(ref_f.y, add.u1) annotation (
    Line(points = {{-53, 84}, {-52, 84}, {-52, 66}, {-48, 66}}, color = {0, 0, 127}));
  connect(derevativPart.y, add.u2) annotation (
    Line(points = {{-55, 54}, {-55, 54}, {-48, 54}}, color = {0, 0, 127}));
  connect(integralPart.u, gain.y) annotation (
    Line(points = {{40, 68}, {40, 68}, {35, 68}}, color = {0, 0, 127}));
  connect(integralPart.y, feedback.u1) annotation (
    Line(points = {{63, 68}, {63, 68}, {68, 68}}, color = {0, 0, 127}));
  connect(proportailPart.u, gain1.y) annotation (
    Line(points = {{-10, 0}, {-10, 0}, {-15, 4, 0}}, color = {0, 0, 127}));
  connect(gain1.u, feedback.y) annotation (
    Line(points = {{-29, 2, 0}, {-36, 0}, {-36, 16}, {94, 16}, {94, 68}, {85, 68}}, color = {0, 0, 127}));
  connect(gain.u, add1.y) annotation (
    Line(points = {{12, 68}, {5, 68}, {5, 60}}, color = {0, 0, 127}));
  connect(add.y, add1.u1) annotation (
    Line(points = {{-25, 60}, {-22, 60}, {-22, 66}, {-18, 66}}, color = {0, 0, 127}));
  connect(droopM.y, add1.u2) annotation (
    Line(points = {{-25, 30}, {-22, 30}, {-22, 54}, {-18, 54}}, color = {0, 0, 127}));
  connect(Y_dif.y, droopM.u) annotation (
    Line(points = {{-53, 30}, {-56, 30}, {-48, 30}}, color = {0, 0, 127}));
  connect(Y_dif.u2, Y_gv) annotation (
    Line(points = {{-76, 24}, {-80, 24}, {-80, 12}, {-46, 12}, {-46, -14}, {94, -14}, {94, 0}, {106, 0}}, color = {0, 0, 127}));
  connect(powerfactor.y, Y_gv_ref.u1) annotation (
    Line(points = {{-85, 6, -28}, {-85, 6, -28}, {-76, -28}}, color = {0, 0, 127}));
  connect(Y_gv_ref.u2, losses.y) annotation (
    Line(points = {{-76, -40}, {-84, -40}, {-84, -43}, {-87, 5, -43}}, color = {0, 0, 127}));
  connect(Y_gv_ref.y, Y_dif.u1) annotation (
    Line(points = {{-53, -34}, {-52, -34}, {-52, -28}, {-52, 8}, {-52, 10}, {-88, 10}, {-88, 36}, {-76, 36}}, color = {0, 0, 127}));
  connect(P_ref, powerfactor.u) annotation (
    Line(points = {{-108, 0}, {-84, 0}, {-84, -18}, {-98, -18}, {-98, -28}, {-94, 8, -28}}, color = {0, 0, 127}));
  connect(servo2.y, limiter.u) annotation (
    Line(points = {{69, 0}, {74, 8, 0}, {74, 8, 0}}, color = {0, 0, 127}));
  connect(Y_gv, limiter.y) annotation (
    Line(points = {{106, 0}, {88, 6, 0}}, color = {0, 0, 127}));
  connect(f, gain2.u) annotation (
    Line(points = {{-80, 102}, {-86, 102}, {-86, 81, 2}, {-92, 81, 2}}, color = {0, 0, 127}));
  connect(derevativPart.u, gain2.y) annotation (
    Line(points = {{-78, 54}, {-86, 54}, {-86, 67, 4}, {-92, 67, 4}}, color = {0, 0, 127}));
  connect(proportailPart.y, limiter1.u) annotation (
    Line(points = {{13, 0}, {18, 8, 0}, {18, 8, 0}}, color = {0, 0, 127}));
  connect(servo2.u, limiter1.y) annotation (
    Line(points = {{46, 0}, {32, 6, 0}}, color = {0, 0, 127}));
  connect(feedback.u2, limiter1.y) annotation (
    Line(points = {{76, 60}, {76, 24}, {38, 24}, {38, 0}, {32, 6, 0}}, color = {0, 0, 127}));
end GovernorPI;
