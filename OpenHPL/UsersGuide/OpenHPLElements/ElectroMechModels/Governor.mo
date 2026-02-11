within OpenHPL.UsersGuide.OpenHPLElements.ElectroMechModels;
class Governor "Description of Governor unit"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4>Governor/Controller Model</h4>
<p>
The <em>Governor</em> unit implements a turbine governor system for controlling guide vane position and regulating 
turbine output. Governors are essential control systems in hydropower plants that maintain stable operation, 
regulate frequency, and respond to load changes.
</p>

<h5>Control Structure</h5>
<p>
The governor model consists of several interconnected control blocks representing a typical hydropower governor system:
</p>
<ul>
<li><strong>Pilot Servomotor</strong>: First-order transfer function with time constant \\(T_p\\)</li>
<li><strong>Main Servomotor</strong>: Integrator with time constant \\(T_g\\)</li>
<li><strong>Transient Droop</strong>: Transfer function with time constant \\(T_r\\) and transient droop \\(\\delta\\)</li>
<li><strong>Permanent Droop</strong>: Proportional feedback with droop coefficient</li>
<li><strong>Rate Limiters</strong>: Constrain guide vane opening and closing rates</li>
<li><strong>Position Limiters</strong>: Limit guide vane position between 0 (closed) and 1 (fully open)</li>
</ul>

<h5>Control Law</h5>
<p>
The governor implements a PID-like control strategy with droop compensation:
</p>
<p>
$$ Y_{gv} = f(P_{ref}, P, f, f_{ref}) $$
</p>
<p>
where:
</p>
<ul>
<li>\\(Y_{gv}\\): Guide vane opening (0-1) [-]</li>
<li>\\(P_{ref}\\): Reference power setpoint [W]</li>
<li>\\(P\\): Actual electrical power output [W]</li>
<li>\\(f\\): Actual grid frequency [Hz]</li>
<li>\\(f_{ref}\\): Reference frequency (typically 50 or 60 Hz) [Hz]</li>
</ul>

<h5>Key Parameters</h5>
<p>
The governor model requires careful tuning of several parameters:
</p>

<p><strong>Time Constants:</strong></p>
<ul>
<li>\\(T_p\\): Pilot servomotor time constant (typically 0.02-0.08 s)</li>
<li>\\(T_g\\): Main servomotor time constant (typically 0.1-0.5 s)</li>
<li>\\(T_r\\): Transient droop time constant (typically 1-10 s)</li>
</ul>

<p><strong>Droop Settings:</strong></p>
<ul>
<li><strong>Permanent droop</strong>: Steady-state droop (typically 2-6% or 0.02-0.06)</li>
<li><strong>Transient droop</strong> \\(\\delta\\): Temporary droop during transients (typically 0.02-0.10)</li>
</ul>

<p><strong>Rate Limits:</strong></p>
<ul>
<li>\\(\\dot{Y}_{gv,max}\\): Maximum opening rate [1/s]</li>
<li>\\(\\dot{Y}_{gv,min}\\): Maximum closing rate (negative value) [1/s]</li>
</ul>

<p><strong>Nominal Conditions:</strong></p>
<ul>
<li>\\(P_n\\): Nominal/rated power [W]</li>
<li>\\(Y_{gv,ref}\\): Initial guide vane opening [-]</li>
<li>\\(f_{ref}\\): Reference frequency [Hz]</li>
</ul>

<h5>Droop Characteristic</h5>
<p>
The droop characteristic defines how frequency deviation relates to power output. The permanent droop creates 
a steady-state relationship:
</p>
<p>
$$ \\Delta f = -R \\cdot \\frac{\\Delta P}{P_n} \\cdot f_{ref} $$
</p>
<p>
where \\(R\\) is the droop coefficient. For example, 5% droop means a 100% load change causes a 2.5 Hz 
frequency change (for 50 Hz systems) or 3 Hz (for 60 Hz systems).
</p>

<h5>Transient Droop</h5>
<p>
The transient droop \\(\\delta\\) provides temporary additional droop during fast transients to improve 
system stability and reduce overshoot. It decays with time constant \\(T_r\\), eventually leaving only 
the permanent droop effect.
</p>

<h5>Look-up Table</h5>
<p>
The governor includes a look-up table that can represent:
</p>
<ul>
<li>Nonlinear relationships between power reference and guide vane position</li>
<li>Efficiency optimization curves</li>
<li>Operating constraints at different power levels</li>
</ul>

<h5>Inputs and Outputs</h5>
<p>
The governor model has the following interfaces:
</p>
<ul>
<li><strong>Inputs</strong>:
  <ul>
    <li><code>P_ref</code>: Power reference signal [per-unit or W]</li>
    <li><code>f</code>: Grid frequency measurement [Hz]</li>
  </ul>
</li>
<li><strong>Output</strong>:
  <ul>
    <li><code>Y_gv</code>: Guide vane opening command (0-1) [-]</li>
  </ul>
</li>
</ul>

<h5>Applications</h5>
<p>
The governor model is essential for:
</p>
<ul>
<li>Frequency regulation and primary control studies</li>
<li>Load rejection and acceptance transient analysis</li>
<li>Grid stability studies with hydropower participation</li>
<li>Controller tuning and optimization</li>
<li>Black start and islanded operation scenarios</li>
<li>Coordination with other grid components</li>
</ul>

<h5>Integration with OpenIPSL</h5>
<p>
The <em>Governor</em> model is designed to work seamlessly with:
</p>
<ul>
<li>OpenHPL turbine and generator models</li>
<li>OpenIPSL synchronous generators and power system models</li>
<li>External grid models for co-simulation studies</li>
</ul>

<h5>Tuning Guidelines</h5>
<p>
Proper governor tuning is critical for stable operation:
</p>
<ul>
<li>Start with conservative (slower) time constants</li>
<li>Increase droop if system shows oscillations</li>
<li>Adjust transient droop to balance response speed vs. stability</li>
<li>Verify rate limits match physical actuator capabilities</li>
<li>Validate against field test data when available</li>
</ul>
</html>", revisions=""));
end Governor;
