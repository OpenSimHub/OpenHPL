within OpenHPL.Waterway;
model SurgeTank "Model of the surge tank/shaft"
  outer Data data "Using standard data set";
  extends OpenHPL.Icons.Surge(lds=l, Lds=L);
  extends OpenHPL.Interfaces.TwoContacts;
  import Modelica.Constants.pi;

  parameter Types.SurgeTank SurgeTankType = OpenHPL.Types.SurgeTank.STSimple "Types of surge tank" annotation (
    Dialog(group = "Surge tank types"));
  // Geometrical parameters of the surge tank
  parameter SI.Height H = 120 "Vertical component of the length of the surge shaft" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Length L = 140 "Length of the surge shaft" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Diameter D = 3.4 "Diameter of the surge shaft" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Height p_eps = data.p_eps "Pipe roughness height" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Diameter D_so = 1.7 "If Sharp orifice type: Diameter of sharp orifice" annotation (
    Dialog(group = "Geometry",enable=SurgeTankType == OpenHPL.Types.SurgeTank.STSharpOrifice));
  parameter SI.Diameter D_t = 1.7 "If Throttle value type: Diameter of throat" annotation (
    Dialog(group = "Geometry",enable=SurgeTankType == OpenHPL.Types.SurgeTank.STThrottleValve));
  parameter SI.Length L_t = 5 "If Throttle value type: Length of throat" annotation (
    Dialog(group = "Geometry",enable=SurgeTankType == OpenHPL.Types.SurgeTank.STThrottleValve));

  // Condition for steady state
  parameter Boolean SteadyState=data.SteadyState "If true, starts in steady state" annotation (Dialog(group="Initialization"));
  // steady state values for flow rate and water level in surge tank
  parameter SI.VolumeFlowRate Vdot_0 = 0 "Initial volume flow rate in the surge tank" annotation (
    Dialog(group = "Initialization"));
  parameter SI.Height h_0 = 69.9 "Initial water level in the surge tank" annotation (
    Dialog(group = "Initialization"));
  parameter SI.Pressure p_ac = 4*data.p_a "Initial pressure of air-cushion inside the surge tank" annotation (
    Dialog(group = "Initialization",enable=SurgeTankType == OpenHPL.Types.SurgeTank.STAirCushion));
  parameter SI.Temperature T_ac(displayUnit="degC") = 298.15 "Initial air-cushion temperature"
    annotation (Dialog(group = "Initialization", enable=SurgeTankType == OpenHPL.Types.SurgeTank.STAirCushion));
  //possible parameters for temperature variation. Not finished...
  //parameter Boolean TempUse = data.TempUse "If checked - the water temperature is not constant" annotation (Dialog(group = "Initialization"));
  //parameter SI.Temperature T_i = data.T_i "Initial water temperature in the pipe" annotation (Dialog(group = "Initialization", enable = TempUse));
  // variables
  SI.Mass m "Water mass";
  SI.MassFlowRate mdot "Mass flow rate";
  SI.Mass m_a = p_ac*A*(L-h_0/cos_theta)*data.M_a/(Modelica.Constants.R*T_ac) "Air mass inside surge tank";
  SI.Momentum M "Water momentum";
  SI.Force Mdot "Difference in influent and effulent momentum";
  SI.Force F "Total force acting in the surge tank";
  SI.Area A = (pi*D ^ 2) / 4 "Cross sectional area of the surge tank";
  SI.Area A_t = (pi*D_t ^ 2) / 4 "Cross sectional area of the throttle valve surge tank";
  SI.Length l = h / cos_theta "Length of water in the surge tank";
  Real cos_theta = H / L "Slope ratio";
  SI.Velocity v "Water velocity";
  SI.Force F_p "Pressure force";
  SI.Force F_f "Friction force";
  SI.Force F_g "Gravity force";
  SI.Pressure p_t "Pressure at top of the surge tank";
  SI.Pressure p_b "Pressure at bottom of the surge tank";
  Real phiSO "Dimensionless factor based on the type of fitting ";
  // initial values for differential variables
  SI.Height h(start = h_0) "Water height in the surge tank";
  SI.VolumeFlowRate Vdot(start = Vdot_0, fixed=true) "Volume flow rate";
  // variables for temperature. Not in use for now...
  // Real W_f, W_e;
  // connector (acquisition of algebraic variable, mass flow rate mdot, and node pressure (manifold pressure) p_n)

initial equation
  if SteadyState then
    der(M) = 0;
    der(m) = 0;
  else
    h = h_0;
  end if;
equation
   assert( h >= 0, "Water level h in surge tank must be greater than 0!",
    AssertionLevel.error);

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
  p_b = i.p "Linking bottom node pressure to connector";
  i.p = o.p "Inlet and outlet pressure equality";
  mdot = i.mdot+o.mdot "Mass balance";
  F_g = m * data.g * cos_theta;
 annotation (
    Documentation(info="<html>
<h4>Surge Tank Model</h4>

<p>The surge shaft/tank is modeled as a vertical open pipe with constant diameter together with a manifold
connecting the conduit, surge volume, and penstock. Four different surge tank configurations are available:</p>

<ol>
<li><strong>Simple surge tank</strong> - Basic vertical open pipe
<p align=\"center\"><img src=\"modelica://OpenHPL/Resources/Images/STSimple.svg\"></p></li>
<li><strong>Air cushion surge tank</strong> - Includes compressed air chamber
<p align=\"center\"><img src=\"modelica://OpenHPL/Resources/Images/STAirCushion.svg\"></p></li>
<li><strong>Throttle valve surge tank</strong> - With restricted throat section
<p align=\"center\"><img src=\"modelica://OpenHPL/Resources/Images/STSharpOrifice.svg\"></p></li>
<li><strong>Sharp orifice surge tank</strong> - With orifice restriction
<p align=\"center\"><img src=\"modelica://OpenHPL/Resources/Images/STThrottleValve.svg\"></p></li>
</ol>


<h5>Mass and Momentum Balances</h5>

<p>All surge tank types are modeled using mass and momentum balance equations:</p>
<p>$$ \\frac{dm}{dt} = \\dot{m}_\\mathrm{s,in} = \\rho \\dot{V} $$</p>
<p>$$ \\frac{d(mv)}{dt} = \\dot{m}_\\mathrm{i}v_\\mathrm{i} + F_\\mathrm{p} + F_\\mathrm{g} + F_\\mathrm{f} $$</p>

<h5>Water Mass and Geometry</h5>

<p>The water mass in the surge tank is: $$ m = \\rho V = \\rho lA = \\rho A\\frac{h}{\\cos\\theta} $$
where ρ is water density, V is volume, h and l are height and length of water column,
and A = πD²/4 is the cross-sectional area.</p>

<p>Water velocities: $$ v = \\frac{\\dot{V}}{A}, \\quad v_\\mathrm{i} = \\frac{\\dot{V}}{A} $$</p>

<h5>Force Terms</h5>

<p><strong>Pressure force:</strong> $$ F_\\mathrm{p} = A(p_\\mathrm{i} - p^\\mathrm{atm}) $$
where p<sub>i</sub> is inlet pressure and p<sup>atm</sup> is atmospheric pressure.</p>

<p><strong>Gravity force:</strong> $$ F_\\mathrm{g} = m g \\cos\\theta $$
where θ = arccos(H/L) is the slope angle.</p>

<p><strong>Friction force:</strong> $$ F_\\mathrm{f} = -\\frac{1}{8}lf_\\mathrm{D}\\pi\\rho Dv|v| $$
calculated using the Darcy friction factor f<sub>D,s</sub>.</p>

<h5>Manifold Connection</h5>

<p>The manifold preserves mass in steady-state: $$ \\dot{V}_\\mathrm{i} = \\dot{V}_\\mathrm{p} + \\dot{V} $$
The manifold pressure is equal for all three connections. This is implemented via <code>ContactNode</code> connectors.</p>



<h5>Parameters and Initialization</h5>

<p>Required geometry parameters: length L, height H, diameter D,
roughness p<sub>ε</sub>, and atmospheric pressure p<sup>atm</sup>. Initialize with flow rate V̇<sub>0</sub>
and water height h<sub>0</sub>. Option for steady-state initialization is available.</p>

<h5>More Information</h5>
<p>More details in <a href=\"modelica://OpenHPL.UsersGuide.References\">[Splavska2017]</a>.</p>
</html>"));
end SurgeTank;
