within OpenHPL;
package Controllers "Collection of different controllers"
  extends Modelica.Icons.Package;

  extends Icons.Governor;

  model Governor "Governor/control model"
    extends OpenHPL.Icons.Governor;
  outer Parameters para "using standard class with constants";
    //// control parameters of the governor
    parameter Modelica.SIunits.Time T_p = 0.04 "Pilot servomotor time constant" annotation (
      Dialog(group = "Controller settings"));
    parameter Modelica.SIunits.Time T_g = 0.2 "Main servomotor integration time" annotation (
      Dialog(group = "Controller settings"));
    parameter Modelica.SIunits.Time T_r = 1.75 "Transient droop time constant" annotation (
      Dialog(group = "Controller settings"));
    parameter Real lookup_table[:, :] = [0.0, 0.0; 0.01, 0.06; 0.22, 0.25; 0.53, 0.5; 0.8, 0.75; 1.0, 0.95; 1.05, 1.0] "Table matrix (grid = first column; e.g., table=[0, 0; 1, 1; 2, 4])" annotation (
      Dialog(group = "System settings"));
    parameter Real droop = 0.1 "Droop" annotation (
      Dialog(group = "Controller settings"));
    parameter Real delta = 0.04 "Transient droop" annotation (
      Dialog(group = "Controller settings"));
    parameter Real Y_gv_max = 0.05 "Max guide vane opening rate" annotation (
      Dialog(group = "System settings"));
    parameter Real Y_gv_min = 0.2 "Max guide vane closing rate" annotation (
      Dialog(group = "System settings"));
    parameter Real Y_gv_ref = 0.72151 "Initial guide vane opening rate" annotation (
      Dialog(group = "System settings"));
    parameter Modelica.SIunits.Frequency f_ref = para.f "Reference frequency" annotation (
      Dialog(group = "System settings"));
    parameter Modelica.SIunits.Power Pn = 104e6 "Reference frequency" annotation (
      Dialog(group = "System settings"));
    //// connectors
    Modelica.Blocks.Interfaces.RealInput P_ref annotation (
      Placement(visible = true, transformation(extent = {{-140, 20}, {-100, 60}}, rotation = 0), iconTransformation(extent = {{-140, 20}, {-100, 60}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput Y_gv annotation (
      Placement(visible = true, transformation(extent = {{100, -10}, {120, 10}}, rotation = 0), iconTransformation(extent = {{100, -10}, {120, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput f annotation (
      Placement(visible = true, transformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    //// blocks
    Modelica.Blocks.Tables.CombiTable1D look_up_table(table = lookup_table) annotation (
      Placement(visible = true, transformation(origin = {-54, 40}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Modelica.Blocks.Continuous.TransferFunction pilot_servo(a = {T_p, 1}, b = {1}, initType = Modelica.Blocks.Types.Init.InitialOutput, y_start = 0)  annotation (
    Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.TransferFunction main_servo(a = { 1, 0}, b = {1}, initType = Modelica.Blocks.Types.Init.InitialOutput, y_start = Y_gv_ref) annotation (
    Placement(visible = true, transformation(origin = {46, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_T_s(k = 1 / T_g)  annotation (
    Placement(visible = true, transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Nonlinear.Limiter limiter_dotY_gv(limitsAtInit = true, uMax = Y_gv_max, uMin = -Y_gv_min)  annotation (
    Placement(visible = true, transformation(origin = {18, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Nonlinear.Limiter limiter_Y_gv(limitsAtInit = true, uMax = 1, uMin = 0) annotation (
    Placement(visible = true, transformation(origin = {76, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.TransferFunction control(a = {T_r, 1}, b = {delta * T_r, 0}, initType = Modelica.Blocks.Types.Init.InitialOutput, y_start = 0) annotation (
    Placement(visible = true, transformation(origin = {62, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_droop(k = droop) annotation (
    Placement(visible = true, transformation(origin = {62, -56}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_P(k = 1 / Pn) annotation (
    Placement(visible = true, transformation(origin = {-84, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add1 annotation (
    Placement(visible = true, transformation(origin = {8, -44}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add3 add2(k2 = -1, k3 = -1)  annotation (
    Placement(visible = true, transformation(origin = {-58, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Math.Add add3(k1 = -1, k2 = +1)  annotation (
    Placement(visible = true, transformation(origin = {-58, -60}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Gain gain_f(k = 1 / f_ref) annotation (
    Placement(visible = true, transformation(origin = {-84, -62}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.Constant const(k = 1)  annotation (
    Placement(visible = true, transformation(origin = {-30, -80}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_droop2(k = droop) annotation (
      Placement(visible = true, transformation(origin = {-80, -4}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
    //Modelica.Blocks.Interfaces.RealInput P_g annotation (Placement(visible = true, transformation(extent = {{-128, -54}, {-88, -14}}, rotation = 0), iconTransformation(extent = {{-120, 24}, {-80, 64}}, rotation = 0)));
  initial equation
    //Y_gv = Y_gv_ref;
    //x_r = delta * Y_gv;
    //u = 0;
  equation
    connect(gain_droop2.y, add2.u1) annotation (
      Line(points={{-80,-15},{-80,-15},{-80,-44},{-66,-44},{-66,-36},{-66,-36}},              color = {0, 0, 127}));
    connect(look_up_table.y[1], gain_droop2.u) annotation (
      Line(points={{-43,40},{-34,40},{-34,20},{-80,20},{-80,8},{-80,8}},              color = {0, 0, 127}));
    connect(gain_P.y, look_up_table.u[1]) annotation (
      Line(points={{-73,40},{-66,40}},      color = {0, 0, 127}));
    connect(P_ref, gain_P.u) annotation (
      Line(points = {{-120, 40}, {-96, 40}}, color = {0, 0, 127}));
    connect(add1.u1, control.y) annotation (
      Line(points={{20,-38},{34,-38},{34,-30},{51,-30}},          color = {0, 0, 127}));
    connect(gain_droop.y, add1.u2) annotation (
      Line(points={{51,-56},{36,-56},{36,-50},{20,-50}},          color = {0, 0, 127}));
    connect(add1.y, add2.u3) annotation (
      Line(points = {{-3, -44}, {-50, -44}, {-50, -36}}, color = {0, 0, 127}));
    connect(limiter_Y_gv.y, gain_droop.u) annotation (
      Line(points={{87,0},{92,0},{92,-56},{74,-56},{74,-56}},            color = {0, 0, 127}));
    connect(limiter_Y_gv.y, control.u) annotation (
      Line(points={{87,0},{92,0},{92,-30},{74,-30},{74,-30},{74,-30}},              color = {0, 0, 127}));
    connect(limiter_Y_gv.y, Y_gv) annotation (
      Line(points={{87,0},{110,0}},      color = {0, 0, 127}));
    connect(const.y, add3.u1) annotation (
      Line(points={{-41,-80},{-52,-80},{-52,-72},{-52,-72}},          color = {0, 0, 127}));
    connect(gain_f.y, add3.u2) annotation (
      Line(points={{-84,-73},{-84,-73},{-84,-92},{-64,-92},{-64,-72},{-64,-72}},              color = {0, 0, 127}));
    connect(f, gain_f.u) annotation (
      Line(points = {{-120, -40}, {-84, -40}, {-84, -48}, {-84, -48}, {-84, -50}}, color = {0, 0, 127}));
    connect(add3.y, add2.u2) annotation (
      Line(points={{-58,-49},{-58,-49},{-58,-36},{-58,-36}},          color = {0, 0, 127}));
    connect(add2.y, pilot_servo.u) annotation (
      Line(points = {{-58, -13}, {-58, 0}, {-52, 0}}, color = {0, 0, 127}));
    connect(main_servo.y, limiter_Y_gv.u) annotation (
      Line(points={{57,0},{64,0},{64,0},{64,0}},          color = {0, 0, 127}));
    connect(gain_T_s.y, limiter_dotY_gv.u) annotation (
      Line(points={{1,0},{4,0},{4,0},{6,0}},          color = {0, 0, 127}));
    connect(limiter_dotY_gv.y, main_servo.u) annotation (
      Line(points = {{29, 0}, {34, 0}}, color = {0, 0, 127}));
    connect(pilot_servo.y, gain_T_s.u) annotation (
      Line(points={{-29,0},{-22,0},{-22,0},{-22,0}},          color = {0, 0, 127}));
  //// define curve for control signal based on power
    //look_up_table.u[1] = P_ref / Pn;
    //Y_gv_ref = look_up_table.y[1];
  //// governor model
    //dd = delta * Y_gv - x_r;
    //e = 1 - f / f_ref - dd + droop * (Y_gv_ref - Y_gv);
  //(P_ref/103e6 - P_g/103e6);
    //T_r * der(x_r) + x_r = delta * Y_gv;
    //T_p * der(u) + u = e;
    //if Y_gv < 0 and u < 0 or Y_gv > 1 and u > 0 then
    //  der(Y_gv) = 0;
    //elseif u / T_g >= Y_gv_max then
    //  der(Y_gv) = Y_gv_max;
    //elseif u / T_g <= (-Y_gv_min) then
    //  der(Y_gv) = -Y_gv_min;
    //else
    //  der(Y_gv) = u / T_g;
    //end if;
    annotation (
      Documentation(info="<html>
<p>This is a simple model of the governor that controls the guide vane
 opening in the turbine based on the reference power production.</p>
<p>The model is taken from <a href=\"modelica://OpenHPL.UsersGuide.References\">[Sharefi2011]</a>.
</html>"));
  end Governor;

  block GovernorPI
    extends Modelica.Icons.UnderConstruction;
  outer Parameters para;
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

  block GovernorP
    extends Modelica.Icons.UnderConstruction;
  outer Parameters para;
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

  model GovernorPower
    extends Modelica.Icons.UnderConstruction;
  outer Parameters para;
    parameter Modelica.SIunits.Time T_p = 0.04 "pilot servomotor time constant";
    parameter Modelica.SIunits.Time T_g = 0.2 "main servomotor integration time";
    parameter Modelica.SIunits.Time T_r = 1.75 "transient droop time constant";
    parameter Real droop = 0.1 "droop";
    parameter Real delta = 0.04 "transient droop";
    parameter Real Y_gv_max = 0.05 "Max guide vane opening rate";
    parameter Real Y_gv_min = 0.2 "Max guide vane closing rate";
    parameter Modelica.SIunits.Frequency f_ref = 50 "Reference frequency";
    parameter Real a = 0.000000009215729, b = 0.012086289473684;
    Real d, x_r, u, e, Y_gv_ref = 0.9;
    Modelica.Blocks.Interfaces.RealInput P_ref annotation (
      Placement(visible = true, transformation(extent = {{-128, -20}, {-88, 20}}, rotation = 0), iconTransformation(extent = {{-120, -20}, {-80, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput Y_gv annotation (
      Placement(transformation(extent = {{96, -10}, {116, 10}}), iconTransformation(extent = {{80, -20}, {120, 20}})));
    Modelica.Blocks.Interfaces.RealInput f annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, 104}), iconTransformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {3.55271e-015, 100})));
    Modelica.Blocks.Interfaces.RealInput P annotation (
      Placement(visible = true, transformation(extent = {{-128, -70}, {-88, -30}}, rotation = 0), iconTransformation(extent = {{-120, -80}, {-80, -40}}, rotation = 0)));
  initial equation
    Y_gv = Y_gv_ref;
    x_r = delta * Y_gv;
    u = 0;
  equation
  //f = freq.f;
  //Y_gv_ref = a * P_ref + b;
    d = delta * Y_gv - x_r;
    e = 1 - f / f_ref + droop * (P - P_ref) - d;
    T_r * der(x_r) + x_r = delta * Y_gv;
    T_p * der(u) + u = e;
    if Y_gv < 0 and u < 0 or Y_gv > 1 and u > 0 then
      der(Y_gv) = 0;
    elseif u / T_g >= Y_gv_max then
      der(Y_gv) = Y_gv_max;
    elseif u / T_g <= (-Y_gv_min) then
      der(Y_gv) = -Y_gv_min;
    else
      der(Y_gv) = u / T_g;
    end if;
  end GovernorPower;
end Controllers;
