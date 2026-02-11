within OpenHPL.UsersGuide.OpenHPLElements;
class Governor "Description of Governor model"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4>Governor</h4>
<p>
Here, a simple model of the governor that controls the guide vane opening in the turbine based on the reference power 
production is described. The block diagram of this governor model is shown in the figure.
</p>

<p align=\"center\">
  <img src=\"modelica://OpenHPL/Resources/Images/Governor.png\" alt=\"Governor block diagram\" width=\"600\"/>
</p>
<p><em>Figure: Block Diagram of the governor.</em></p>

<h5>Implementation</h5>
<p>
Using the model in the figure and the standard Modelica blocks, the governor model is encoded in our library as the 
<em>Governor</em> unit. This unit has inputs as the reference power production and generator frequency that are implemented 
with the standard Modelica <em>RealInput</em> connector. This <em>Governor</em> unit also uses the standard Modelica 
<em>RealOutput</em> connectors in order to provide output information about the turbine guide vane opening.
</p>

<h5>Parameters</h5>
<p>
In the <em>Governor</em> unit (note: in the text it mentions <em>SynchGen</em> but this appears to be a typo in the 
original document - should be <em>Governor</em>), the user can specify the various time constants of this model (see 
figure): pilot servomotor time constant T<sub>p</sub>, primary servomotor integration time T<sub>g</sub>, and transient 
droop time constant T<sub>r</sub>. The user should also provide the following parameters: droop value σ, transient droop δ, 
and nominal values for the frequency and power generation. The information about the maximum, minimum, and initial guide 
vane opening should also be specified.
</p>
</html>", revisions=""));
end Governor;
