within OpenHPL.Types;
partial model FrictionSpec "Reusable friction specification with multiple input methods"
  outer Data data "Using standard data set";

  parameter Types.FrictionMethod FrictionMethod = data.FrictionMethod "Method for specifying pipe friction" annotation (
    Dialog(group = "Friction"));
  parameter SI.Height p_eps_input = data.p_eps "Pipe roughness height (absolute)" annotation (
    Dialog(group = "Friction", enable = FrictionMethod == Types.FrictionMethod.PipeRoughness));
  parameter Real f_moody(min=0) = data.f_moody "Moody friction factor (dimensionless, typically 0.01-0.05)" annotation (
    Dialog(group = "Friction", enable = FrictionMethod == Types.FrictionMethod.MoodyFriction));
  parameter Real m_manning(unit="m(1/3)/s", min=0) = data.m_manning "Manning M (Strickler) coefficient M=1/n (typically 60-110 for steel, 30-60 for rock tunnels)" annotation (
    Dialog(group = "Friction", enable = FrictionMethod == Types.FrictionMethod.ManningFriction and not use_n));
  parameter Boolean use_n = data.use_n "If true, use Mannings coefficient n (=1/M) instead of Manning's M (Strickler)" annotation (
    Dialog(group = "Friction", enable = FrictionMethod == Types.FrictionMethod.ManningFriction), choices(checkBox=true));
  parameter Real n_manning(unit="s/m(1/3)", min=0) = data.n_manning "Manning's n coefficient (typically 0.009-0.017 for steel/concrete, 0.017-0.030 for rock tunnels)" annotation (
    Dialog(group = "Friction", enable = FrictionMethod == Types.FrictionMethod.ManningFriction and use_n));

  parameter SI.Diameter D_h "Hydraulic diameter used for friction conversion" annotation (
    Dialog(group = "Friction"));

protected
  parameter Real n_eff = if use_n then n_manning else 1/m_manning "Effective Manning's n coefficient";
  parameter SI.Height p_eps = if FrictionMethod == Types.FrictionMethod.PipeRoughness then p_eps_input
                               elseif FrictionMethod == Types.FrictionMethod.MoodyFriction then 3.7 * D_h * 10^(-1/(2*sqrt(f_moody)))
                               else D_h * 3.0971 * exp(-0.118/n_eff) "Equivalent pipe roughness height";

  annotation (preferredView="info",
    Documentation(info="<html>
<h4>Friction Specification</h4>
<p>Partial model providing a reusable friction parameter set. Extending models must supply
the hydraulic diameter <code>D_h</code> used for converting Moody and Manning coefficients
to equivalent pipe roughness height <code>p_eps</code>.</p>

<p>Three friction specification methods are supported via the <code>FrictionMethod</code> parameter:</p>
<ul>
<li><strong>Pipe Roughness (p_eps)</strong>: Direct specification of absolute pipe roughness height (m).
Typical values: 0.0001&ndash;0.001 m for steel pipes, 0.001&ndash;0.003 m for concrete.</li>
<li><strong>Moody Friction Factor (f)</strong>: Dimensionless friction factor from Moody diagram.
Typical values: 0.01&ndash;0.05. Converted to equivalent roughness using fully turbulent flow approximation:
p_eps = 3.7&middot;D&middot;10<sup>-1/(2&radic;f)</sup></li>
<li><strong>Manning Coefficient</strong>: Two notations are supported:
<ul>
<li><strong>Manning's M coefficient (Strickler)</strong> [m<sup>1/3</sup>/s]: M = 1/n, typical values 60&ndash;110 for steel,
30&ndash;60 for rock tunnels.</li>
<li><strong>Manning's n coefficient</strong> [s/m<sup>1/3</sup>]: Typical values 0.009&ndash;0.013 for smooth steel,
0.012&ndash;0.017 for concrete, 0.017&ndash;0.030 for rock tunnels. Use checkbox <code>use_n</code> to enable.</li>
</ul>
Converted using: p_eps = D_h&middot;3.097&middot;e<sup>(-0.118/n)</sup> empirically derived from the Karman-Prandtl equation.</li>
</ul>
</html>"));
end FrictionSpec;
