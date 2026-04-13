within OpenHPL.Interfaces;
connector Contact "Water flow connector"
  parameter Boolean showElevation = true "Show elevation z";
  SI.Pressure p "Contact pressure";
  //SI.Temperature T "Contact temperature";
  flow SI.MassFlowRate mdot "Mass flow rate through the contact";
  Elevation elevation "Overconstrained elevation at connection point";

  annotation (
    Documentation(info = "<html>
<p>Contact is a basic water flow connector, which consists of water pressure, mass flow rate,
and elevation at the connector (positive if water is flowing into connector and negative if flowing out).</p>

<h5>Variables</h5>
<ul>
<li><code>p</code> &ndash; Pressure (potential variable, equated across connections)</li>
<li><code>mdot</code> &ndash; Mass flow rate (flow variable, summed to zero across connections)</li>
<li><code>elevation.z</code> &ndash; Elevation (overconstrained variable, propagated via spanning tree).
Each component provides an equation relating its connector elevations,
enabling automatic propagation of absolute elevation through the system.
Source components (e.g., Reservoir) set the absolute reference elevation.
Uses the overconstrained connector mechanism (Modelica Spec 9.4) to support
arbitrary topologies including parallel pipes and loops.</li>
</ul>
</html>"),
  Icon(graphics = {
    Text(origin = {0, -175},
         textColor = {0, 85, 255},
         extent = {{-100, 100}, {100, -100}},
         textString = DynamicSelect("", if showElevation then String(elevation.z) else ""))}));
end Contact;