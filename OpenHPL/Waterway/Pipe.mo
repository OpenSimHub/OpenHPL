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
                                 else 7.66 * n_eff^1.5 "Equivalent pipe roughness height";
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
    Documentation(info= "<html>
    <p>The simple model of the pipe gives possibilities
    for easy modelling of different conduit: intake race, penstock, tail race, etc.</p>
    <p>This model is described by the momentum differential equation, which depends
    on pressure drop through the pipe together with friction and gravity forces.
    The main defined variable is volumetric flow rate <code>Vdot</code>.</p>
    <p align=\"center\"><img src=\"modelica://OpenHPL/Resources/Images/pipe.svg\"> </p>
    <p>In this pipe model, the flow rate changes simultaneously in the whole pipe
    (an information about the speed of wave propagation is not included here).
    Water pressures can be shown just in the boundaries of pipe
    (inlet and outlet pressure from connectors).</p>
    <p>It should be noted that this pipe model provides possibilities for modelling
    of pipes with both a positive and a negative slopes (positive or negative height difference).</p>
    <p>If the pipe is slightly tapered then this can be taken into account by adjusting
    <code>K_c</code> based on your taper geometry: 0.05–0.15 for gentle cones,
      up to 0.6 for sharp contractions.</p>
    <h5>Friction Specification</h5>
    <p>The pipe friction can be specified using one of three methods via the <code>friction_method</code> parameter:</p>
    <ul>
    <li><b>Pipe Roughness (p_eps)</b>: Direct specification of absolute pipe roughness height (m).
    Typical values: 0.0001-0.001 m for steel pipes, 0.001-0.003 m for concrete.</li>
    <li><b>Moody Friction Factor (f)</b>: Dimensionless friction factor from Moody diagram.
    Typical values: 0.01-0.05. Converted to equivalent roughness using fully turbulent flow approximation:
    p_eps = 3.7·D·10<sup>-1/(2√f)</sup></li>
    <li><b>Manning Coefficient</b>: Two notations are supported:
    <ul>
    <li><b>Manning's M coefficient (Strickler)</b> [m<sup>1/3</sup>/s]: M = 1/n, typical values 60-110 for steel,
    30-60 for rock tunnels.</li>
    <li><b>Manning's n coefficient</b> [s/m<sup>1/3</sup>]: Typical values 0.009-0.013 for smooth steel,
    0.012-0.017 for concrete, 0.017-0.030 for rock tunnels.  Use checkbox <code>use_n</code> to enable this notation.</li>
    </ul>
    These are then converted using: p_eps = 7.66·n<sup>1.5</sup></li>
    </ul>
    <p>The conversions are simplified for hydropower applications assuming fully turbulent flow,
    so they depend only on fixed pipe dimensions and the chosen friction coefficient.</p>
    
    <h5>More info</h5>
    <p>More info about the pipe model can be found in
        <a href=\"modelica://OpenHPL.UsersGuide.References\">[Vytvytskyi2017]</a>
    and <a href=\"modelica://OpenHPL.UsersGuide.References\">[Splavska2017a]</a>.</p>
    </html>"));
end Pipe;