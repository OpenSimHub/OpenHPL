within OpenHPL.UsersGuide.BasicExample;
class Flowsheet "Creating a Flowsheet Model"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<h4>Flowsheet</h4>
<p>
To create a flowsheet model for a hydropower system in OpenModelica using <strong>OpenHPL</strong>, 
follow these steps:
</p>

<h5>Step 1: Create New Model</h5>
<p>
Create a new Modelica class specified as \"Model\" and assigna name. Open with \"Diagram view\".
</p>

<h5>Step 2: Add Components</h5>
<p>
Drag and drop needed elements for the hydropower structure from <strong>OpenHPL</strong>, provide names 
for each element, and connect their connectors.
</p>

<h5>Step 3: Add Data Record</h5>
<p>
Insert the <code>Data</code> record model from <strong>OpenHPL</strong> with name \"data\" to control 
common constants and properties for all hydropower elements, such as typical initial flow rates.
</p>

<h5>Step 4: Specify Parameters</h5>
<p>
Specify each element with appropriate geometry parameters.
</p>

<h5>Step 5: Provide Control Signal</h5>
<p>
Provide a control signal for the turbine either by:
</p>
<ul>
<li>Adding a source signal from standard Modelica library (e.g., <code>Modelica.Blocks.Sources.Ramp</code>)</li>
<li>Creating an input variable and equating it to the turbine control input</li>
</ul>

<h5>Step 6: Simulate</h5>
<p>
Specify simulation setup values, save in the model, and run the simulation.
</p>

<h5>Screenshots</h5>
<p>
Refer to the original User's Guide PDF for detailed screenshots showing each step.
</p>
</html>"));
end Flowsheet;
