within OpenHPL.UsersGuide.OpenHPLElements.WaterwayModels;
class VolumeFlowSource "Description of Volume Flow Source unit"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4>Volume Flow Source</h4>
<p>
The <em>VolumeFlowSource</em> unit provides a boundary condition that prescribes a specified volume flow rate at 
a connection point. This is particularly useful for testing individual components, validating models against 
experimental data, or representing external flow sources with known characteristics.
</p>

<h5>Operating Modes</h5>
<p>
The flow source can operate in two modes:
</p>
<ul>
<li><strong>Fixed flow rate</strong>: Constant volume flow rate specified by parameter</li>
<li><strong>Variable flow rate</strong>: Time-varying flow rate controlled through an input signal connector</li>
</ul>

<h5>Mathematical Formulation</h5>
<p>
The volume flow source imposes a flow rate condition:
</p>
<p>
$$ \\dot{V}(t) = \\dot{V}_{specified}(t) $$
</p>
<p>
while the pressure at the source is determined by the connected system. This represents an \"ideal\" flow source 
where the flow rate is maintained regardless of system pressure (within physical limits).
</p>

<h5>Parameters and Inputs</h5>
<p>
Key configuration options:
</p>
<ul>
<li><strong>Fixed mode</strong>: Constant flow rate \\(\\dot{V}\\) [m³/s]</li>
<li><strong>Variable mode</strong>: <code>RealInput</code> connector for external flow control</li>
<li>Option to enable/disable flow variation</li>
</ul>

<h5>Applications</h5>
<p>
The <em>VolumeFlowSource</em> unit is useful for:
</p>
<ul>
<li><strong>Component Testing</strong>: Isolate and test turbines, valves, or other components with controlled flow input</li>
<li><strong>Model Validation</strong>: Drive models with measured flow rate time series from field data</li>
<li><strong>Sensitivity Studies</strong>: Investigate system response to various flow patterns</li>
<li><strong>Simplified Upstream Representation</strong>: Replace complex upstream waterway with  equivalent flow source</li>
<li><strong>Forced Response Analysis</strong>: Apply specific flow disturbances to study dynamic behavior</li>
<li><strong>Runoff Modeling</strong>: Represent inflow from catchment areas or tributaries</li>
</ul>

<h5>Usage Example</h5>
<p>
A typical application is testing a turbine model. Instead of modeling the complete waterway from reservoir 
through penstock, use a <em>VolumeFlowSource</em> to directly supply the turbine with a specified flow rate, 
simplifying the model while focusing on turbine dynamics.
</p>

<h5>Implementation Notes</h5>
<p>
When using variable flow rate mode with an input signal:
</p>
<ul>
<li>Connect the signal using <code>Modelica.Blocks</code> sources (Step, Ramp, Table, etc.)</li>
<li>Ensure smooth transitions to avoid numerical issues</li>
<li>The flow rate should remain within physically reasonable bounds</li>
</ul>

<h5>Limitations</h5>
<p>
The ideal flow source assumption means:
</p>
<ul>
<li>It can theoretically supply infinite pressure if needed to maintain flow</li>
<li>Not suitable for representing real pumps or turbines with characteristic curves</li>
<li>Should not be used in closed loops without pressure-defining boundaries</li>
</ul>
</html>", revisions=""));
end VolumeFlowSource;
