within OpenHPL.ElectroMech.BaseClasses;
partial model Power2Torque "Converts a power signal to a torque in the rotational domain"
  extends TorqueEquation;
  outer Data data "Using standard class with global parameters";
  parameter Boolean useH = false "If checked, calculate the inertia from a given H value" annotation(
    Dialog(group = "Mechanical"),
    choices(checkBox = true));
  parameter Modelica.Units.SI.Power Pmax = 100e6 "Maximum rated power (for torque limiting and H calculation)" annotation(
    Dialog(group = "Mechanical"));
  parameter Modelica.Units.SI.Time H = 2.75 "Inertia constant H, typical 2s (high-head hydro) to 6s (gas or low-head hydro) production units" annotation(
    Dialog(group = "Mechanical", enable = useH));
  parameter Modelica.Units.SI.MomentOfInertia J = 2e5 "Moment of inertia of the unit" annotation(
    Dialog(group = "Mechanical", enable = not useH));
  parameter Integer p(min = 2) = 12 "Number of poles for mechanical speed calculation" annotation(
    Dialog(group = "Mechanical"),
    choices(choice = 2 "2,[3000|3600] rpm", choice = 4 "4,[1500|1800] rpm", choice = 6 "6,[1000|1200] rpm", choice = 8 "8,[750|900] rpm", choice = 10 "10,[600|720] rpm", choice = 12 "12,[500|600] rpm", choice = 14 "14,[429|514] rpm", choice = 16 "16,[375|450] rpm", choice = 18 "18,[333|400] rpm", choice = 20 "20,[300|360] rpm", choice = 22 "22,[273|327] rpm", choice = 24 "24,[250|300] rpm", choice = 26 "26,[231|277] rpm", choice = 28 "28,[214|257] rpm", choice = 30 "30,[200|240] rpm", choice = 28 "32,[187.5|225] rpm"));
  parameter Modelica.Units.SI.Power Ploss = 0 "Friction losses of the unit at nominal speed" annotation(
    Dialog(group = "Mechanical"));
  parameter Modelica.Units.SI.PerUnit f_0 = 1 "Initial speed of the unit" annotation(
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
  Modelica.Blocks.Math.Division power2torque annotation(
    Placement(transformation(extent = {{-76, -6}, {-64, 6}})));
  Modelica.Blocks.Nonlinear.Limiter div0protect(uMax = Modelica.Constants.inf, uMin = Modelica.Constants.small) annotation(
    Placement(transformation(extent = {{-6, -6}, {6, 6}}, rotation = 180, origin = {-50, -40})));
  Modelica.Blocks.Nonlinear.Limiter torqueLimit(uMax=Pmax/(2*C.pi*f_nom))
                                                                 annotation (
    Placement(transformation(extent = {{6, 6}, {-6, -6}}, rotation = 180, origin = {-50, 0})));
  Modelica.Blocks.Sources.RealExpression power annotation(
    Placement(transformation(extent = {{-60, 20}, {-80, 40}})));
equation
  connect(div0protect.y, power2torque.u2) annotation(
    Line(points = {{-56.6, -40}, {-88, -40}, {-88, -3.6}, {-77.2, -3.6}}, color = {0, 0, 127}));
  connect(power2torque.y, torqueLimit.u) annotation(
    Line(points = {{-63.4, 0}, {-64, 0}, {-64, 8.88178e-16}, {-57.2, 8.88178e-16}}, color = {0, 0, 127}));
  connect(power.y, power2torque.u1) annotation(
    Line(points = {{-81, 30}, {-88, 30}, {-88, 3.6}, {-77.2, 3.6}}, color = {0, 0, 127}));
  connect(torqueLimit.y, torque.tau) annotation(
    Line(points = {{-44, 0}, {-38, 0}}, color = {0, 0, 127}));
  connect(div0protect.u, speedSensor.w) annotation(
    Line(points = {{-42, -40}, {10, -40}, {10, -30}}, color = {0, 0, 127}));
  annotation(
    Icon(graphics = {Text(visible = enable_w, extent = {{80, 50}, {100, 30}}, textColor = {0, 0, 0}, textString = "w"), Text(visible = enable_f, extent = {{80, -30}, {100, -50}}, textColor = {0, 0, 0}, textString = "f"), Text(visible = enable_f_in, extent = {{-100, -70}, {-60, -90}}, textColor = {0, 0, 0}, textString = "f_in")}));
end Power2Torque;
