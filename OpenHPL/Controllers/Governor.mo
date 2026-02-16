within OpenHPL.Controllers;
model Governor "Governor/control model"
  extends OpenHPL.Icons.Governor;
outer Data data "Using standard class with constants";
  // control parameters of the governor
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
  // connectors
  Modelica.Blocks.Interfaces.RealInput P_ref annotation (
    Placement(transformation(extent = {{-140, 20}, {-100, 60}}), iconTransformation(extent = {{-140, 20}, {-100, 60}})));
  Modelica.Blocks.Interfaces.RealOutput Y_gv annotation (
    Placement(transformation(extent = {{100, -10}, {120, 10}}), iconTransformation(extent = {{100, -10}, {120, 10}})));
  Modelica.Blocks.Interfaces.RealInput f annotation (
    Placement(transformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}})));
  // blocks
  Modelica.Blocks.Tables.CombiTable1Dv look_up_table(
                                                    table = lookup_table) annotation (
    Placement(transformation(origin = {-54, 40}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Blocks.Continuous.TransferFunction pilot_servo(a = {T_p, 1}, b = {1}, initType = Modelica.Blocks.Types.Init.InitialOutput, y_start = 0) annotation (
  Placement(transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.TransferFunction main_servo(a = { 1, 0}, b = {1}, initType = Modelica.Blocks.Types.Init.InitialOutput, y_start = Y_gv_ref) annotation (
  Placement(transformation(origin = {46, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Gain gain_T_s(k = 1 / T_g) annotation (
  Placement(transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Nonlinear.Limiter limiter_dotY_gv( uMax = Y_gv_max, uMin = -Y_gv_min) annotation (
  Placement(transformation(origin = {18, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Nonlinear.Limiter limiter_Y_gv( uMax = 1, uMin = 0) annotation (
  Placement(transformation(origin = {76, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.TransferFunction control(a = {T_r, 1}, b = {delta * T_r, 0}, initType = Modelica.Blocks.Types.Init.InitialOutput, y_start = 0) annotation (
  Placement(transformation(origin = {62, -30}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Math.Gain gain_droop(k = droop) annotation (
  Placement(transformation(origin = {62, -56}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Math.Gain gain_P(k = 1 / Pn) annotation (
  Placement(transformation(origin = {-84, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Add add1 annotation (
  Placement(transformation(origin = {8, -44}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Math.Add3 add2(k2 = -1, k3 = -1) annotation (
  Placement(transformation(origin = {-58, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Math.Add add3(k1 = -1, k2 = +1) annotation (
  Placement(transformation(origin = {-58, -60}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  Modelica.Blocks.Math.Gain gain_f(k = 1 / f_ref) annotation (
  Placement(transformation(origin = {-84, -62}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant const(k = 1) annotation (
  Placement(transformation(origin = {-30, -80}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Math.Gain gain_droop2(k = droop) annotation (
    Placement(transformation(origin = {-80, -4}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  //Modelica.Blocks.Interfaces.RealInput P_g annotation (Placement(transformation(extent = {{-128, -54}, {-88, -14}}), iconTransformation(extent = {{-120, 24}, {-80, 64}})));
initial equation
  //Y_gv = Y_gv_ref;
  //x_r = delta * Y_gv;
  //u = 0;
equation
  connect(gain_droop2.y, add2.u1) annotation (
    Line(points={{-80,-15},{-80,-15},{-80,-44},{-66,-44},{-66,-36},{-66,-36}}, color = {0, 0, 127}));
  connect(look_up_table.y[1], gain_droop2.u) annotation (
    Line(points={{-43,40},{-34,40},{-34,20},{-80,20},{-80,8},{-80,8}}, color = {0, 0, 127}));
  connect(gain_P.y, look_up_table.u[1]) annotation (
    Line(points={{-73,40},{-66,40}}, color = {0, 0, 127}));
  connect(P_ref, gain_P.u) annotation (
    Line(points = {{-120, 40}, {-96, 40}}, color = {0, 0, 127}));
  connect(add1.u1, control.y) annotation (
    Line(points={{20,-38},{34,-38},{34,-30},{51,-30}}, color = {0, 0, 127}));
  connect(gain_droop.y, add1.u2) annotation (
    Line(points={{51,-56},{36,-56},{36,-50},{20,-50}}, color = {0, 0, 127}));
  connect(add1.y, add2.u3) annotation (
    Line(points = {{-3, -44}, {-50, -44}, {-50, -36}}, color = {0, 0, 127}));
  connect(limiter_Y_gv.y, gain_droop.u) annotation (
    Line(points={{87,0},{92,0},{92,-56},{74,-56},{74,-56}}, color = {0, 0, 127}));
  connect(limiter_Y_gv.y, control.u) annotation (
    Line(points={{87,0},{92,0},{92,-30},{74,-30},{74,-30},{74,-30}}, color = {0, 0, 127}));
  connect(limiter_Y_gv.y, Y_gv) annotation (
    Line(points={{87,0},{110,0}}, color = {0, 0, 127}));
  connect(const.y, add3.u1) annotation (
    Line(points={{-41,-80},{-52,-80},{-52,-72},{-52,-72}}, color = {0, 0, 127}));
  connect(gain_f.y, add3.u2) annotation (
    Line(points={{-84,-73},{-84,-73},{-84,-92},{-64,-92},{-64,-72},{-64,-72}}, color = {0, 0, 127}));
  connect(f, gain_f.u) annotation (
    Line(points = {{-120, -40}, {-84, -40}, {-84, -48}, {-84, -48}, {-84, -50}}, color = {0, 0, 127}));
  connect(add3.y, add2.u2) annotation (
    Line(points={{-58,-49},{-58,-49},{-58,-36},{-58,-36}}, color = {0, 0, 127}));
  connect(add2.y, pilot_servo.u) annotation (
    Line(points = {{-58, -13}, {-58, 0}, {-52, 0}}, color = {0, 0, 127}));
  connect(main_servo.y, limiter_Y_gv.u) annotation (
    Line(points={{57,0},{64,0},{64,0},{64,0}}, color = {0, 0, 127}));
  connect(gain_T_s.y, limiter_dotY_gv.u) annotation (
    Line(points={{1,0},{4,0},{4,0},{6,0}}, color = {0, 0, 127}));
  connect(limiter_dotY_gv.y, main_servo.u) annotation (
    Line(points = {{29, 0}, {34, 0}}, color = {0, 0, 127}));
  connect(pilot_servo.y, gain_T_s.u) annotation (
    Line(points={{-29,0},{-22,0},{-22,0},{-22,0}}, color = {0, 0, 127}));
// define curve for control signal based on power
  //look_up_table.u[1] = P_ref / Pn;
  //Y_gv_ref = look_up_table.y[1];
// governor model
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
   annotation (preferredView="info", Documentation(info="<html>
<h4>Governor</h4>
<p>
Here, a simple model of the governor that controls the guide vane opening in the turbine based on the reference power
production is described. The block diagram of this governor model is shown in the figure.
</p>

<p align=\"center\">
  <img src=\"modelica://OpenHPL/Resources/Images/Governor.png\" alt=\"Governor block diagram\" width=\"600\"/>
</p>
<p><em>Figure: Block Diagram of the governor.</em></p>

<h5>Implementation</h5>
<p>
Using the model in the figure and the standard Modelica blocks, the governor model is encoded in our library as the
<em>Governor</em> unit. This unit has inputs as the reference power production and generator frequency that are implemented
with the standard Modelica <em>RealInput</em> connector. This <em>Governor</em> unit also uses the standard Modelica
<em>RealOutput</em> connectors in order to provide output information about the turbine guide vane opening.
</p>

<h5>Parameters</h5>
<p>
In the <em>Governor</em> unit (note: in the text it mentions <em>SynchGen</em> but this appears to be a typo in the
original document - should be <em>Governor</em>), the user can specify the various time constants of this model (see
figure): pilot servomotor time constant T<sub>p</sub>, primary servomotor integration time T<sub>g</sub>, and transient
droop time constant T<sub>r</sub>. The user should also provide the following parameters: droop value σ, transient droop δ,
and nominal values for the frequency and power generation. The information about the maximum, minimum, and initial guide
vane opening should also be specified.
</p>

<p>The model is taken from <a href=\"modelica://OpenHPL.UsersGuide.References\">[Sharefi2011]</a>.</p>
</html>"));
end Governor;
