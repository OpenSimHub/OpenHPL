within OpenHPL.Waterway;
model SurgeTank "Model of the surge tank/shaft"
  outer Data data "Using standard data set";
  extends OpenHPL.Icons.Surge;
  import Modelica.Constants.pi;

  parameter Types.SurgeTank SurgeTankType = OpenHPL.Types.SurgeTank.STSimple "Types of surge tank" annotation (
    Dialog(group = "Surge tank types"));
  // Geometrical parameters of the surge tank
  parameter Modelica.SIunits.Height H = 120 "Vertical component of the length of the surge shaft" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Length L = 140 "Length of the surge shaft" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter D = 3.4 "Diameter of the surge shaft" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Height p_eps = data.p_eps "Pipe roughness height" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter D_so = 1.7 "If Sharp orifice type: Diameter of sharp orifice" annotation (
    Dialog(group = "Geometry",enable=SurgeTankType == OpenHPL.Types.SurgeTank.STSharpOrifice));
  parameter Modelica.SIunits.Diameter D_t = 1.7 "If Throttle value type: Diameter of throat" annotation (
    Dialog(group = "Geometry",enable=SurgeTankType == OpenHPL.Types.SurgeTank.STThrottleValve));
  parameter Modelica.SIunits.Diameter L_t = 5 "If Throttle value type: Diameter of throat" annotation (
    Dialog(group = "Geometry",enable=SurgeTankType == OpenHPL.Types.SurgeTank.STThrottleValve));

  // Condition for steady state
  parameter Boolean SteadyState = data.Steady "If true - starts from Steady State" annotation (
    Dialog(group = "Initialization"));
  // steady state values for flow rate and water level in surge tank
  parameter Modelica.SIunits.VolumeFlowRate Vdot_0 = 0 "Initial flow rate in the surge tank" annotation (
    Dialog(group = "Initialization"));
  parameter Modelica.SIunits.Height h_0 = 69.9 "Initial water height in the surge tank" annotation (
    Dialog(group = "Initialization"));
  parameter Modelica.SIunits.Pressure p_ac = 4*data.p_a "Initial pressure of air-cushion inside the surge tank" annotation (
    Dialog(group = "Initialization",enable=SurgeTankType == OpenHPL.Types.SurgeTank.STAirCushion));
  parameter Modelica.SIunits.Temperature T_ac(displayUnit="degC") = 298.15 "Initial air-cushion temperature"
    annotation (Dialog(group = "Initialization", enable=SurgeTankType == OpenHPL.Types.SurgeTank.STAirCushion));
  //possible parameters for temperature variation. Not finished...
  //parameter Boolean TempUse = data.TempUse "If checked - the water temperature is not constant" annotation (Dialog(group = "Initialization"));
  //parameter Modelica.SIunits.Temperature T_i = data.T_i "Initial water temperature in the pipe" annotation (Dialog(group = "Initialization", enable = TempUse));
  //// variables
  Modelica.SIunits.Mass m "Water mass";
  Modelica.SIunits.Mass m_a = p_ac*A*(L-h_0/cos_theta)*data.M_a/(Modelica.Constants.R*T_ac) "Air mass inside surge tank";
  Modelica.SIunits.Momentum M "Water momuntum";
  Modelica.SIunits.Force Mdot "Difference in influent and effulent momentum";
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
  Modelica.SIunits.Height h(start = h_0) "Water height in the surge tank";
  Modelica.SIunits.VolumeFlowRate Vdot(start = Vdot_0) "Water flow rate";
  // variables for temperature. Not in use for now...
  // Real W_f, W_e;
  // connector (acquisition of algebraic variable, mass flow rate mdot, and node pressure (manifold pressure) p_n)
  extends OpenHPL.Interfaces.ContactNode;
initial equation
  if SteadyState then
    der(M) = 0;
    der(m) = 0;
  else
    h = h_0;
  end if;
equation
  der(m) = mdot "Mass balance";
  der(M) = Mdot+F "Momentum balance";

  if SurgeTankType == OpenHPL.Types.SurgeTank.STSimple then
    v = Vdot / A;
    m = data.rho * A * l;
    M = m * v;
    p_t = data.p_a;
    F_f = Functions.DarcyFriction.Friction(v, D, l, data.rho, data.mu, p_eps) + A * phiSO * 0.5 * data.rho * abs(v) * v;
    phiSO = 0;
    F_p = (p_b - p_t) * A;
  elseif SurgeTankType == OpenHPL.Types.SurgeTank.STAirCushion then
    v = Vdot / A;
    m = data.rho * A * l + m_a;
    M = m * v;
    p_t = p_ac * ((L - h_0 / cos_theta) / (L - l)) ^ data.gamma_air;
    F_f = Functions.DarcyFriction.Friction(v, D, l, data.rho, data.mu, p_eps) + A * phiSO * 0.5 * data.rho * abs(v) * v;
    phiSO = 0;
    F_p = (p_b - p_t) * A;
  elseif SurgeTankType == OpenHPL.Types.SurgeTank.STSharpOrifice then
    v = Vdot / A;
    m = data.rho * A * l;
    M = m * v;
    p_t = data.p_a;
    F_f = Functions.DarcyFriction.Friction(v, D, l, data.rho, data.mu, p_eps) + A * phiSO * 0.5 * data.rho * abs(v) * v;
    F_p = (p_b - p_t) * A;
    if v >= 0 then
      phiSO = Functions.Fitting.FittingPhi(v, D, D_so, L, 90, data.rho, data.mu, data.p_eps, OpenHPL.Types.Fitting.SharpOrifice);
    else
      phiSO = Functions.Fitting.FittingPhi(v, D_so, D, L, 90, data.rho, data.mu, data.p_eps, OpenHPL.Types.Fitting.SharpOrifice);
    end if;
  elseif SurgeTankType == OpenHPL.Types.SurgeTank.STThrottleValve then
    if l <= L_t then
      v = Vdot / A_t;
      m = data.rho * A_t * l;
      M = m * v;
      F_f = Functions.DarcyFriction.Friction(v, D_t, l, data.rho, data.mu, p_eps) + A_t * phiSO * 0.5 * data.rho * abs(v) * v;
      phiSO = 0;
      F_p = (p_b - p_t) * A;
    else
      v = Vdot * (1 / A_t + 1 / A) / 2;
      m = data.rho * (A_t * L_t + A * (l - L_t));
      M = data.rho * (A_t * L_t*Vdot/A_t + A * (l - L_t)*Vdot/A);
      if v > 0 then
        F_f = Functions.DarcyFriction.Friction(Vdot/A_t, D_t, L_t, data.rho, data.mu, p_eps) + Functions.DarcyFriction.Friction(Vdot/A, D, l - L_t, data.rho, data.mu, p_eps) + A_t * phiSO * 0.5 * data.rho * abs(Vdot/A_t) * Vdot/A_t;
        phiSO = Functions.Fitting.FittingPhi(Vdot/A_t, D_t, D, L, 90, data.rho, data.mu, data.p_eps, OpenHPL.Types.Fitting.Square);
      elseif v < 0 then
        F_f = Functions.DarcyFriction.Friction(Vdot/A_t, D_t, L_t, data.rho, data.mu, p_eps) + Functions.DarcyFriction.Friction(Vdot/A, D, l - L_t, data.rho, data.mu, p_eps) + A * phiSO * 0.5 * data.rho * abs(Vdot/A) * Vdot/A;
        phiSO = Functions.Fitting.FittingPhi(Vdot/A, D, D_t, L, 90, data.rho, data.mu, data.p_eps, OpenHPL.Types.Fitting.Square);
      else
        F_f = 0;
        phiSO = 0;
      end if;
      F_p = (p_b - (p_t+data.rho*data.g*(l-L_t))) * A_t+(p_t+data.rho*data.g*(l-L_t)-p_t)*A;
    end if;
    p_t = data.p_a;
  end if;
  mdot = data.rho * Vdot;
  Mdot = mdot * v;
  F = F_p - F_f - F_g;
  p_b = p_n "Linking bottom node pressure to connector";
  F_g = m * data.g * cos_theta;
 annotation (
    Documentation(info="<html>
<p>The four different surge tank models can be chosen. </p>
<p>These surge tanks are:</p>
<ol>
<li>Simple surge tank</li>
<li>Air cushion surge tank</li>
<li>Throttle valve surge tank</li>
<li>Sharp orifice surge tank</li>
</ol>
<p>All of the surge tanks are modeled using mass and momemtum balance. </p>
<p>All of the surge tank can be shown below. </p>

<p>This simple surge tank is shown below.</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/STSimple.svg\"/></p>

<p>The air cushion surge tank is shown below:</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/STAirCushion.svg\"/></p>

<p>This sharp orifice surge tank is shown below.</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/STSharpOrifice.svg\"/></p>

<p>The throttle valve surge tank is shown below:</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/STThrottleValve.svg\"/></p>

<p>The simple surge tank model can be found in this link: <a href=\"modelica://OpenHPL.UsersGuide.References\">OpenHPL.UsersGuide.References&gt;[Valen2017]</a> </p>
</html>"));
end SurgeTank;
