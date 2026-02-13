within OpenHPL.ElectroMech.Generators;
model SimpleGen "Model of a simple generator with mechanical connectors"
  extends BaseClasses.Power2Torque(f_0=data.f_0, final enable_nomSpeed=false, power(y=-Pload));
  extends OpenHPL.Icons.Generator;

  Modelica.Blocks.Interfaces.RealInput Pload(unit="W") "Electrical load power demand" annotation (Placement(
      transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120}),
      iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));

  annotation (
    Documentation(info= "<html>
<h4>Simple Generator Model</h4>
<p>Simple model of an ideal generator with friction based on angular momentum balance.</p>

<h5>Energy Balance</h5>
<p>The kinetic energy stored in the rotating generator is \\(K_a = \\frac{1}{2}J_a\\omega_a^2\\), 
where ω<sub>a</sub> is angular velocity and J<sub>a</sub> is moment of inertia.</p>

<p>From energy balance:</p>
<p>$$ \\frac{\\mathrm{d}K_a}{\\mathrm{d}t} = \\dot{W}_s - \\dot{W}_{f,a} - \\dot{W}_g $$</p>
<p>where:</p>
<ul>
<li>Ẇ<sub>s</sub> is turbine shaft power</li>
<li>Ẇ<sub>f,a</sub> is frictional power loss</li>
<li>Ẇ<sub>g</sub> is power taken by generator</li>
</ul>

<h5>Friction</h5>
<p>Frictional power loss (mainly from bearings):</p>
<p>$$ \\dot{W}_{f,a} = \\frac{1}{2}k_{f,b}\\omega_a^2 $$</p>
<p>where k<sub>f,b</sub> is the bearing friction factor.</p>

<h5>Electric Power</h5>
<p>Electric power available on grid:</p>
<p>$$ \\dot{W}_e = \\eta_e \\dot{W}_g $$</p>
<p>where η<sub>e</sub> is electrical efficiency.</p>

<h5>Loading Options</h5>
<p>The generator can be loaded either:</p>
<ul>
<li>via the mechanical shaft connector (e.g., using the <a href=\"modelica://OpenHPL.ElectroMech.PowerSystem.Grid\">Grid</a> model). 
Set <code>Pload</code> input to 0 in this case.</li>
<li>or via the input connector <code>Pload</code> specifying the connected electrical load.</li>
</ul>

<h5>Connectors</h5>
<ul>
<li>RealInput: grid power (<code>Pload</code>) and shaft power</li>
<li>RealOutput: angular velocity and frequency</li>
</ul>

<h5>Parameters</h5>
<p>User specifies: moment of inertia, electrical efficiency, bearing friction factor, number of poles, and initial angular velocity.</p>

<p align=\"center\">
<img src=\"modelica://OpenHPL/Resources/Images/simplegen.svg\">
</p>
</html>"), Icon(graphics={
        Text(
          extent={{-20,100},{20,86}},
          textColor={0,0,0},
          textString="P_load")}));
end SimpleGen;
