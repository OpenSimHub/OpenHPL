within OpenHPL.Waterway;
model Gate_HR "Model of a tainter gate (HEC-RAS)"
  outer Data data "Using standard class with system parameters";
  extends Icons.Gate;
  extends OpenHPL.Interfaces.ContactPort;

  parameter SI.Height W "Width of the gated spillway"
    annotation (Dialog(group="Geometry"));
  parameter SI.Height T "Trunnion height (from spillway crest to trunnion pivot point)"
    annotation (Dialog(group="Geometry"));
  parameter Real Cd = 0.7 "Discharge coefficient (typically ranges from 0.6 - 0.8)"
    annotation (Dialog(group="Coefficients"));
  parameter Real TE = 0.16 "Trunnion height exponent, typically about 0.16"
    annotation (Dialog(group="Coefficients"));
  parameter Real BE = 0.72 "Gate opening exponent, typically about 0.72"
    annotation (Dialog(group="Coefficients"));
  SI.Length H = h_i "Upstream Energy Head above the spillway crest";
  parameter Real HE = 0.62 "Head exponent, typically about 0.62"
    annotation (Dialog(group="Coefficients"));
  SI.Height h_i "Inlet water level";
  SI.Height h_o "Outlet water level";
  SI.VolumeFlowRate Vdot "Volume flow rate through the gate";
  Real H_ratio = h_o/h_i "Ratio of outlet to inlet height";

  Modelica.Blocks.Interfaces.RealInput B "Height of gate opening [m]" annotation (Placement(transformation(
           extent={{-20,-20},{20,20}},
           rotation=270,
           origin={0,120})));
protected
  SI.VolumeFlowRate Vdot_free "Free base volume flow rate through the gate";
  SI.VolumeFlowRate Vdot_partial "Partially submerged base volume flow rate through the gate";
  SI.VolumeFlowRate Vdot_full "Fully submerged base volume flow rate through the gate";
  Real Cdx "Discharge coefficient tuned for a smooth transition between partially and fully submerged";

equation
  Vdot_free = sqrt(2*data.g)* W * T^TE * B^BE * h_i^HE "Free flow condition";
  Vdot_partial = sqrt(2*data.g)* W * T^TE * B^BE * (3*(h_i-h_o))^HE "Partially submerged";
  Vdot_full =  sqrt(2*data.g*(h_i-h_o))* W * B "Fully submerged";
  Cdx = Cd * Vdot_partial/Vdot_full;
  if H_ratio <= 0.67 then
    Vdot=Cd * Vdot_free "Free flow condition";
  elseif H_ratio <= 0.8 then
    Vdot= Cd * Vdot_partial "Partially submerged";
  else
    Vdot= Cdx * Vdot_full "Fully submerged";
  end if;
  mdot = Vdot * data.rho "Mass flow rate through the gate";
  i.p = h_i * data.g * data.rho + data.p_a "Inlet water pressure";
  o.p = h_o * data.g * data.rho + data.p_a "Outlet water pressure";
  annotation (Documentation(info="<html>
<h4>Background</h4>
<p>
The Tainter Gate (also known as Radial Gate) is modelled based on a simplified calculation
 as used in the <a href=\"https://en.wikipedia.org/wiki/HEC-RAS\">HEC-RAS</a> simulation software.
More specifically the following documentation is taken from the
<a href=\"https://www.hec.usace.army.mil/confluence/rasdocs/ras1dtechref/latest\">
HEC-RAS Hydraulic Reference Manual</a> on <a href=\"https://www.hec.usace.army.mil/confluence/rasdocs/ras1dtechref/latest/modeling-gated-spillways-weirs-and-drop-structures/hydraulic-computations-through-gated-spillways/radial-gates\">Radial Gates</a>.
</p>
<figure>
<img src=\"modelica://OpenHPL/Resources/Images/TainterGate.png\"/>
  <figcaption>Example Radial Gate with an Ogee Spillway Crest [HEC-RAS].</figcaption>
</figure>
<h4>Implementation</h4>
<p>
The calculation of the flow through the gate is approximated for three different regions:
</p>
<h5>Free flowing</h5>
<p>
$$Q = C_d W T^{T_E} B^{B_E} H^{H_E} \\sqrt{2g} \\tag{1} $$
(valid for gate opening higher than the downstream water level)
</p>
<h5>Partially submerged</h5>
<p>
$$Q = C_d W T^{T_E} B^{B_E} (3H)^{H_E} \\sqrt{2g} \\tag{2} $$
(valid for the region where the ratio of downstream water level to upstream water level (<code>H_ratio = h_o/h_i</code>) is between 0.67 and 0.8)
</p>
<h5>Fully submerged</h5>
<p>
$$Q = C_{dx} A \\sqrt{2gH} \\tag{3}$$
(otherwise with <code>Cdx</code> being a discharge coefficient tuned for a smooth transition between partially and fully submerged)
</p>
<p>
<strong>Note:</strong>
The use of <code>Cdx</code> is different to the implementaion as done in HEC-RAS. This was done in order to have a smoother transition from the partially to fully submerged region.
</p>
</html>"));
end Gate_HR;
