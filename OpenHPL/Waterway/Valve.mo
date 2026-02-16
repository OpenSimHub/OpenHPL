within OpenHPL.Waterway;
model Valve "Simple hydraulic valve"
  extends ElectroMech.BaseClasses.BaseValve;
  extends Icons.Valve;

  Modelica.Blocks.Interfaces.RealInput opening(min=0, max=1)
    "=1: completely open, =0: completely closed"
  annotation (Placement(transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,80})));
equation
  connect(opening, u) annotation (Line(points={{0,120},{0,70}}, color={0,0,127}));
  annotation (preferredView="info",
    Documentation(info="<html>
<h4>Hydraulic Valve Model</h4>

<p>Simple model of a hydraulic valve for controlling water flow in hydropower systems.
Represents various control valve types (butterfly, spherical, needle valves) based on energy balance principles.</p>

<h5>Flow Equation</h5>

<p>The valve uses a valve-like flow expression relating flow rate to pressure drop:</p>
<p>$$ \\dot{V} = C_v \\cdot u \\cdot \\sqrt{\\frac{2\\Delta p}{\\rho}} $$</p>
<p>where C<sub>v</sub> is the valve capacity coefficient [m²], u is valve opening (0=closed, 1=fully open),
Δp is pressure drop [Pa], and ρ is water density [kg/m³].</p>

<h5>Valve Capacity</h5>

<p>The valve capacity can be specified in two ways:</p>
<ul>
<li><strong>Direct specification:</strong> User provides C<sub>v</sub> from manufacturer data (set <code>ValveCapacity=true</code>)</li>
<li><strong>From nominal conditions:</strong> C<sub>v</sub> computed from nominal head H<sub>n</sub> and flow rate V̇<sub>n</sub> (set <code>ValveCapacity=false</code>)</li>
</ul>

<h5>Efficiency Modeling</h5>

<p>Energy losses can be modeled through efficiency parameter η (0 to 1):</p>
<ul>
<li><strong>Constant efficiency:</strong> Single value</li>
<li><strong>Variable efficiency:</strong> Lookup table based on valve opening</li>
</ul>
<p>Valve power loss: $$ \\dot{W}_\\mathrm{loss} = \\dot{V} \\cdot \\Delta p \\cdot (1 - \\eta) $$</p>

<h5>Control Interface</h5>

<p>The <code>opening</code> input accepts control signals (0 = completely closed, 1 = fully open).</p>

<h5>Applications</h5>

<p>Useful for emergency shutdown scenarios, flow regulation, load rejection analysis, water hammer mitigation studies, and bypass systems.</p>

<h5>More Information</h5>
<p>This model extends <a href=\"modelica://OpenHPL.ElectroMech.BaseClasses.BaseValve\">BaseValve</a> which contains the core valve equations.</p>
</html>"));
end Valve;
