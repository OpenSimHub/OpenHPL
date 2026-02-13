within OpenHPL.Waterway;
model Pipe "Model of a pipe"
  outer Data data "Using standard data set";
  extends OpenHPL.Icons.Pipe;
  extends OpenHPL.Interfaces.TwoContacts;

  // Geometrical parameters of the pipe:
  parameter SI.Length H = 0 "Height difference from the inlet to the outlet" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Length L = 1000 "Length of the pipe" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Diameter D_i = 1.0 "Diameter of the inlet side" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Diameter D_o = D_i "Diameter of the outlet side" annotation (
    Dialog(group = "Geometry"));

  // Friction specification:
  parameter Types.FrictionMethod friction_method = Types.FrictionMethod.PipeRoughness "Method for specifying pipe friction" annotation (
    Dialog(group = "Friction"));
  parameter SI.Height p_eps_input = data.p_eps "Pipe roughness height (absolute)" annotation (
    Dialog(group = "Friction", enable = friction_method == Types.FrictionMethod.PipeRoughness));
  parameter Real f_moody(min=0) = 0.02 "Moody friction factor (dimensionless, typically 0.01-0.05)" annotation (
    Dialog(group = "Friction", enable = friction_method == Types.FrictionMethod.MoodyFriction));
  parameter Real m_manning(unit="m(1/3)/s", min=0) = 40 "Manning M (Strickler) coefficient M=1/n (typically 60-110 for steel, 30-60 for rock tunnels)" annotation (
    Dialog(group = "Friction", enable = friction_method == Types.FrictionMethod.ManningFriction and not use_n));
  parameter Boolean use_n = false "If true, use Mannings coefficient n (=1/M) instead of Manning's M (Strickler)" annotation (
    Dialog(group = "Friction", enable = friction_method == Types.FrictionMethod.ManningFriction), choices(checkBox=true));
  parameter Real n_manning(unit="s/m(1/3)", min=0) = 0.025 "Manning's n coefficient (typically 0.009-0.017 for steel/concrete, 0.017-0.030 for rock tunnels)" annotation (
    Dialog(group = "Friction", enable = friction_method == Types.FrictionMethod.ManningFriction and use_n));


  // Steady state:
  parameter Boolean SteadyState=data.SteadyState "If true, starts in steady state" annotation (Dialog(group="Initialization"));
  parameter SI.VolumeFlowRate Vdot_0=data.Vdot_0 "Initial flow rate of the pipe" annotation (Dialog(group="Initialization"));

  SI.Velocity v "Average Water velocity";
  SI.Force F_f "Friction force";
  SI.Pressure p_i "Inlet pressure";
  SI.Pressure p_o "Outlet pressure";
  SI.Pressure dp=p_o-p_i "Pressure difference across the pipe";
  SI.MassFlowRate mdot "Mass flow rate";
  SI.VolumeFlowRate Vdot "Volume flow rate";

protected
    parameter Real n_eff = if use_n then n_manning else 1/m_manning "Effective Manning's n coefficient";
    parameter SI.Height p_eps = if friction_method == Types.FrictionMethod.PipeRoughness then p_eps_input
                                 elseif friction_method == Types.FrictionMethod.MoodyFriction then 3.7 * D_ * 10^(-1/(2*sqrt(f_moody)))
                                 else D_*3.0971 *exp(-0.118/n_eff) "Equivalent pipe roughness height";
    parameter SI.Diameter D_ = ( D_i + D_o)  / 2 "Average diameter";
    parameter SI.Area A_i = D_i ^ 2 * C.pi / 4 "Inlet cross-sectional area";
    parameter SI.Area A_o = D_o ^ 2 * C.pi / 4 "Outlet cross-sectional area";
    parameter SI.Area A_ =  D_  ^ 2 * C.pi / 4 "Average cross-sectional area";
    parameter Real delta=2*(D_i-D_o)/(D_i+D_o) "Contraction factor";
    parameter Real cf=1+2*delta^2 "Conical pipe function";
    parameter Real cos_theta = H / L "Slope ratio";
    parameter Modelica.Units.NonSI.Angle_deg phi = Modelica.Units.Conversions.to_deg(Modelica.Math.atan((abs(D_i-D_o)/(2*L)))) "Cone half angle";

initial equation
  if SteadyState then
    der(mdot) = 0;
  end if;
algorithm
    assert( phi < 1.0,  "Change in pipe diameter is too large. (angle= "+String(phi)+" )",AssertionLevel.warning);
equation

  Vdot = mdot / data.rho "Volumetric flow rate through the pipe";
  v = Vdot / A_ "Average water velocity";
  F_f = Functions.DarcyFriction.Friction(v, D_, L, data.rho, data.mu, p_eps)*cf "Friction force";
  L * der(mdot)=(p_i+ data.rho *data.g * H)*A_i-p_o*A_o -F_f;
  p_i = i.p "Inlet pressure";
  p_o = o.p "Outlet pressure";
  i.mdot+o.mdot = 0 "Mass balance";
  mdot = i.mdot "Inlet direction for mdot";

  annotation (
    Documentation(info="<html>
<h4>Simple Pipe Model</h4>

<p>The simple model of the pipe gives possibilities for easy modelling of different conduit: intake race,
penstock, tail race, etc. The model assumes incompressible water and inelastic walls since there are only
small pressure variations.</p>

<p align=\"center\"><img src=\"modelica://OpenHPL/Resources/Images/pipe.svg\"> </p>
<p><em>Figure: Model for flow through a pipe.</em></p>

<h5>Mass and Momentum Balance</h5>

<p><strong>Mass Balance:</strong> For incompressible water, the mass in the filled pipe is constant:</p>
<p>$$ \\frac{dm_\\mathrm{c}}{dt} = \\dot{m}_\\mathrm{c,in} - \\dot{m}_\\mathrm{c,out} = 0 $$</p>

<p><strong>Momentum Balance:</strong> The momentum balance is expressed as:</p>
<p>$$ \\frac{dM_\\mathrm{c}}{dt} = \\dot{M}_\\mathrm{c,in} - \\dot{M}_\\mathrm{c,out} + F_\\mathrm{p,c} + F_\\mathrm{g,c} + F_\\mathrm{f,c} $$</p>
<p>where:</p>
<ul>
<li>M<sub>c</sub> = m<sub>c</sub> v<sub>c</sub> is the momentum</li>
<li>F<sub>p,c</sub> is the pressure force due to inlet/outlet pressure difference</li>
<li>F<sub>g,c</sub> = m<sub>c</sub> g cos θ<sub>c</sub> is the gravity force</li>
<li>F<sub>f,c</sub> is the friction force calculated using the Darcy friction factor</li>
</ul>

<p>This model is described by the momentum differential equation, which depends on pressure drop through the pipe
together with friction and gravity forces. The main defined variable is volumetric flow rate <code>Vdot</code>.</p>

<p>In this pipe model, the flow rate changes simultaneously in the whole pipe (information about the speed of wave
propagation is not included). Water pressures are shown at the pipe boundaries (inlet and outlet pressure from connectors).</p>

<h5>Features</h5>
<p>It should be noted that this pipe model provides possibilities for modelling of pipes with both positive and negative
slopes (positive or negative height difference).</p>

<p>If the pipe is slightly tapered then this can be taken into account by adjusting <code>K_c</code> based on your
taper geometry: 0.05–0.15 for gentle cones, up to 0.6 for sharp contractions.</p>

<h5>Friction Specification</h5>
<p>The pipe friction can be specified using one of three methods via the <code>friction_method</code> parameter:</p>
<ul>
<li><strong>Pipe Roughness (p_eps)</strong>: Direct specification of absolute pipe roughness height (m).
Typical values: 0.0001-0.001 m for steel pipes, 0.001-0.003 m for concrete.</li>
<li><strong>Moody Friction Factor (f)</strong>: Dimensionless friction factor from Moody diagram.
Typical values: 0.01-0.05. Converted to equivalent roughness using fully turbulent flow approximation:
p_eps = 3.7·D·10<sup>-1/(2√f)</sup></li>
<li><strong>Manning Coefficient</strong>: Two notations are supported:
<ul>
<li><strong>Manning's M coefficient (Strickler)</strong> [m<sup>1/3</sup>/s]: M = 1/n, typical values 60-110 for steel,
30-60 for rock tunnels.</li>
<li><strong>Manning's n coefficient</strong> [s/m<sup>1/3</sup>]: Typical values 0.009-0.013 for smooth steel,
0.012-0.017 for concrete, 0.017-0.030 for rock tunnels.  Use checkbox <code>use_n</code> to enable this notation.</li>
</ul>
These are then converted using: p_eps = D_h·3.097·e<sup>(-0.118/n)</sup> empirically derived from the&nbsp;Karman-Prandtl equation.</li>
</ul>
<p>The conversions are simplified for hydropower applications assuming fully turbulent flow,
so they depend only on fixed pipe dimensions and the chosen friction coefficient.</p>

<h5>More Information</h5>
<p>More info about the pipe model can be found in
    <a href=\"modelica://OpenHPL.UsersGuide.References\">[Vytvytskyi2017]</a>
and <a href=\"modelica://OpenHPL.UsersGuide.References\">[Splavska2017a]</a>.</p>
</html>"));
end Pipe;
