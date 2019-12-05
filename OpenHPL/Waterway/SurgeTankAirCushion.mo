within OpenHPL.Waterway;
model SurgeTankAirCushion "Model of surge tanks"
  outer Parameters para "Parameters";
  extends OpenHPL.Icons.Surge;
  import Modelica.Constants.pi;

  parameter Types.SurgeTank surge_tank_type = OpenHPL.Types.SurgeTank.STSimple "Types of surge tank" annotation (
    Dialog(group = "Surge tank types"));
  // Geometrical parameters of the surge tank
  parameter Modelica.SIunits.Height H = 120 "Vertical component of the length of the surge shaft" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Length L = 140 "Length of the surge shaft" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter D = 3.4 "Diameter of the surge shaft" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Height eps = para.eps "Pipe roughness height" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter D_so = 1.7 "If Sharp orifice type: Diameter of sharp orifice" annotation (
    Dialog(group = "Geometry",enable=surge_tank_type == OpenHPL.Types.SurgeTank.STSharpOrifice));
  parameter Modelica.SIunits.Diameter D_t = 1.7 "If Throttle value type: Diameter of throat" annotation (
    Dialog(group = "Geometry",enable=surge_tank_type == OpenHPL.Types.SurgeTank.STThrottleValve));
  parameter Modelica.SIunits.Diameter L_t = 5 "If Throttle Value type: Diameter of throat" annotation (
    Dialog(group = "Geometry",enable=surge_tank_type == OpenHPL.Types.SurgeTank.STThrottleValve));

  // Condition for steady state
  parameter Boolean SteadyState = para.Steady "If true - starts from Steady State" annotation (
    Dialog(group = "Initialization"));
  // steady state values for flow rate and water level in surge tank
  parameter Modelica.SIunits.VolumeFlowRate V_dot0 = 0 "Initial flow rate in the surge tank" annotation (
    Dialog(group = "Initialization"));
  parameter Modelica.SIunits.Height h_0 = 69.9 "Initial water height in the surge tank" annotation (
    Dialog(group = "Initialization"));
  parameter Modelica.SIunits.Pressure p_ac = 4*para.p_a "Initial pressure of air-cushion inside the surge tank" annotation (
    Dialog(group = "Initialization",enable=surge_tank_type == OpenHPL.Types.SurgeTank.STAirCushion));
  //possible parameters for temperature variation. Not finished...
  //parameter Boolean TempUse = para.TempUse "If checked - the water temperature is not constant" annotation (Dialog(group = "Initialization"));
  //parameter Modelica.SIunits.Temperature T_i = para.T_i "Initial water temperature in the pipe" annotation (Dialog(group = "Initialization", enable = TempUse));
  //// variables
  Modelica.SIunits.Mass m "Water mass";
  Modelica.SIunits.Mass m_a = p_ac*A*(L-h_0/cos_theta)*para.M_a/(para.R*para.T_0) "Air mass inside surge tank";
  Modelica.SIunits.Momentum M "Water momuntum";
  Modelica.SIunits.Force M_dot "Difference in influent and effulent momentum";
  Modelica.SIunits.Force F "Total force acting in the surge tank";
  Modelica.SIunits.Area A = (pi*D ^ 2) / 4 "Cross sectional area of the surge tank";
  Modelica.SIunits.Area A_t = (pi*D_t ^ 2) / 4 "Cross sectional area of the throttle valve surge tank";
  Modelica.SIunits.Length l = h / cos_theta "Length of water in the surge tank";
  Real cos_theta = H / L "Slope ratio";
  Modelica.SIunits.Velocity v "Water velocity";
  Modelica.SIunits.Force F_p "Pressure force";
  Modelica.SIunits.Force F_f "Friction force";
  Modelica.SIunits.Force F_g "Gravity force";
  Modelica.SIunits.Pressure p_t "Pressure at top of the surge tank";
  Modelica.SIunits.Pressure p_b "Pressure at bottom of the surge tank";
  Real phiSO "Dimensionless factor based on the type of fitting ";
  // initial values for differential variables
  Modelica.SIunits.Height h(start = h_0, fixed = true) "Water height in the surge tank";
  Modelica.SIunits.VolumeFlowRate V_dot(start = V_dot0, fixed = true) "Water flow rate";
  // variables for temperature. Not in use for now...
  // Real W_f, W_e;
  // conector (acquisition of algebraic variable, mass flow rate m_dot, and node pressure (manifold pressure) p_n)
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

  if surge_tank_type == OpenHPL.Types.SurgeTank.STSimple then
    m = para.rho * A * l;
    p_t = para.p_a;
    F_f = Functions.DarcyFriction.Friction(v, D, l, para.rho, para.mu, eps)+A*phiSO*0.5 * para.rho * abs(v) * v;
    phiSO = 0;
  elseif  surge_tank_type == OpenHPL.Types.SurgeTank.STAirCushion then
    m = para.rho * A * l+m_a;
    p_t = p_ac*((L-h_0/cos_theta)/(L-l))^para.gamma_air;
    F_f = Functions.DarcyFriction.Friction(v, D, l, para.rho, para.mu, eps)+A*phiSO*0.5 * para.rho * abs(v) * v;
    phiSO = 0;
  elseif  surge_tank_type == OpenHPL.Types.SurgeTank.STSharpOrifice then
    m = para.rho * A * l;
    p_t = para.p_a;
    F_f = Functions.DarcyFriction.Friction(v, D, l, para.rho, para.mu, eps)+ A*phiSO*0.5 * para.rho * abs(v) * v;
    if v>=0 then
      phiSO = Functions.Fitting.FittingPhi(v,D,D_so,L,90,para.rho,para.mu,para.eps,OpenHPL.Types.Fitting.SharpOrifice);
    else
      phiSO = Functions.Fitting.FittingPhi(v,D_so,D,L,90,para.rho,para.mu,para.eps,OpenHPL.Types.Fitting.SharpOrifice);
    end if;
  elseif  surge_tank_type == OpenHPL.Types.SurgeTank.STThrottleValve then
    if l<=L_t then
      m = para.rho*A_t*l;
      F_f = Functions.DarcyFriction.Friction(v, D_t, l, para.rho, para.mu, eps)+ A_t*phiSO*0.5 * para.rho * abs(v) * v;
      phiSO = 0;
    else
      m = para.rho*(A_t*L_t+A*(l-L_t));
      if v>=0 then
        F_f = Functions.DarcyFriction.Friction(v, D_t, L_t, para.rho, para.mu, eps)
            +Functions.DarcyFriction.Friction(v, D, l-L_t, para.rho, para.mu, eps)+ A_t*phiSO*0.5 * para.rho * abs(v) * v;
        phiSO = Functions.Fitting.FittingPhi(v,D_t,D,L,90,para.rho,para.mu,para.eps,OpenHPL.Types.Fitting.Square);
      else
        F_f = Functions.DarcyFriction.Friction(v, D_t, L_t, para.rho, para.mu, eps)
            +Functions.DarcyFriction.Friction(v, D, l-L_t, para.rho, para.mu, eps)+ A*phiSO*0.5 * para.rho * abs(v) * v;
        phiSO = Functions.Fitting.FittingPhi(v,D,D_t,L,90,para.rho,para.mu,para.eps,OpenHPL.Types.Fitting.Square);
      end if;
    end if;
    p_t = para.p_a;
  end if;
  m_dot = para.rho*V_dot;
  M = m * v;
  v = V_dot / A;
  M_dot = m_dot*v;
  F = F_p-F_f-F_g;
  F_p = (p_b - p_t)*A;
  p_b = p_n "Linking bottom node pressure to connector";
  F_g = m * para.g * cos_theta;
 annotation (
    Documentation(info="<html>
<p>The four different surge tank models can be choosen. These surge tanks are:</p>
<ol>
<li>Simple surge tank</li>
<li>Air cushion surge tank</li>
<li>Throttle valve surge tank</li>
<li>Sharp orifice surge tank</li>
</ol>
<p>All of the surge tanks are modeled using mass and momemtum balance. </p>
<p>The air cushion surge tank is shown below:</p>
<p><span style=\"font-family: Courier New;\">￼</span></p>
<p><img src=\"modelica://OpenHPL/Resources/Images/SurgeTankAirCushion.svg\"/></p>
<p>The throttle valve surge tank and sharp orifice type surge tank are shown below:</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/ThrottleValveSurgeTank.png\"/></p>
<p><img src=\"modelica://OpenHPL/Resources/Images/SharpOrificeSurgeTank.png\"/></p>
<p>The simple surge tank model can be found in this link: <a href=\"modelica://OpenHPL.UsersGuide.References\">OpenHPL.UsersGuide.References&gt;[Valen2017]</a> </p>
</html>"));
end SurgeTankAirCushion;
