within OpenHPL.UsersGuide.OpenHPLElements.ElectroMechModels;
class SimpleGenerator "Simple Generator Model"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<h4>Simple Generator</h4>
<p>
A simple model of an ideal generator with friction is based on angular momentum balance. The kinetic energy 
stored in the rotating generator is \\(K_a = \\frac{1}{2}J_a\\omega_a^2\\), where ω<sub>a</sub> 
is angular velocity and J<sub>a</sub> is moment of inertia.
</p>

<h5>Energy Balance</h5>
<p>
From energy balance:
</p>
<p>
$$ \\frac{dK_a}{dt} = \\dot{W}_s - \\dot{W}_{f,a} - \\dot{W}_g $$
</p>
<p>
where Ẇ<sub>s</sub> is turbine shaft power, Ẇ<sub>f,a</sub> is frictional power loss, and Ẇ<sub>g</sub> 
is power taken by generator.
</p>

<h5>Friction</h5>
<p>
Frictional power loss (mainly from bearings): \\(\\dot{W}_{f,a} = \\frac{1}{2}k_{f,b}\\omega_a^2\\) 
where k<sub>f,b</sub> is bearing friction factor.
</p>

<h5>Electric Power</h5>
<p>
Electric power available on grid: \\(\\dot{W}_e = \\eta_e \\dot{W}_g\\) where η<sub>e</sub> is 
electrical efficiency.
</p>

<h5>Implementation</h5>
<p>
The <code>SimpleGen</code> unit has <code>RealInput</code> connectors for grid power and shaft power, 
and <code>RealOutput</code> connectors for angular velocity and frequency.
</p>

<h5>Parameters</h5>
<p>
User specifies: moment of inertia, electrical efficiency, bearing friction factor, number of poles, and 
initial angular velocity.
</p>
</html>"));
end SimpleGenerator;
