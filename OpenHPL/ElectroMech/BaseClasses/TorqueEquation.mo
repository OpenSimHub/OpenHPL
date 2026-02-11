within OpenHPL.ElectroMech.BaseClasses;

partial model TorqueEquation
  outer OpenHPL.Data data "Using standard class with global parameters";
  //
  parameter Boolean useH = false "If checked, calculate the inertia from a given H value" annotation(
    Dialog(group = "Mechanical"),
    choices(checkBox = true));
  parameter SI.Power Pmax = 100e6 "Maximum rated power (for torque limiting and H calculation)" annotation(
    Dialog(group = "Mechanical"));
  parameter SI.Time H = 2.75 "Inertia constant H, typical 2s (high-head hydro) to 6s (gas or low-head hydro) production units" annotation(
    Dialog(group = "Mechanical", enable = useH));
  parameter SI.MomentOfInertia J = 2e5 "Moment of inertia of the unit (GD2/4)" annotation(
    Dialog(group = "Mechanical", enable = not useH));
  parameter Integer p(min = 2) = 12 "Number of poles for mechanical speed calculation (Not pole pairs!)" annotation(
    Dialog(group = "Mechanical"),
    choices(choice = 2 "2,[3000|3600] rpm", choice = 4 "4,[1500|1800] rpm", choice = 6 "6,[1000|1200] rpm", choice = 8 "8,[750|900] rpm", choice = 10 "10,[600|720] rpm", choice = 12 "12,[500|600] rpm", choice = 14 "14,[429|514] rpm", choice = 16 "16,[375|450] rpm", choice = 18 "18,[333|400] rpm", choice = 20 "20,[300|360] rpm", choice = 22 "22,[273|327] rpm", choice = 24 "24,[250|300] rpm", choice = 26 "26,[231|277] rpm", choice = 28 "28,[214|257] rpm", choice = 30 "30,[200|240] rpm", choice = 28 "32,[187.5|225] rpm"));
  parameter SI.Power Ploss = 0 "Friction losses of the unit at nominal speed" annotation(
    Dialog(group = "Mechanical"));
  parameter SI.PerUnit f_0 = 1 "Initial speed of the unit" annotation(
    Dialog(group = "Initialization"));
  parameter Boolean enable_nomSpeed = false "If checked, unit runs at fixed speed f_0" annotation(
    choices(checkBox = true),
    Dialog(group = "Initialization", enable = not fixed_iniSpeed and not enable_f_in));
  parameter Boolean fixed_iniSpeed = false "If checked, unit initialises with fixed speed.
                When connecting several units mechanically only one can be fixed." annotation(
    choices(checkBox = true),
    Dialog(group = "Initialization", enable = not enable_nomSpeed and not enable_f_in));
  parameter Boolean enable_f_in = false "If checked, get a connector for speed input" annotation(
    choices(checkBox = true),
    Dialog(group = "Inputs", tab = "I/O", enable = not fixed_iniSpeed and not enable_nomSpeed));
  parameter Boolean enable_w = false "If checked, get a connector for angular velocity output" annotation(
    choices(checkBox = true),
    Dialog(group = "Outputs", tab = "I/O"));
  parameter Boolean enable_f = false "If checked, get a connector for speed output" annotation(
    choices(checkBox = true),
    Dialog(group = "Outputs", tab = "I/O"));
  
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation(
    Placement(transformation(origin = {10, -28}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = if useH then 2*H*Pmax/f_0^2 else J, w(start = f_0*2*Modelica.Constants.pi*data.f_0/(p/2), fixed = not enable_nomSpeed and not enable_f_in and fixed_iniSpeed)) annotation(
    Placement(transformation(extent = {{-20, -10}, {0, 10}})));
  Modelica.Electrical.Machines.Losses.Friction friction(frictionParameters(PRef = Ploss, wRef = data.f_0*4*C.pi/p)) annotation(
    Placement(transformation(extent = {{0, 60}, {20, 40}})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed annotation(
    Placement(transformation(extent = {{20, 50}, {40, 70}})));
 Modelica.Blocks.Math.Gain w_m2pu(k = (p/2)/(2*Modelica.Constants.pi*data.f_0)) annotation(
    Placement(transformation(extent = {{66, -46}, {78, -34}})));
  Modelica.Blocks.Interfaces.RealOutput f if enable_f "Speed output of the unit [pu]" annotation(
    Placement(transformation(extent = {{100, -50}, {120, -30}}), iconTransformation(extent = {{100, -50}, {120, -30}})));
  Modelica.Blocks.Interfaces.RealOutput w(unit = "rad/s") if enable_w "Mechanical angular velocity output of the unit [rad/s]" annotation(
    Placement(transformation(extent = {{100, 30}, {120, 50}}), iconTransformation(extent = {{100, 30}, {120, 50}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange "Flange of right shaft" annotation(
    Placement(transformation(extent = {{40, -10}, {60, 10}}), iconTransformation(extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression torque annotation(
    Placement(transformation(extent = {{-60, 20}, {-80, 40}})));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor frictionLoss annotation(
    Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 270, origin = {10, 20})));
  Modelica.Mechanics.Rotational.Sources.Speed setSpeed if enable_nomSpeed or enable_f_in annotation(
    Placement(transformation(extent = {{76, -6}, {64, 6}})));
  Modelica.Mechanics.Rotational.Components.IdealGear toSysSpeed(ratio = 2/p) "Converts to system speed based on p = 2" annotation(
    Placement(transformation(extent = {{24, -6}, {36, 6}})));
  Modelica.Blocks.Sources.RealExpression nominalSpeed(y = f_0) if enable_nomSpeed annotation(
    Placement(transformation(extent = {{-10, -80}, {10, -60}})));
  Modelica.Blocks.Interfaces.RealInput f_in if enable_f_in and not enable_nomSpeed "Speed input of the unit [pu]" annotation(
    Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {-80, -120})));
  Modelica.Blocks.Math.Gain pu2w_s(k = 2*Modelica.Constants.pi*data.f_0) if enable_f_in or enable_nomSpeed annotation(
    Placement(transformation(extent = {{40, -90}, {60, -70}})));
  protected
   Modelica.Mechanics.Rotational.Sources.Torque torque_transfer annotation(
    Placement(transformation(extent = {{-36, -6}, {-24, 6}})));
  
equation
  connect(w, speedSensor.w) annotation(
    Line(points = {{110, 40}, {40, 40}, {40, -42}, {10, -42}, {10, -39}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(w_m2pu.u, speedSensor.w) annotation(
    Line(points = {{64.8, -40}, {64.8, -42}, {10, -42}, {10, -39}}, color = {0, 0, 127}));
  connect(f, w_m2pu.y) annotation(
    Line(points = {{110, -40}, {78.6, -40}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(inertia.flange_b, speedSensor.flange) annotation(
    Line(points = {{0, 0}, {0, -2}, {10, -2}, {10, -18}}));
  connect(friction.support, fixed.flange) annotation(
    Line(points = {{10, 60}, {10, 70}, {30, 70}, {30, 60}}, color = {0, 0, 0}));
  connect(torque_transfer.flange, inertia.flange_a) annotation(
    Line(points = {{-24, 0}, {-20, 0}}, color = {0, 0, 0}));
  connect(w, w) annotation(
    Line(points = {{110, 40}, {105, 40}, {105, 40}, {110, 40}}, color = {0, 0, 127}));
  connect(frictionLoss.flange_a, inertia.flange_b) annotation(
    Line(points = {{10, 10}, {10, 0}, {0, 0}}, color = {0, 0, 0}));
  connect(frictionLoss.flange_b, friction.flange) annotation(
    Line(points = {{10, 30}, {10, 40}}, color = {0, 0, 0}));
  connect(setSpeed.flange, flange) annotation(
    Line(points = {{64, 0}, {50, 0}}, color = {0, 0, 0}, pattern = LinePattern.Dash));
  connect(flange, toSysSpeed.flange_b) annotation(
    Line(points = {{50, 0}, {36, 0}}, color = {0, 0, 0}));
  connect(toSysSpeed.flange_a, inertia.flange_b) annotation(
    Line(points = {{24, 0}, {0, 0}}, color = {0, 0, 0}));
  connect(setSpeed.w_ref, pu2w_s.y) annotation(
    Line(points = {{77.2, 0}, {88, 0}, {88, -80}, {61, -80}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(pu2w_s.u, f_in) annotation(
    Line(points = {{38, -80}, {28, -80}, {28, -90}, {-80, -90}, {-80, -120}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(nominalSpeed.y, pu2w_s.u) annotation(
    Line(points = {{11, -70}, {28, -70}, {28, -80}, {38, -80}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(torque.y, torque_transfer.tau) annotation(
    Line(points = {{-80, 30}, {-94, 30}, {-94, 0}, {-38, 0}}, color = {0, 0, 127}));
  annotation(
    Icon(graphics = {Text(visible = enable_w, extent = {{80, 50}, {100, 30}}, textColor = {0, 0, 0}, textString = "w"), Text(visible = enable_f, extent = {{80, -30}, {100, -50}}, textColor = {0, 0, 0}, textString = "f"), Text(visible = enable_f_in, extent = {{-100, -70}, {-60, -90}}, textColor = {0, 0, 0}, textString = "f_in")}),
Documentation(info = "<html><head></head><body><p>Abstract (partial) base class for including the torque equation:<br> $$ J\frac{d\omega}{dt}=T $$ <br>In the future this base class can replace <font face=\"Courier\">Power2Torque</font> in the turbine models to avoid the issue at zero speed. This class is also better suited for fundamental or mechanistic turbine models.</p></body></html>"));

end TorqueEquation;
