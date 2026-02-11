within OpenHPL.UsersGuide.OpenHPLElements.ElectroMechModels;
class Turbine "Simple Turbine Model"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<h4>Turbine</h4>
<p>
The simple turbine model is based on a look-up table for turbine efficiency vs. guide vane opening. 
The mechanical turbine shaft power is:
</p>
<p>
$$ \\dot{W}_\\mathrm{tr} = \\eta_\\mathrm{h} \\Delta p_\\mathrm{tr} \\dot{V}_\\mathrm{tr} $$
</p>
<p>
where η<sub>h</sub> is hydraulic efficiency from lookup table, Δp<sub>tr</sub> is pressure drop, and 
V̇<sub>tr</sub> is volumetric flow rate.
</p>

<h5>Flow Relationship</h5>
<p>
The turbine flow rate relates to pressure drop through a valve-like expression:
</p>
<p>
$$ \\dot{V}_\\mathrm{tr} = C_\\mathrm{v} u_\\mathrm{v} \\sqrt{\\frac{\\Delta p_\\mathrm{tr}}{p^\\mathrm{a}}} $$
</p>
<p>
where C<sub>v</sub> is the guide vane \"valve capacity\", u<sub>v</sub> is guide vane opening signal 
(0 to 1), and p<sup>a</sup> is atmospheric pressure.
</p>

<h5>Implementation</h5>
<p>
The <code>Turbine</code> unit uses <code>TurbineContacts</code> connectors for multi-physics connections 
to waterway and electro-mechanical units.
</p>

<h5>Parameters</h5>
<p>
User specifies: valve capacity C<sub>v</sub>, nominal net head, nominal flow rate, nominal guide vane 
opening. User chooses either constant efficiency or efficiency lookup table.
</p>
</html>"));
end Turbine;
