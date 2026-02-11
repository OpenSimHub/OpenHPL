within OpenHPL.UsersGuide.OpenHPLElements.WaterwayModels;
class DraftTube "Description of Draft Tube unit"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4>Draft Tube</h4>
<p>
The draft tube is a critical component in reaction turbines (Francis, Kaplan) that connects the turbine runner outlet to the 
tailrace. Its primary function is to convert residual kinetic energy from the turbine into pressure energy, thereby improving 
overall turbine efficiency and enabling installation of the turbine above tailwater level.
</p>

<h5>Draft Tube Types</h5>
<p>
The OpenHPL library includes models for two types of draft tubes:
</p>
<ul>
<li><strong>Conical Diffuser</strong>: A simple conical expanding tube with gradually increasing diameter</li>
<li><strong>Moody Spreading Pipe</strong>: A more complex design with main and branch sections, commonly used in larger installations</li>
</ul>

<h5>Model Implementation</h5>
<p>
The draft tube model is based on mass and momentum conservation. Key features include:
</p>
<ul>
<li>Variable cross-sectional area from inlet (D<sub>i</sub>) to outlet (D<sub>o</sub>)</li>
<li>Pressure recovery through area expansion</li>
<li>Friction losses along the tube walls</li>
<li>Support for inclined installation (angle \\(\\theta\\))</li>
<li>Different geometrical configurations depending on draft tube type</li>
</ul>

<h5>Conical Diffuser Parameters</h5>
<p>
For the conical diffuser type:
</p>
<ul>
<li>\\(H\\): Vertical height of the diffuser [m]</li>
<li>\\(L\\): Slant height of the diffuser [m]</li>
<li>\\(D_i\\): Inlet diameter [m]</li>
<li>\\(D_o\\): Outlet diameter [m]</li>
<li>\\(\\theta\\): Inclination angle [°]</li>
<li>Diffusion angle: Typically 8° for optimal performance</li>
</ul>

<h5>Moody Spreading Pipe Parameters</h5>
<p>
For the Moody spreading pipe configuration:
</p>
<ul>
<li>\\(L_m\\): Length of main section [m]</li>
<li>\\(L_b\\): Length of branch section [m]</li>
<li>\\(\\theta_{moody}\\): Branching angle (15°, 30°, 45°, 60°, or 90°)</li>
</ul>

<h5>Application</h5>
<p>
The draft tube model is essential for accurate simulation of reaction turbine systems. It affects:
</p>
<ul>
<li>Overall plant efficiency by recovering kinetic energy</li>
<li>Cavitation characteristics at the turbine outlet</li>
<li>Dynamic response during transient operations</li>
<li>Pressure pulsations and hydraulic stability</li>
</ul>

<p>
The model is particularly important when studying load rejection scenarios, start-up/shutdown sequences, or when 
optimizing turbine installation elevation relative to tailwater.
</p>
</html>", revisions=""));
end DraftTube;
