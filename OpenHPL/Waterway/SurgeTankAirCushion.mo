within OpenHPL.Waterway;
model SurgeTankAirCushion "Model of air-cushion surge tank"
  outer Parameters para "Parameters";
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
  parameter Boolean SteadyState = para.Steady "If true - starts from Steady State" annotation (
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
  Modelica.SIunits.Mass m "Water mass";
  Modelica.SIunits.Mass m_a = p_c0*A*(L-h_0/cos_theta)*para.M_a/(para.R*para.T_0) "Air mass inside surge tank";
  Modelica.SIunits.Momentum M "Water momuntum";
  Modelica.SIunits.Force M_dot "Difference in influent and effulent momentum";
  Modelica.SIunits.Force F "Total force acting in the surge tank";
  Modelica.SIunits.Area A = (pi*D ^ 2) / 4 "Cross sectional area of the surge tank";
  Modelica.SIunits.Length l = h / cos_theta "Length of water in the surge tank";
  Real cos_theta = H / L "Slope ratio";
  Modelica.SIunits.Velocity v "Water velocity";
  Modelica.SIunits.Force F_p "Pressure force";
  Modelica.SIunits.Force F_f "Friction force";
  Modelica.SIunits.Force F_g "Gravity force";
  Modelica.SIunits.Pressure p_c "Air-cushion pressure";
  //// initial values for differential variables
  Modelica.SIunits.Height h(start = h_0, fixed = true) "Water height in the surge tank";
  Modelica.SIunits.VolumeFlowRate V_dot(start = V_dot0, fixed = true) "Water flow rate";
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
  der(m) = m_dot "Mass balance";
  der(M) = M_dot+F "Momentum balance";

  m = para.rho * A * l+m_a;
  m_dot = para.rho*V_dot;

  M = m * v;
  v = V_dot / A;
  M_dot = m_dot*v;
  F = F_p-F_f-F_g;
  F_p = (p_n - p_c)*A;
  p_c = p_c0*((L-h_0/cos_theta)/(L-l))^para.gamma_air;
  F_f = Functions.DarcyFriction.Friction(v, D, l, para.rho, para.mu, eps);
  F_g = m * para.g * cos_theta;
 annotation (
    Documentation(info="<html>
<p>The simple model of the air-cushion surge tank, which is described by the momentum and mass balance differential equations. The mass balance depends on inlet and outlet mass flow rates. The momentum balance depends on inlet momentum and pressure dorp through the surge pipe together with gravity and friction forces. The main defined variable are <code>V_dot</code> and <code>h </code>(the flow rate and water level in the surge tank). The air in the surge tank is taken at inital pressure of <code>p_c0.</code></p>
<p><img src=\"modelica://OpenHPL/Resources/Images/SurgeTankAirCushion.svg\"/></p>
<p>The simple surge tank model can be found in this link: <a href=\"modelica://OpenHPL.UsersGuide.References\">OpenHPL.UsersGuide.References>[Valen2017]</a> </p>
</html>"));
end SurgeTankAirCushion;
