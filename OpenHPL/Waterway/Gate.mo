within OpenHPL.Waterway;
model Gate "Model of a sluice or tainter gate based on [Bollrich2019]"
  outer Data data "Using standard class with system parameters";
  extends Icons.Gate;
  extends Interfaces.TwoContacts;
  import Modelica.Units.Conversions.to_deg;
  parameter SI.Height b "Width of the gate" annotation (Dialog(group="Common"));
  parameter SI.Length r "Radius of the gate arm" annotation (Dialog(enable=not sluice, group="Radial/Tainter"));
  parameter SI.Height h_h "Height of the hinge above gate bottom" annotation (Dialog(group="Radial/Tainter", enable=not sluice));
  SI.Height h_0 "Inlet water level";
  SI.Height h_2 "Outlet water level";
  SI.Height h_2_limit "Limit of free flow";
  SI.Area A = a*b "Area of the physical gate opening";
  SI.MassFlowRate mdot "Mass flow rate";
  SI.VolumeFlowRate Vdot "Volume flow rate through the gate";
  Real mu_A "Discharge coefficient";
  Real psi "Contraction coefficient";
  //Real psi90 "Contraction coefficient for vertical gate";
  Real chi "Back-up coefficient";
  SI.Angle alpha = C.pi/2 - asin((h_h-a)/r) "Edge angle of the gate";
  Real x,y,z;
  Real h0_a = h_0/a;
  Real h2_a = h_2/a;
  Modelica.Blocks.Interfaces.RealInput a "Opening of the gate [m]" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={0,120})));
equation
  mu_A = psi/sqrt(1+psi*a/h_0);
  if sluice then
    psi = 1 / (1+ 0.64 * sqrt(1-(a/h_0)^2)) "Sluice gate, i.e. alpha = 90 deg";
  else
    psi = 1.3 - 0.8 * sqrt(1 - ((to_deg(alpha)-205)/220)^2) "Normally only valid for a/h_0 --> 0";
  end if;
      x = (1-2*psi*a/h_0*(1-psi*a/max(C.small,h_2)))^2;
    y = x+z-1;
    z = (h_2/h_0)^2;

  h_2_limit = a*psi/2*(sqrt(1+16/(psi*(1+psi*a/h_0)) * (h_0/a))-1);

  if h_2 >= h_2_limit then
    chi = sqrt((1+psi*a/h_0) * ((1-2*psi*a/h_0 * (1-psi*a/h_2))-
          sqrt((1-2*psi*a/h_0*(1-psi*a/max(C.small,h_2)))^2 + (h_2/h_0)^2 - 1))) "Backed-up flow";
  else
    chi = 1 "Free flow";
  end if;

  i.mdot+o.mdot = 0 "Mass balance";
  mdot = i.mdot "Inlet direction for mdot";
  Vdot = chi * mu_A * A * sqrt(2*data.g*h_0) "Volume flow rate through the gate";
  mdot = Vdot * data.rho "Mass flow rate through the gate";
  i.p = h_0 * data.g * data.rho + data.p_a "Inlet water pressure";
  o.p = h_2 * data.g * data.rho + data.p_a "Outlet water pressure";
  annotation (
    preferredView="info",
    Documentation(info="<html>
<h4>Implementation</h4>
<p>
The calculation of the flow through the gate is approximated for two different regions and is based
on <a href=\"modelica://OpenHPL.UsersGuide.References\">[Bollrich2019]</a>.
Equation numbers and figure numbers given below are in sync with the numbers of <a href=\"modelica://OpenHPL.UsersGuide.References\">[Bollrich2019]</a>.
</p>
<h5>Free flowing</h5>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://OpenHPL/Resources/Images/TainterGate-freeflow.png\"
           alt=\"TainterGate free flow\">
    </td>
  </tr>
  <caption align=\"bottom\"><strong>Fig. 8.13:</strong> Free flow through the tainter gate (source:
  <a href=\"modelica://OpenHPL.UsersGuide.References\">[Bollrich2019]</a>, page 376)</caption>
</table>
<p>
The free flow can be calculated with:

$$ Q_A = \\mu_A \\cdot A \\cdot \\sqrt{2g\\cdot h_0} \\tag{8.24} $$

(valid for gate opening higher than the downstream water level)
</p>
<p>
With
</p>
<dl><dd>Opening area</dd>
<dt> $$ A = a\\cdot b $$ </dt>
<dd>Discharge coefficient</dd>
<dt> $$ \\mu_A = \\frac{\\psi}{\\sqrt{1+\\frac{\\psi\\cdot a}{h_0}}} \\tag{8.23}$$ </dt>
<dd>Contraction coefficient sluice gate (\\(\\alpha=90^\\circ\\))</dd>
<dt> $$ \\psi_{90^\\circ}= \\frac{1}{1+0.64\\cdot \\sqrt{1-(a/h_0)^2}} \\tag{8.25}$$ </dt>
<dd>Contraction coefficient radial gate (for \(a/h_0 \\rightarrow 0\))</dd>
<dt> $$ \\psi_0(\\alpha)= 1.3 -0.8\\cdot\\sqrt{1-\\left(\\frac{\\alpha -205^\\circ}{220^\\circ}\\right)^2} \\tag{8.25a}$$ </dt>
<dd> The edge angle \(\\alpha\) of the gate </dd>
<dt> $$ \\alpha = \\left( \\frac{\\pi}{2} - \\arcsin(\\frac{h_h-a}{r})\\right) \\cdot \\frac{180^\\circ}{\\pi} $$ </dt>
</dl>
<blockquote>
With:
<ul>
<li> \(a \\ldots\) Vertical gate opening </li>
<li> \(h_h \\ldots\) Height of the hinge above gate bottom</li>
<li> \(r \\ldots\) Radius of the gate arm </li>
</ul>
</blockquote>

<h5>Backed-up discharge</h5>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://OpenHPL/Resources/Images/TainterGate-backedup.png\"
           alt=\"TainterGate backed-up flow\">
    </td>
  </tr>
  <caption align=\"bottom\"><strong>Fig. 8.16:</strong> Backed-up flow through the tainter gate (source:
  <a href=\"modelica://OpenHPL.UsersGuide.References\">[Bollrich2019]</a>, page 379)</caption>
</table>
<p>
$$Q_A = \\chi \\cdot \\mu_A \\cdot A \\cdot \\sqrt{2g\\cdot h_0} \\tag{8.29} $$

With
</p>
<dl>
<dd>Back-up coefficient</dd>
<dt> $$ \\chi = \\sqrt{
              \\left(
                   1 + \\frac{\\psi\\cdot a}{h_0}
                 \\right) \\cdot
                 \\left\\{
                   \\left[
                     1 - 2\\cdot\\frac{\\psi\\cdot a}{h_0} \\cdot
                     \\left(
                       1-\\frac{\\psi\\cdot a}{h_2}
                     \\right)
                   \\right]
                   - \\sqrt{
                       \\left[
                         1 - 2 \\cdot \\frac{\\psi\\cdot a}{h_0} \\cdot
                         \\left(
                           1-\\frac{\\psi\\cdot a}{h_2}
                         \\right)
                       \\right]^2
                       +
                   \\left(
                           \\frac{h_2}{h_0}
                      \\right)^2
                      - 1
                     }
                 \\right\\}
               } \\tag{8.28}$$ </dt>
</dl>

<h5>Boundary between free and backed-up flow</h5>
<p>
The boundary of the height of the water level \(h_2\) behind the gate from which on the calculation switches to the backed-up flow (8.29) can be derived from:

$$ \\frac{h_2^*}{a} = \\frac{\\psi}{2} \\cdot \\left( \\sqrt{ 1 + \\frac{16}{\\psi\\cdot\\left(1+\\frac{\\psi\\cdot a}{h_0}\\right)}\\cdot\\frac{h_0}{a}} - 1 \\right) \\tag{8.26}$$

So when \(\\frac{h_2}{a} \\geq \\frac{h_2^*}{a}\) then we have back-up flow.
</p>
</html>",
    __OpenModelica_infoHeader = "<script type=\"text/javascript\" src=\"https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-AMS_CHTML\"></script>"));
end Gate;