within OpenHPL.UsersGuide.OpenHPLElements.ElectroMechModels;
class Pelton "Description of Pelton turbine model"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4>Pelton Turbine</h4>
<p>
Similar to the Francis turbine model, the mechanistic Pelton turbine model is developed and used. The key quantities
of the model are shown in the figure, and the shaft power \\(\\dot{W}_s\\) produced in the Pelton turbine is defined
as follows:
</p>

<p align=\"center\">
  <img src=\"modelica://OpenHPL/Resources/Images/Pelton_turb.png\" alt=\"Pelton turbine\" width=\"600\"/>
</p>
<p><em>Figure: Some key concepts of the Pelton turbine.</em></p>

<p>
$$ \\dot{W}_s=\\dot{m}v_R\\left[\\delta(u_\\delta)\\cdot v_1-v_R\\right]\\left(1-k\\cos\\beta\\right) $$
</p>
<p>
Here, \\(\\dot{m}\\) is the mass flow rate through the turbine. The reference velocity is equal to \\(v_R = \\omega R\\):
here, \\(R\\) is a is the radius of the rotor where the mass hits the bucket and \\(\\omega\\) is the angular velocity
that is normally constrained by the grid frequency. The water velocity at position \"1\" is equal to \\(v_1=\\frac{\\dot{V}}{A_1}\\),
where \\(\\dot{V}\\) is the volumetric flow rate through the turbine and \\(A_1\\) is a cross-sectional area at position \"1\"
(the end of the nozzle). \\(\\beta\\) is the reflection angle with typical value of \\(\\beta= 165^{\\circ}\\), and
\\(k<1\\) is some friction factor, typically \\(k\\in[0.8, 0.9]\\). In practical installations, there is a deflector
mechanism to reduce the velocity \\(v_1\\delta(u_\\delta)\\) to avoid over-speed.
</p>

<p>
The total work rate \\(\\dot{W}_t\\) removed through the turbine is:
</p>
<p>
$$ {\\dot{W}_t} = {\\dot{W}_s+\\dot{W}_{ft}} $$
</p>
<p>
Here, \\(\\dot{W}_{ft}\\) is a friction of losses that can be found as follows:
</p>
<p>
$$ \\dot{W}_{ft}=K\\left(1-k\\cos\\beta\\right)\\dot{m}v_R^2 $$
</p>
<p>
Here, friction coefficient \\(K\\) equals 0.25.
</p>

<p>
In addition, the pressure drop across the nozzle (positions \"0\" and \"1\") \\(\\Delta p_n\\) can be found as follows:
</p>
<p>
$$ \\Delta p_n=\\frac{1}{2}\\rho\\dot{V}\\left[\\dot{V}\\left(\\frac{1}{A_1^2(Y)}-\\frac{1}{A_0^2}\\right)+k_f\\right] $$
</p>
<p>
Here, \\(A_0\\) is a cross sectional area at position \"0\" (the beginning of the nozzle). \\(A_1(Y)\\) means that the
cross-sectional area at position \"1\" is a function of the needle position \\(Y\\). \\(k_f\\) is a coefficient of friction
loss in the nozzle.
</p>

<h5>Implementation</h5>
<p>
Hence, this Pelton turbine model is realized in the <em>Pelton</em> turbine element in our library. In this <em>Pelton</em>
unit, the multi-physic <em>TurbineContacts</em> connectors model is also used and ensures connection to other waterway
and electro-mechanical units. In addition, this <em>Pelton</em> unit also has the standard Modelica <em>RealInput</em>
connector that describes the angular velocity as an input to the Pelton turbine model. Typically, this angular velocity
connector is based on the derived info from (connected to) the generator units.
</p>

<h5>Parameters</h5>
<p>
In the <em>Pelton</em> unit, the user can specify the required geometry for the Pelton turbine: radius of the turbine
runner, input diameter of the nozzle, runner bucket angle, friction factors and coefficients, and deflector mechanism
coefficient.
</p>
</html>", revisions=""));
end Pelton;
