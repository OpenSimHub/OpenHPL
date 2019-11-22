within OpenHPL.Waterway;
model AirCushionSurgeTank "Model of air-cushion surge tank"
  outer Parameters para "using standard class with constants";
  extends OpenHPL.Icons.Surge;
  import Modelica.Constants.pi;
  //// geometrical parameters of air-cushion surge tank
  parameter Modelica.SIunits.Height H = 10.5 "Vertical component of the length of the surge shaft" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Length L = 12.12 "Length of the surge shaft" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter D = 50.47 "Diameter of the surge shaft" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Height eps = para.eps "Pipe roughness height" annotation (
    Dialog(group = "Geometry"));
  //// condition for steady state
  parameter Boolean SteadyState = para.Steady "if true - starts from Steady State" annotation (
    Dialog(group = "Initialization"));
  //// steady state values for flow rate and water level in surge tank
  parameter Modelica.SIunits.VolumeFlowRate V_dot0 = 0 "Initial flow rate in the surge tank" annotation (
    Dialog(group = "Initialization"));
  parameter Modelica.SIunits.Height h_0 = 2 "Initial water height in the surge tank" annotation (
    Dialog(group = "Initialization"));
  input Modelica.SIunits.Pressure p_c0 = 4*para.p_a "Initial pressure of air-cushion inside the surge tank" annotation (
    Dialog(group = "Geometry"));
  //// possible parameters for temperature variation. Not finished...
  //parameter Boolean TempUse = para.TempUse "If checked - the water temperature is not constant" annotation (Dialog(group = "Initialization"));
  //parameter Modelica.SIunits.Temperature T_i = para.T_i "Initial water temperature in the pipe" annotation (Dialog(group = "Initialization", enable = TempUse));
  //// variables
  Modelica.SIunits.Mass m "water mass";
  Modelica.SIunits.Momentum M "water momuntum";
  Modelica.SIunits.Force M_dot "difference in influent and effulent momentum";
  Modelica.SIunits.Force F "total force acting in the surge tank";
  Modelica.SIunits.Area A = (pi*D ^ 2) / 4 "cross sectional area of the surge tank";
  Modelica.SIunits.Length l = h / cos_theta "length of water in the surge tank";
  Real cos_theta = H / L "slope ratio";
  Modelica.SIunits.Velocity v "water velocity";
  Modelica.SIunits.Force F_p "pressure force";
  Modelica.SIunits.Force F_f "friction force";
  Modelica.SIunits.Force F_g "friction force";
  Modelica.SIunits.Pressure p_c "air-cushion force";
  //// initial values for differential variables
  Modelica.SIunits.Height h(start = h_0, fixed = true) "water height in the surge tank";
  Modelica.SIunits.VolumeFlowRate V_dot(start = V_dot0, fixed = true) "water flow rate";
  //// variables for temperature. Not in use for now...
  //Real W_f, W_e;
  //// conector (acquisition of algebraic variable, mass flow rate m_dot, and node pressure (manifold pressure) p_n)
  extends OpenHPL.Interfaces.ContactNode;
initial equation
  if SteadyState == true then
    der(M) = 0;
    der(m) = 0;
    //der(T_n) = 0;
  else
    h = h_0;
    V_dot = V_dot0;
    //T_n = T_i;
  end if;
equation
  //// mass and momentum balance
  der(m) = m_dot;
  der(M) = M_dot+F;

  m = para.rho * A * l;
  m_dot = para.rho*V_dot;

  M = m * v;
  v = V_dot / A;
  M_dot = m_dot*v;
  F = F_p-F_f-F_g;
  F_p = (p_n - p_c)*A;
  F_f = Functions.DarcyFriction.Friction(v, D, l, para.rho, para.mu, eps);
  F_g = m * para.g * cos_theta;
 annotation (
    Documentation(info="<html>
<p>The simple model of the air cushion surge tank, which described by the momentum and mass differential equations. The mass balance depends on inlet and outlet mass flow rates. The momentum balance depends on inlet momentum and pressure dorp through the surge pipe together with gravity and friction forces. The main defined variable are <i>V_dot_s</i> and <i>h_s&nbsp;</i>(the flow rate and water level in the surge tank). The air in the surge tank is taken at inital pressure of <i>p_2</i></p>
<p><img src=\"modelica://OpenHPL/Resources/Images/surgepic.png\"/></p>
<p>More details about the surge tank model:&nbsp;<a href=\"http://www.ep.liu.se/ecp/article.asp?article=049&issue=138&volume=\">http://www.ep.liu.se/ecp/article.asp?article=049&amp;issue=138&amp;volume=</a></p>
</html>"));
end AirCushionSurgeTank;
