within OpenHPL.UsersGuide.OpenHPLElements.ElectroMechModels;
class Grid "Electrical Grid Model"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4>Grid - Mechanical Grid Equivalent Model</h4>

<h5>Purpose</h5>
<p>
The <code>Grid</code> model represents a simplified mechanical equivalent of an electrical power grid. This model simulates grid behavior using frequency-power droop characteristics and is essential for studying hydropower plant responses to grid disturbances or load variations without requiring detailed electrical network modeling.
</p>

<h5>Model Formulation</h5>
<p>
The grid model implements primary frequency control using two alternative parameterizations - either the network power-frequency characteristic Lambda (\\(\\Lambda\\)) or an equivalent droop setting R<sub>grid</sub>. The relationship between these parameters is:
</p>

<p align=\"center\">
$$\\Lambda = \\frac{P_{grid}}{R_{grid} \\cdot f_0}$$
</p>

<p>where:</p>
<ul>
<li>\\(\\Lambda\\) is the network power-frequency characteristic (bias factor) [MW/Hz]</li>
<li>P<sub>grid</sub> is the active power capacity of the grid [W]</li>
<li>R<sub>grid</sub> is the equivalent droop setting of the grid [per unit]</li>
<li>f<sub>0</sub> is the nominal frequency (50 or 60 Hz)</li>
</ul>

<h5>Network Power-Frequency Characteristic</h5>
<p>
The grid frequency responds to power imbalances according to:
</p>

<p align=\"center\">
$$\\Delta f = -\\frac{1}{\\Lambda}(P_{load} - P_{gen})$$
</p>

<p>
where \\(\\Delta f\\) is the frequency deviation from nominal, P<sub>load</sub> is the electrical load demand, and P<sub>gen</sub> is the generated power from the hydropower plant.
</p>

<h5>Self-Regulation Effect</h5>
<p>
Frequency-dependent loads (motors, inductive loads) cause the system load to vary with frequency. This self-regulation effect is modeled using parameter \\(\\mu\\) [%/Hz]:
</p>

<p align=\"center\">
$$\\Delta P' = \\mu \\cdot \\frac{P}{100} \\cdot \\Delta f$$
</p>

<p>where:</p>
<ul>
<li>\\(\\mu\\) is the self-regulation effect of the load [%/Hz]</li>
<li>\\(\\Delta P'\\) is the change in power consumption due to frequency change [W]</li>
<li>P is the original load of the system [W]</li>
</ul>

<p>
The total load power becomes: \\(P_{total} = P_{load} + \\Delta P'\\). Typical values for \\(\\mu\\) range from 0 to 2%/Hz depending on the load composition.
</p>

<h5>Droop Characteristic</h5>
<p>
The droop setting R<sub>grid</sub> determines how much frequency deviation occurs for a given power imbalance:
</p>

<p align=\"center\">
$$\\Delta f = -R_{grid} \\cdot \\frac{\\Delta P}{P_{grid}} \\cdot f_0$$
</p>

<p>
Smaller droop values indicate stiffer grids (large \\(\\Lambda\\)) that experience small frequency deviations for significant power changes. Typical R<sub>grid</sub> values are 0.04-0.10 (4-10%). For interconnected continental grids, equivalent droops can be much smaller (0.01-0.02).
</p>

<h5>Parameters</h5>
<ul>
<li><code>Pgrid</code>: Active power capacity of the grid [W]. Default: 1e9 W (1 GW). Represents the total generation capacity that participates in frequency regulation.</li>
<li><code>useLambda</code>: Boolean selector (default: false)
  <ul>
  <li>If true: Specify \\(\\Lambda\\) directly</li>
  <li>If false: Specify R<sub>grid</sub> and \\(\\Lambda\\) is computed</li>
  </ul>
</li>
<li><code>Lambda</code>: Network power-frequency characteristic [MW/Hz]. Enabled when <code>useLambda=true</code>. Typical values: 50-5000 MW/Hz depending on grid size.</li>
<li><code>Rgrid</code>: Equivalent droop setting [per unit]. Enabled when <code>useLambda=false</code>. Default: 0.1 (10%). Range: 0.01 (strong grid) to 0.2 (weak grid).</li>
<li><code>mu</code>: Self-regulation effect [%/Hz]. Default: 0. Typical range: 0-2%/Hz. Industrial grids with many motors may have higher values (1-2%/Hz), while grids dominated by resistive loads have lower values (0-0.5%/Hz).</li>
</ul>

<h5>Inputs/Outputs</h5>
<ul>
<li><strong>Input</strong>: <code>Pload</code> (RealInput) - Electrical load power demand [W]. Can be constant or time-varying to simulate load changes or disturbances.</li>
<li><strong>Mechanical Interface</strong>: Rotational flange connected to generator shaft. The model converts frequency deviation to equivalent mechanical torque.</li>
</ul>

<h5>Applications</h5>
<ul>
<li><strong>Primary frequency response studies</strong>: Evaluate how hydropower plant responds to sudden load changes or generation trips in the grid.</li>
<li><strong>Governor tuning</strong>: Test governor performance with realistic grid dynamics without full electrical network model.</li>
<li><strong>Island operation studies</strong>: Model small isolated grids (weak grids with high R<sub>grid</sub>) supplied by hydropower.</li>
<li><strong>Interconnected grid studies</strong>: Model large continental grids (strong grids with low R<sub>grid</sub>) with high inertia.</li>
<li><strong>Load rejection scenarios</strong>: Simulate loss of load and resulting frequency/speed excursion.</li>
<li><strong>Sensitivity analysis</strong>: Study impact of grid strength (\\(\\Lambda\\)) on plant transient behavior.</li>
</ul>

<h5>Implementation Notes</h5>
<ul>
<li>The model extends <code>BaseClasses.Power2Torque</code> to convert electrical power imbalance to mechanical torque on the generator shaft.</li>
<li>Grid is represented as infinite bus with mechanical dynamics - frequency changes but voltage magnitude remains constant.</li>
<li>Model assumes generator is already synchronized to grid (use <code>MCB</code> model for connection/disconnection events).</li>
<li>The model uses <code>outer Data data</code> to access nominal frequency f<sub>0</sub> and other system parameters.</li>
<li>Maximum power capacity is set to 1.2×P<sub>grid</sub> to accommodate transient overloads.</li>
</ul>

<h5>Typical Parameterization Examples</h5>

<p><strong>Large continental grid (European ENTSO-E or North American interconnection):</strong></p>
<ul>
<li>Pgrid = 100 GW to 1 TW (total participating capacity)</li>
<li>Rgrid = 0.01-0.02 (1-2%) or Lambda = 2500-5000 MW/Hz</li>
<li>mu = 1%/Hz (moderate self-regulation)</li>
<li>Result: Very stiff grid, small frequency excursions</li>
</ul>

<p><strong>Regional interconnected grid (Nordic Grid, UK Grid):</strong></p>
<ul>
<li>Pgrid = 10-50 GW</li>
<li>Rgrid = 0.04-0.06 (4-6%) or Lambda = 400-1250 MW/Hz</li>
<li>mu = 0.5-1.5%/Hz</li>
<li>Result: Moderate stiffness, observable frequency transients</li>
</ul>

<p><strong>Island or isolated grid:</strong></p>
<ul>
<li>Pgrid = 100 MW to 1 GW</li>
<li>Rgrid = 0.08-0.15 (8-15%) or Lambda = 30-600 MW/Hz</li>
<li>mu = 0-1%/Hz (depends on load type)</li>
<li>Result: Weak grid, significant frequency deviations during transients</li>
</ul>

<h5>Relation to OpenIPSL</h5>
<p>
For more detailed electrical grid modeling including voltage dynamics, reactive power, multi-machine stability, and detailed protection systems, use <code>OpenIPSL</code> (Open-Instance Power System Library) in combination with OpenHPL. The <code>Grid</code> model in OpenHPL provides a simplified mechanical equivalent suitable for:
</p>
<ul>
<li>Cases where electrical transients are not of primary interest</li>
<li>Early design phase studies focusing on hydraulic/mechanical dynamics</li>
<li>Computational efficiency when electrical detail is not required</li>
<li>Educational purposes to understand frequency-power relationships</li>
</ul>

<h5>Limitations</h5>
<ul>
<li>No voltage dynamics - only frequency/power relationship modeled</li>
<li>Single equivalent representation - cannot model multi-area or multi-machine interactions</li>
<li>No reactive power/voltage control</li>
<li>No protection systems or relay actions</li>
<li>Linear droop characteristic - does not capture deadbands or nonlinear effects</li>
</ul>

<h5>See Also</h5>
<p>
<a href=\"modelica://OpenHPL.ElectroMech.PowerSystem.Grid\">OpenHPL.ElectroMech.PowerSystem.Grid</a>,
<a href=\"modelica://OpenHPL.ElectroMech.PowerSystem.MCB\">OpenHPL.ElectroMech.PowerSystem.MCB</a>,
<a href=\"modelica://OpenHPL.Controllers.Governor\">OpenHPL.Controllers.Governor</a>,
<a href=\"modelica://OpenHPL.ElectroMech.Generators.SimpleGen\">OpenHPL.ElectroMech.Generators.SimpleGen</a>
</p>
</html>"));
end Grid;
