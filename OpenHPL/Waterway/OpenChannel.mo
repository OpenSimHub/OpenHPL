within OpenHPL.Waterway;
model OpenChannel "Open channel model with optional spatial discretization"
  outer Data data "Using standard data set";
  extends OpenHPL.Icons.OpenChannel;
  extends OpenHPL.Interfaces.TwoContacts;

  // Geometry
  parameter SI.Length L = 5000 "Channel length" annotation (Dialog(group = "Geometry"));
  parameter SI.Length W = 10 "Channel width" annotation (Dialog(group = "Geometry"));
  parameter SI.Height H_i = 10 "Bed elevation at inlet" annotation (Dialog(group = "Geometry"));
  parameter SI.Height H_o = 0 "Bed elevation at outlet" annotation (Dialog(group = "Geometry"));

  // Friction
  parameter Real n_manning(unit = "s/m(1/3)") = 0.03 "Manning's roughness coefficient n"
    annotation (Dialog(group = "Friction"));

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
  parameter SI.Height dH = H_i - H_o "Total height difference (positive = downhill inlet to outlet)";
  parameter SI.Length dx = L / max(N, 1) "Section length";
  parameter Real slope(unit = "1") = dH / L "Bed slope";

  function manningVelocity "Compute velocity from Manning's equation"
    input SI.Height h "Water depth";
    input Real S "Slope (bed slope + water surface gradient)";
    input SI.Length w "Channel width";
    input Real n "Manning's roughness coefficient";
    output SI.Velocity v "Flow velocity";
  protected
    SI.Length R_h "Hydraulic radius";
  algorithm
    R_h := w * h / (w + 2 * h);
    v := sign(S) * R_h ^ (2.0 / 3) * abs(S) ^ 0.5 / n;
  end manningVelocity;

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
  // ----- Connector pressures -----
  p_i = i.p;
  p_o = o.p;

  // ----- Mass balance: incompressible, no storage in bulk -----
  i.mdot + o.mdot = 0;
  mdot = i.mdot;
  Vdot = mdot / data.rho;

  if useSections then
    // ===== Sectional mode: N sections with individual water levels =====

    // Average depth and velocity from sections
    h_avg = sum(h_sec) / N;
    v = Vdot / (W * h_avg);

    // Friction for overall momentum (Manning formula over full length)
    F_f = data.rho * data.g * n_manning ^ 2 * v * abs(v) * L
          * (W + 2 * h_avg) ^ (4.0 / 3) / (W * h_avg) ^ (4.0 / 3);

    // Overall momentum balance determines flow rate
    L * der(mdot) = (p_i - p_o) * W * h_avg + data.rho * data.g * dH * W * h_avg - F_f;

    // Section velocities
    for j in 1:N loop
      v_sec[j] = Vdot / (W * h_sec[j]);
    end for;

    // Water level dynamics per section: continuity for free surface
    //   W * dx * dh/dt = Qdot_in - Qdot_out
    // where Qdot_in is driven by upstream depth and Qdot_out by downstream depth
    // using Manning equation locally for inter-section flow
    for j in 1:N loop
      W * dx * der(h_sec[j]) =
        (if j == 1 then Vdot
         else W * h_sec[j - 1] * manningVelocity(h_sec[j - 1], slope
              + (h_sec[j - 1] - h_sec[j]) / dx, W, n_manning))
        -
        (if j == N then Vdot
         else W * h_sec[j] * manningVelocity(h_sec[j], slope
              + (h_sec[j] - h_sec[j + 1]) / dx, W, n_manning));
    end for;

  else
    // ===== Lumped mode: single control volume =====

    // Water depth from connector pressures (average of inlet and outlet)
    h_avg = max((p_i + p_o) / (2 * data.rho * data.g), 0.01);

    v = Vdot / (W * h_avg);

    // Friction force using Manning equation for the full channel
    F_f = data.rho * data.g * n_manning ^ 2 * v * abs(v) * L
          * (W + 2 * h_avg) ^ (4.0 / 3) / (W * h_avg) ^ (4.0 / 3);

    // Momentum balance
    L * der(mdot) = (p_i - p_o) * W * h_avg + data.rho * data.g * dH * W * h_avg - F_f;

  end if;

  annotation (
    Documentation(info="<html>
<h4>Open Channel Model</h4>

<p>Model for open channels (rivers, canals) suitable for run-of-river hydropower plants.
The channel connects an upstream and downstream component via standard
<a href=\"modelica://OpenHPL.Interfaces.Contact\">Contact</a> connectors (pressure and mass flow rate).</p>

<h5>Geometry</h5>
<p>The channel is defined by its length <code>L</code>, width <code>W</code>, and
the bed elevations at inlet (<code>H_i</code>) and outlet (<code>H_o</code>).
The bed slope is computed as (H_i &minus; H_o)/L.</p>

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
