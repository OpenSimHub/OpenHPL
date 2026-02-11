within OpenHPL.UsersGuide.OpenHPLElements.WaterwayModels;
class SurgeTank "Description of Surge Tank unit"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4>Surge Tank</h4>
<p>
The surge shaft/tank will be presented here as a vertical open pipe with constant diameter together with manifold, 
which connecting conduit, surge volume and penstock. Surge volume (vertical open pipe) is shown in the figure below.
</p>

<p align=\"center\">
  <img src=\"modelica://OpenHPL/Resources/Images/surgepic.png\" alt=\"Surge tank model\" width=\"400\"/>
</p>
<p><em>Figure: Model for a vertical open pipe.</em></p>

<h5>Mass and Momentum Balances</h5>
<p>
The model for the surge volume can be described by mass and momentum balances as follows:
</p>
<p>
\\[
\\begin{array}{c}
\\frac{dm_\\mathrm{s}}{dt} = \\dot{m}_\\mathrm{s,in} = \\rho \\dot{V}_\\mathrm{s}\\\\
\\frac{dm_\\mathrm{s}v_\\mathrm{s}}{dt} =\\dot{m}_\\mathrm{s,in}v_\\mathrm{s,in}+F_\\mathrm{p,s}+F_\\mathrm{g,s}+F_\\mathrm{f,s}
\\end{array}
\\]
</p>

<h5>Water Mass and Geometry</h5>
<p>
Here, the mass of the water in the surge tank is \\(m_\\mathrm{s}=\\rho V_\\mathrm{s}=\\rho l_\\mathrm{s}A_\\mathrm{s}=\\rho A_\\mathrm{s}\\frac{h_\\mathrm{s}}{\\cos\\theta_\\mathrm{s}}\\), 
where ρ is the water density, V<sub>s</sub> is the volume of the water in the surge tank, h<sub>s</sub> and 
l<sub>s</sub> are the height and length of the surge tank filled with water and A<sub>s</sub> is the cross-section 
area of the surge tank that defined from the vertical pipe diameter D<sub>s</sub>. The water velocity 
\\(v_\\mathrm{s}\\) can be defined as \\(v_\\mathrm{s}=\\dot{V}_\\mathrm{s}/A_\\mathrm{s}\\). The inlet water 
velocity \\(v_\\mathrm{s,in}=\\dot{V}_\\mathrm{s}/A_\\mathrm{s}\\).
</p>

<h5>Forces</h5>
<p>
F<sub>p,s</sub> is the pressure force, due to the difference between the inlet and outlet pressures p<sub>s,1</sub> 
and p<sup>atm</sup> and can be calculated as follows: 
\\(F_\\mathrm{p,s}=A_\\mathrm{s}\\left(p_\\mathrm{s,1}-p_\\mathrm{atm}\\right)\\). There is also gravity force that 
is defined as \\(F_\\mathrm{g,s}=m_\\mathrm{s}g\\cos\\theta_\\mathrm{s}\\), where g is the gravitational 
acceleration and θ<sub>s</sub> is the angle of the slope of the surge tank and can be defined from the ratio of 
height difference H<sub>s</sub> and length L<sub>s</sub>. The last term in the momentum balance is friction force, 
which can be calculated as \\(F_\\mathrm{f,s}=-\\frac{1}{8}l_\\mathrm{s}f_\\mathrm{D,s}\\pi\\rho D_\\mathrm{s}v_\\mathrm{s}|v_\\mathrm{s}|\\) 
using Darcy friction factor f<sub>D,s</sub> for the surge tank.
</p>

<h5>Manifold</h5>
<p>
The manifold is described by the preservation of mass in steady-state; the volumetric flow rate in the intake race 
\\(\\dot{V}_\\mathrm{i}\\) equals to the sum of volumetric flow rates from surge volume \\(\\dot{V}_\\mathrm{s}\\) 
and penstock \\(\\dot{V}_\\mathrm{p}\\): \\(\\dot{V}_\\mathrm{i}=\\dot{V}_\\mathrm{p}+\\dot{V}_\\mathrm{s}\\). 
In addition, the manifold pressure is equal for all three connections. This manifold is already implemented in the 
<code>ContactNode</code> connectors model that is used in this <code>SurgeTank</code> unit. Then, this unit can be 
connected to other waterway units.
</p>

<h5>Parameters and Initialization</h5>
<p>
In the <code>SurgeTank</code> unit, the user can specify the required geometry parameters for the surge tank 
(vertical pipe): length L<sub>s</sub>, height difference H<sub>s</sub>, diameters D<sub>s</sub>, pipe roughness 
height ε<sub>s</sub>, and value for the atmospheric pressure p<sup>atm</sup>. In order to define the friction force 
F<sub>f,s</sub> the <code>Friction</code> function is used here. This unit can be initialized by the initial values 
of the flow rate \\(\\dot{V}_\\mathrm{s,0}\\) and water height h<sub>s,0</sub>. Otherwise, the user can decide on 
an option when the simulation starts from the steady-state and the OpenModelica automatically handles the initial 
steady-state values (does not work properly in OpenModelica).
</p>
</html>", revisions=""));
end SurgeTank;
