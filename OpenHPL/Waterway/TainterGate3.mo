within OpenHPL.Waterway;
model TainterGate3 "Model of a tainter gate based on [Bollrich2019]"
  outer Data data "Using standard class with system parameters";
  extends Icons.TainterGate;
  extends OpenHPL.Interfaces.ContactPort;

//   parameter SI.Height b_max "Maxium opening of the gate";
//   parameter SI.Height b_min = 0 "Minimum opening of the gate";
  parameter SI.Length r "Radius of the gate arm";
  parameter SI.Height a "Height of the hinge above gate bottom";
  parameter SI.Height b "Width of the gate";
  parameter Real Cc_[3] = {1,2,3} "Polinomial factors of contraction coefficient Cc {linear,quadratic,cube}";
  SI.Height h_i "Inlet water level";
  SI.Height h_o "Outlet water level";
  Real alpha = h_o/(Cc*u);
  Real beta = h_i/h_o;
  Real gamma = (h_o/(Cc*u))^2 - (h_o/h_i)^2 "Loss factor";
  Real psi = (1/beta)^2 - 1 + (gamma^2*(beta-1))/(psi_x1 + psi_x2) "Head-loss parameter";
  Real psi_ = (1/beta)^2 - 1 + (gamma^2*(beta-1))/(psi_x1 - psi_x2) "Neg Head-loss parameter";
  Real psi_x1 = gamma*beta-2*(alpha-1);
  Real psi_x2 =  sqrt((2*(alpha-1)-gamma*beta)^2 - gamma^2*(beta^2-1));

  SI.Angle theta = C.pi/2 - asin((a-u)/r) "Flow angle of the gate";
  Real Cc = Cc_[3]*theta^3 + Cc_[2]*theta^2 + Cc_[1]*theta + 1.002282138151680 "Contraction coefficient";
  SI.VolumeFlowRate Vdot,Vdot_gamma "Volume flow rate through the gate";

    Modelica.Blocks.Interfaces.RealInput u "Opening of the gate [m]" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={0,120})));
equation
  Vdot = b*h_o * sqrt((2*data.g*max(0,(h_i - h_o)))/(psi + 1 - (h_o/h_i)^2)) "Calculated flow";
  Vdot_gamma = b*h_o * sqrt((2*data.g*max(0,(h_i - h_o)))/(gamma + 1 - (h_o/h_i)^2)) "Calculated flow";
  mdot = Vdot * data.rho "Mass flow rate through the gate";
  i.p = h_i * data.g * data.rho + data.p_a "Inlet water pressure";
  o.p = h_o * data.g * data.rho + data.p_a "Outlet water pressure";
  annotation (Documentation(info="<html>
<h4>Implementation</h4>
<p>
The calculation of the flow through the gate is approximated for two different regions and is based 
on <a href=\"modelica://OpenHPL.UsersGuide.References\">[Bollrich2019]</a>. 
Equation numbers oand figure numbers given below are in sync with the numbers of <a href=\"modelica://OpenHPL.UsersGuide.References\">[Bollrich2019]</a>. 
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
  <a href=\"modelica://OpenHPL.UsersGuide.References\">[Bollrich2019]</a>, page 376)<caption>
</table>
<p>
The free flow can be calulate with:

$$Q_A = \\mu_A \\cdot A \\cdot \\sqrt{2g\\cdot h                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 _0} \\tag{8.24} $$
(valid for gate opening higher than the downstream water level)

With 
<dl><dd>Opening area</dd>
<dt> $$ A = a\\cdot b $$ </dt>
<dd>Discharge coefficient</dd>
<dt> $$ \\mu_A = \\frac{\\psi}{\\sqrt{1+\\frac{\\psi\\cdot a}{h_0}}} \\tag{8.23}$$ </dt>
<dd>Contraction coefficient (for \\(a/h_0 \\rightarrow 0\\))</dd>
<dt> $$ \\psi_0(\\alpha)= 1.3 -0.8\\cdot\\sqrt{1-\\left(\\frac{\\alpha -205^\\circ}{220^\\circ}\\right)^2} \\tag{8.25a}$$ </dt>
</dl>
</p>
</p>

<h5>Backed-up discharge</h5>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://OpenHPL/Resources/Images/TainterGate-backedup.png\"
           alt=\"TainterGate backed-up flow\">
    </td>
  </tr>
  <caption align=\"bottom\"><strong>Fig. 8.16:</strong> Backed-up flow through the tainter gate (source:
  <a href=\"modelica://OpenHPL.UsersGuide.References\">[Bollrich2019]</a>, page 379)<caption>
</table>
<p>
$$Q_A = \\chi \\cdot \\mu_A \\cdot A \\cdot \\sqrt{2g\\cdot h_0} \\tag{8.29} $$

With 
<dl>
<dd>Back-up factor</dd>
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
</p>
<h5>Boundary between free and backed-up flow</h5>
<p>
The boundary of the height of the water level \\(h_2\\) behind the gate from which on the calculation switches to the backed-up flow (8.29) can be derived from:

$$ \\frac{h_2^*}{a} = \\frac{\\psi}{2} \\cdot \\left( \\sqrt{ 1 + \\frac{16}{\\psi\\cdot\\left(1+\\frac{\\psi\\cdot a}{h_0}\\right)}\\cdot\\frac{h_0}{a}} - 1 \\right) \\tag{8.26}$$

So when \\(\\frac{h_2}{a} \\geq \\frac{h_2^*}{a}\\) then we have back-up flow.
</p>
</html>"));
end TainterGate3;
