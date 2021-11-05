within OpenHPL.Controllers;
model Governor "Governor/control model"
  extends OpenHPL.Icons.Governor;
outer Data data "using standard class with constants";
  //// control parameters of the governor
  parameter SI.Time T_p = 0.04 "Pilot servomotor time constant" annotation (
    Dialog(group = "Controller settings"));
  parameter SI.Time T_g = 0.2 "Main servomotor integration time" annotation (
    Dialog(group = "Controller settings"));
  parameter SI.Time T_r = 1.75 "Transient droop time constant" annotation (
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
  parameter SI.Frequency f_ref = data.f_0 "Reference frequency" annotation (
    Dialog(group = "System settings"));
  parameter SI.Power Pn = 104e6 "Reference power" annotation (
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
<p>The model is taken from <a href=\"modelica://OpenHPL.UsersGuide.References\">[Sharefi2011]</a>.</p>
</html>"));
end Governor;
