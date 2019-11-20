within OpenHPL.Waterway;
model SurgeTank "Model of the surge tank/shaft"
  outer Parameters Const "using standard class with constants";
  extends OpenHPL.Icons.Surge;
  import Modelica.Constants.pi;
  //// geometrical parameters of surge tank
  parameter Modelica.SIunits.Height H = 120 "Vertical component of the length of the surge shaft" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Length L = 140 "Length of the surge shaft" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter D = 3.4 "Diameter of the surge shaft" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Height eps = Const.eps "Pipe roughness height" annotation (
    Dialog(group = "Geometry"));
  //// condition for steady state
  parameter Boolean SteadyState = Const.Steady "if true - starts from Steady State" annotation (
    Dialog(group = "Initialization"));
  //// steady state values for flow rate and water level in surge tank
  parameter Modelica.SIunits.VolumeFlowRate V_dot0 = 0 "Initial flow rate in the surge tank" annotation (
    Dialog(group = "Initialization"));
  parameter Modelica.SIunits.Height h_0 = 75 "Initial water height in the surge tank" annotation (
    Dialog(group = "Initialization"));
  //// output pressure in surge tank (atmpspheric pressure for open surge tank)
  input Modelica.SIunits.Pressure p_2 = Const.p_a "Pressure in the top of the surge tank" annotation (
    Dialog(group = "Geometry"));
  //// possible parameters for temperature variation. Not finished...
  //parameter Boolean TempUse = Const.TempUse "If checked - the water temperature is not constant" annotation (Dialog(group = "Initialization"));
  //parameter Modelica.SIunits.Temperature T_i = Const.T_i "Initial water temperature in the pipe" annotation (Dialog(group = "Initialization", enable = TempUse));
  //// variables
  Modelica.SIunits.Mass m "water mass";
  Modelica.SIunits.Velocity v "water velocity";
  Modelica.SIunits.Area A = D ^ 2 * pi / 4 "cross section area";
  Modelica.SIunits.Length l = h / cos_theta "length of water in the surge tank";
  Real cos_theta = H / L "slope ratio";
  Modelica.SIunits.Force F_f "friction force";
  Modelica.SIunits.Momentum M "water momuntum";
  Modelica.SIunits.Height h(start = h_0) "water height in the surge tank";
  Modelica.SIunits.VolumeFlowRate V_dot(start = V_dot0) "water flow rate";
  //// variables for temperature. Not in use for now...
  //Real W_f, W_e;
  //// conector
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
  //// volumetric and mass flow rate through the surge tank
  V_dot = m_dot / Const.rho;
  //// mass of water in the surge tank
  m = Const.rho * A * l;
  //// mass balance
  der(m) = m_dot;
  //// velocity and momentum of the water
  v = V_dot / A;
  M = m * v;
  //// friction force
  F_f = Functions.DarcyFriction.Friction(v, D, l, Const.rho, Const.mu, eps);
  //F_f = 0.5*pi*1/(2*log10(eps/3.7/D + 5.74/(Const.rho*abs(v)*D/Const.mu + 1e-3)^0.9))^2*Const.rho*l*v*abs(v)*D/4;
  //// momentum balance
  der(M) = Const.rho * V_dot ^ 2 / A + (p_n - p_2) * A - F_f - m * Const.g * cos_theta;
  //// possible temperature variation implementation. Not finished...
  //W_f = -F_f * v;
  //W_e = V_dot * (p_n - p_2);
  //if TempUse == true then
  //Const.c_p * m * der(T_n) = V_dot * Const.rho * Const.c_p * (T_n - T_i)+ W_e - W_f;
  //0 = V_dot * Const.rho * Const.c_p * (T_n - T_i)+ W_e - W_f;
  //der(T_n)=0;
  //else
  //der(T_n)=0;
  //end if;
  ////
  annotation (
    Documentation(info = "<html><head></head><body><p>The simple model of the surge tank, which described by the momentum and mass differential equations. The mass balance depends on inlet and outlet mass flow rates. The momentum balance depends on inlet momentum to and pressure dorp through the surge pipe together with gravity and friction forces. The main defined variable are <i>V_dot_s</i> and <i>h_s&nbsp;</i>(the flow rate and water level in the surge tank).</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/surgepic.png\"></p><p>More details about the surge tank model:&nbsp;<a href=\"http://www.ep.liu.se/ecp/article.asp?article=049&amp;issue=138&amp;volume=\">http://www.ep.liu.se/ecp/article.asp?article=049&amp;issue=138&amp;volume=</a></p>
</body></html>"));
end SurgeTank;
