within OpenHPL.UsersGuide.OpenHPLElements.ElectroMechModels;
class MCB "Main Circuit Breaker Model"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4>MCB - Main Circuit Breaker Model</h4>

<h5>Purpose</h5>
<p>
The <code>MCB</code> (Main Circuit Breaker) model represents a mechanical equivalent of an electrical circuit breaker used to connect or disconnect a generator from the electrical grid. This component is essential for simulating startup procedures, shutdown sequences, synchronization processes, and emergency disconnection events in hydropower systems.
</p>

<h5>Operating Principle</h5>
<p>
The MCB model uses a controlled clutch mechanism to couple the generator shaft to the grid shaft. The clutch can open (disconnect) or close (connect) based on time-scheduled events and synchronization conditions. When closed, mechanical torque and power are transmitted between generator and grid. When open, the generator operates independently (island mode or startup).
</p>

<h5>Synchronization Logic</h5>
<p>
Before closing the MCB to connect the generator to the grid, the model verifies that the speed difference between generator and grid is sufficiently small. The synchronization condition is:
</p>

<p align=\"center\">
$$|\\omega_{gen} - \\omega_{grid}| \\leq \\Delta\\omega_{max}$$
</p>

<p>where:</p>
<ul>
<li>\\(\\omega_{gen}\\) is the angular velocity of the generator shaft [rad/s]</li>
<li>\\(\\omega_{grid}\\) is the angular velocity of the grid [rad/s]</li>
<li>\\(\\Delta\\omega_{max} = 2\\pi \\cdot \\Delta_{speed} \\cdot f_0\\) is the maximum allowable speed difference [rad/s]</li>
<li>\\(\\Delta_{speed}\\) is the maximum allowed speed difference parameter [per unit]</li>
<li>f<sub>0</sub> is the nominal frequency (50 or 60 Hz)</li>
</ul>

<h5>Control Logic</h5>
<p>
The MCB operates using an RS flip-flop logic with the following states:
</p>

<ul>
<li><strong>OPEN (Initial state)</strong>: Generator disconnected from grid. Generator can run at independent speed.</li>
<li><strong>CLOSE Command at t = t_close</strong>: When simulation time reaches t<sub>close</sub> AND speed difference condition is satisfied, the MCB closes. Closing occurs gradually over 0.01 seconds (soft engagement).</li>
<li><strong>CLOSED (Operating state)</strong>: Generator mechanically coupled to grid. Generator and grid rotate at same speed.</li>
<li><strong>OPEN Command at t = t_open</strong>: When simulation time reaches t<sub>open</sub>, the MCB opens regardless of speed difference. Opening is immediate for emergency trip simulation.</li>
</ul>

<p>
The logic implements: <code>CLOSE = (time ≥ t_close) AND (speed_diff_ok)</code> and <code>OPEN = (time ≥ t_open)</code>.
</p>

<h5>Parameters</h5>
<ul>
<li><code>t_close</code>: Time at which the MCB should close [s]. Default: 100 s. This represents when the generator has been brought up to speed and synchronization is attempted. Typical values: 50-300 s depending on startup procedure.</li>

<li><code>t_open</code>: Time at which the MCB should open [s]. Default: 300 s. This simulates disconnection events such as:
  <ul>
  <li>Scheduled shutdown</li>
  <li>Emergency trip due to fault</li>
  <li>Load rejection (generator trips offline)</li>
  <li>Protection system activation</li>
  </ul>
  Set to large value (e.g., 1e6) if disconnection is not desired during simulation.
</li>

<li><code>deltaSpeed</code>: Maximum allowed speed difference for closing the MCB [per unit]. Default: 0.01 (1%). This ensures the generator is close to synchronous speed before connection. Typical range:
  <ul>
  <li>0.001-0.005 (0.1-0.5%): Strict synchronization for large machines</li>
  <li>0.01 (1%): Standard synchronization criterion</li>
  <li>0.02-0.05 (2-5%): Relaxed criterion for smaller machines or educational models</li>
  </ul>
  Too tight: MCB may never close if generator speed oscillates around synchronous speed<br/>
  Too loose: Connection causes mechanical shock and excessive transient torque
</li>
</ul>

<h5>Inputs/Outputs</h5>
<ul>
<li><strong>genFlange</strong> (Flange_a): Rotational connection to generator shaft. Receives generator torque and speed.</li>
<li><strong>gridFlange</strong> (Flange_b): Rotational connection to grid equivalent model. Transmits torque to/from grid.</li>
</ul>

<h5>Applications</h5>
<ul>
<li><strong>Startup sequence simulation</strong>: Model bringing generator from standstill to synchronous speed, then synchronizing to grid.
  <ol>
  <li>t = 0-t<sub>close</sub>: MCB open, governor brings turbine/generator to near-synchronous speed</li>
  <li>t = t<sub>close</sub>: MCB closes when speed condition met, generator connects to grid</li>
  <li>t > t<sub>close</sub>: Normal operation, generator supplies power to grid</li>
  </ol>
</li>

<li><strong>Load rejection studies</strong>: Simulate sudden disconnection of generator from grid at t = t<sub>open</sub>. Evaluate:
  <ul>
  <li>Speed/frequency excursion after disconnection</li>
  <li>Governor response to reject load quickly</li>
  <li>Water hammer effects in penstock</li>
  <li>Overspeed protection activation</li>
  </ul>
</li>

<li><strong>Island operation</strong>: MCB opens at t<sub>open</sub>, generator continues operating disconnected from main grid, supplying isolated load.</li>

<li><strong>Reclosing sequences</strong>: Simulate fault clearing and automatic reclosing by setting t<sub>close</sub> < t<sub>open</sub> < t<sub>reclose</sub> (requires multiple MCB instances or modified logic).</li>

<li><strong>Synchronization failure analysis</strong>: If deltaSpeed is too strict or governor tuning poor, MCB may not close - helps identify control issues.</li>

<li><strong>Mechanical stress analysis</strong>: Evaluate shaft torques during connection/disconnection events.</li>
</ul>

<h5>Implementation Notes</h5>
<ul>
<li>The MCB uses Modelica Standard Library's <code>Clutch</code> component with very high maximum friction force (fn_max = 1e12) to ensure rigid coupling when closed.</li>
<li>A <code>RelSpeedSensor</code> continuously measures speed difference between generator and grid sides.</li>
<li>The <code>TriggeredTrapezoid</code> block provides soft engagement over 0.01 seconds when closing to avoid numerical discontinuities.</li>
<li>RS flip-flop ensures MCB remains closed once synchronized, even if speed difference temporarily exceeds threshold during transients.</li>
<li>MCB can only close once per simulation run (at t<sub>close</sub>) unless additional control logic is added.</li>
<li>The model uses <code>inner Data data</code> to access nominal frequency f<sub>0</sub> for speed difference calculations.</li>
</ul>

<h5>Typical Usage Scenarios</h5>

<p><strong>Scenario 1: Normal startup and continuous operation</strong></p>
<ul>
<li>t_close = 100 s (synchronize after governor brings unit to speed)</li>
<li>t_open = 1e6 s (no disconnection during simulation)</li>
<li>deltaSpeed = 0.01 (1% synchronization tolerance)</li>
<li>Result: Generator connects at t=100s and remains connected</li>
</ul>

<p><strong>Scenario 2: Load rejection test</strong></p>
<ul>
<li>t_close = 100 s (synchronize and operate normally)</li>
<li>t_open = 300 s (trip generator offline)</li>
<li>deltaSpeed = 0.01</li>
<li>Result: Normal operation 100-300s, then sudden disconnection at 300s</li>
<li>Observe: Frequency spike, governor response, penstock pressure transient</li>
</ul>

<p><strong>Scenario 3: Synchronization difficulty study</strong></p>
<ul>
<li>t_close = 100 s</li>
<li>t_open = 1e6 s</li>
<li>deltaSpeed = 0.001 (very strict 0.1% tolerance)</li>
<li>Poorly tuned governor oscillates around synchronous speed</li>
<li>Result: MCB may delay closing until speed stabilizes, or never close if oscillations persist</li>
<li>Helps identify need for governor tuning improvements</li>
</ul>

<p><strong>Scenario 4: Island to grid-connected transition</strong></p>
<ul>
<li>t = 0-100s: Generator supplies local island load with MCB open</li>
<li>t = 100s: Grid becomes available, MCB closes to connect island to main grid</li>
<li>t > 100s: Generator participates in main grid frequency regulation</li>
</ul>

<h5>Modeling Considerations</h5>
<ul>
<li><strong>Electrical vs Mechanical Representation</strong>: This is a mechanical equivalent. Real MCBs operate on electrical side with voltage/phase angle checking. This model uses speed (frequency) as proxy for synchronization.</li>

<li><strong>Simplified Synchronization</strong>: Real synchronization requires matching:
  <ul>
  <li>Phase angle (represented here as speed/frequency)</li>
  <li>Voltage magnitude (not modeled - assumed matched by AVR)</li>
  <li>Phase sequence (not modeled - assumed correct)</li>
  </ul>
</li>

<li><strong>Closing Time</strong>: The 0.01 s rising time for clutch engagement is for numerical smoothness. Real circuit breakers close in 0.05-0.2 seconds (3-12 cycles at 50/60 Hz).</li>

<li><strong>Generator Model Selection</strong>: Use with <code>SimpleGen</code> for simplified studies or <code>SynchGen</code> for more detailed electromechanical dynamics including swing equation.</li>

<li><strong>Grid Model Requirements</strong>: MCB requires both generator-side and grid-side rotational connections. Typically:
  <ul>
  <li>genFlange ← connected to SynchGen or SimpleGen</li>
  <li>gridFlange ← connected to Grid model or detailed electrical network</li>
  </ul>
</li>
</ul>

<h5>Troubleshooting</h5>

<p><strong>Problem: MCB never closes (simulation reaches t_close but connection doesn't occur)</strong></p>
<ul>
<li><strong>Cause</strong>: Speed difference exceeds deltaSpeed threshold continuously</li>
<li><strong>Solutions</strong>:
  <ul>
  <li>Check governor is properly tuned and bringing generator to synchronous speed</li>
  <li>Increase deltaSpeed parameter (relax synchronization criterion)</li>
  <li>Adjust governor droop, time constants, or power setpoint</li>
  <li>Verify grid frequency is at nominal value (50 or 60 Hz)</li>
  </ul>
</li>
</ul>

<p><strong>Problem: Large torque spike when MCB closes</strong></p>
<ul>
<li><strong>Cause</strong>: deltaSpeed too large, significant speed mismatch at connection</li>
<li><strong>Solutions</strong>:
  <ul>
  <li>Reduce deltaSpeed for stricter synchronization</li>
  <li>Improve governor tuning to minimize speed oscillations</li>
  <li>Increase rising time in TriggeredTrapezoid for softer engagement (if numerically stable)</li>
  </ul>
</li>
</ul>

<p><strong>Problem: Numerical issues (solver convergence problems) at MCB closing/opening</strong></p>
<ul>
<li><strong>Cause</strong>: Discontinuous clutch engagement creates numerical challenges</li>
<li><strong>Solutions</strong>:
  <ul>
  <li>Use solver with event handling (Dassl, Cvode)</li>
  <li>Reduce solver tolerance</li>
  <li>The 0.01 s rising time helps smooth transition</li>
  </ul>
</li>
</ul>

<h5>Extensions and Advanced Usage</h5>
<ul>
<li><strong>Multiple disconnection events</strong>: Use multiple MCB models in series or modify control logic for reclosing sequences</li>
<li><strong>External control</strong>: Replace time-based triggering with external Boolean signals for protection system integration</li>
<li><strong>Voltage synchronization</strong>: For detailed studies, combine with OpenIPSL electrical models that check voltage magnitude and phase angle</li>
<li><strong>Breaker failure</strong>: Modify logic to simulate failure to open/close for protection coordination studies</li>
</ul>

<h5>See Also</h5>
<p>
<a href=\"modelica://OpenHPL.ElectroMech.PowerSystem.MCB\">OpenHPL.ElectroMech.PowerSystem.MCB</a>,
<a href=\"modelica://OpenHPL.ElectroMech.PowerSystem.Grid\">OpenHPL.ElectroMech.PowerSystem.Grid</a>,
<a href=\"modelica://OpenHPL.ElectroMech.Generators.SynchGen\">OpenHPL.ElectroMech.Generators.SynchGen</a>,
<a href=\"modelica://OpenHPL.Controllers.Governor\">OpenHPL.Controllers.Governor</a>
</p>
</html>"));
end MCB;
