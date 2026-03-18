within OpenHPL.Waterway;
model OpenChannel "Open channel model with optional spatial discretization"
  outer Data data "Using standard data set";
  extends OpenHPL.Icons.OpenChannel;
  extends OpenHPL.Interfaces.TwoContacts;

  // Geometry
  parameter SI.Length L = 5000 "Channel length" annotation (Dialog(group = "Geometry"));
  parameter SI.Length W = 10 "Channel width" annotation (Dialog(group = "Geometry"));
  parameter SI.Length H = 10 "Bed elevation difference between inlet and outlet (positive = downhill inlet to outlet)" annotation (Dialog(group = "Geometry"));

  // Friction
  parameter Real m_manning(unit="m(1/3)/s", min=0) = 33 "Manning M (Strickler) coefficient M=1/n (typically 60-110 for steel, 30-60 for rock tunnels)" annotation (
    Dialog(group = "Friction", enable = not use_n));
  parameter Boolean use_n = true "If true, use Mannings coefficient n (=1/M) instead of Manning's M (Strickler)" annotation (
    Dialog(group = "Friction"), choices(checkBox=true));
  parameter Real n_manning(unit="s/m(1/3)", min=0) = 0.03 "Manning's n coefficient (typically 0.009-0.017 for steel/concrete, 0.017-0.030 for rock tunnels)" annotation (
    Dialog(group = "Friction", enable = use_n));

  // Discretization
  parameter Boolean useSections = false "If true, discretize the channel into N sections with varying water levels"
    annotation (choices(checkBox = true), Dialog(group = "Discretization"));
  parameter Integer N = 10 "Number of sections (only used when useSections = true)"
    annotation (Dialog(group = "Discretization", enable = useSections));

  // Initialization
  parameter Boolean SteadyState = data.SteadyState "If true, starts in steady state"
    annotation (Dialog(group = "Initialization"));
  parameter SI.VolumeFlowRate Vdot_0 = data.Vdot_0 "Initial volume flow rate"
    annotation (Dialog(group = "Initialization"));
  parameter SI.Height h_0 = 2 "Initial water depth"
    annotation (Dialog(group = "Initialization"));

  // Variables — lumped (always computed)
  SI.MassFlowRate mdot "Mass flow rate through the channel";
  SI.VolumeFlowRate Vdot "Volume flow rate";
  SI.Velocity v "Average water velocity";
  SI.Height h_avg "Average water depth in the channel";
  SI.Pressure p_i "Inlet pressure";
  SI.Pressure p_o "Outlet pressure";
  SI.Force F_f "Friction force";

  // Variables — sectional (only meaningful when useSections = true)
  SI.Height h_sec[if useSections then N else 0] "Water depth in each section";
  SI.Velocity v_sec[if useSections then N else 0] "Velocity in each section";

protected
  parameter Real n_eff(unit="s/m(1/3)") = if use_n then n_manning else 1/m_manning "Effective Manning's n coefficient";
  parameter SI.Length dx = L / max(N, 1) "Section length";
  parameter SI.PerUnit slope = H / L "Bed slope";

initial equation
  if SteadyState then
    der(mdot) = 0;
    if useSections then
      for j in 1:N loop
        der(h_sec[j]) = 0;
      end for;
    end if;
  else
    if useSections then
      for j in 1:N loop
        h_sec[j] = h_0;
      end for;
    end if;
  end if;

equation
  p_i = i.p "Inlet connector pressure";
  p_o = o.p "Outlet connector pressure";

  // ----- Mass balance: incompressible, no storage in bulk -----
  i.mdot + o.mdot = 0;
  mdot = i.mdot;
  Vdot = mdot / data.rho;

  if useSections then
    // ===== Sectional mode: N sections with individual water levels =====

    h_avg = sum(h_sec) / N "Average depth from sections";
    v = Vdot / (W * h_avg) "Average velocity from sections";

    F_f = data.rho * data.g * n_eff ^ 2 * v * abs(v) * L
          * (W + 2 * h_avg) ^ (4.0 / 3) / (W * h_avg) ^ (4.0 / 3)
          "Friction for overall momentum (Manning formula over full length)";

    L * der(mdot) = (p_i - p_o) * W * h_avg + data.rho * data.g * H * W * h_avg - F_f
                    "Overall momentum balance determines flow rate";

    for j in 1:N loop
      v_sec[j] = Vdot / (W * h_sec[j]) "Section velocities";
    end for;

    // Water level dynamics per section: continuity for free surface
    //   W * dx * H/dt = Vdot_in - Vdot_out
    // where Vdot_in is driven by upstream depth and Vdot_out by downstream depth
    // using Manning equation locally for inter-section flow
    for j in 1:N loop
      W * dx * der(h_sec[j]) =
        (if j == 1 then Vdot
         else W * h_sec[j - 1] * Functions.manningVelocity(h_sec[j - 1], slope
              + (h_sec[j - 1] - h_sec[j]) / dx, W, n_eff))
        -
        (if j == N then Vdot
         else W * h_sec[j] * Functions.manningVelocity(h_sec[j], slope
              + (h_sec[j] - h_sec[j + 1]) / dx, W, n_eff));
    end for;

  else
    // ===== Lumped mode: single control volume =====

    h_avg = max((p_i + p_o) / (2 * data.rho * data.g), 0.01)
            "Water depth from connector pressures (average of inlet and outlet)";

    v = Vdot / (W * h_avg);

    F_f = data.rho * data.g * n_eff ^ 2 * v * abs(v) * L
          * (W + 2 * h_avg) ^ (4.0 / 3) / (W * h_avg) ^ (4.0 / 3)
          "Friction force using Manning equation for the full channel";
    L * der(mdot) = (p_i - p_o) * W * h_avg + data.rho * data.g * H * W * h_avg - F_f
                    "Momentum balance";
  end if;

  annotation (
    Documentation(info="<html>
<h4>Open Channel Model</h4>

<p>Model for open channels (rivers, canals) suitable for run-of-river hydropower plants.
The channel connects an upstream and downstream component via standard
<a href=\"modelica://OpenHPL.Interfaces.Contact\">Contact</a> connectors (pressure and mass flow rate).</p>

<h5>Geometry</h5>
<p>The channel is defined by its length <code>L</code>, width <code>W</code>, and
the difference in bed elevations between inlet and outlet <code>H</code>.
The bed slope is computed as H/L.</p>

<h5>Governing Equations</h5>
<p>The model is based on the momentum balance for incompressible flow:</p>
<p>$$ L\\,\\frac{\\mathrm{d}\\dot{m}}{\\mathrm{d}t} = (p_\\mathrm{i} - p_\\mathrm{o})\\,A + \\rho\\,g\\,\\Delta H\\,A - F_\\mathrm{f} $$</p>
<p>where A = W &middot; h is the cross-sectional flow area and F<sub>f</sub> is the friction force.</p>

<h5>Friction</h5>
<p>Friction is computed using Manning's equation adapted for a rectangular cross-section:</p>
<p>$$ F_\\mathrm{f} = \\rho\\,g\\,n^2\\,v\\,|v|\\,L\\,\\frac{(W + 2h)^{4/3}}{(W\\,h)^{4/3}} $$</p>
<p>where n is Manning's roughness coefficient.</p>

<h5>Modes of Operation</h5>
<ul>
<li><strong>Lumped mode</strong> (default): The channel is treated as a single control volume.
The flow rate responds to the pressure difference between inlet and outlet connectors,
gravity, and friction.</li>
<li><strong>Sectional mode</strong> (<code>useSections = true</code>): The channel is divided into
<code>N</code> sections. Each section maintains its own water depth via a continuity equation
for the free surface. Inter-section flows are computed using Manning's equation with the
local water surface slope. This captures water level variations along the channel.</li>
</ul>

<h5>Connectors</h5>
<p>Inlet and outlet connectors carry pressure and mass flow rate.
Connect upstream to the inlet <code>i</code> and downstream to the outlet <code>o</code>.</p>
</html>"));

end OpenChannel;
