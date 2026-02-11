within OpenHPL.UsersGuide;
package Examples "Examples of hydropower systems"
  extends Modelica.Icons.ExamplesPackage;
  
  annotation (Documentation(info="<html>
<h4>Examples</h4>
<p>
This section describes various example models demonstrating the use of OpenHPL components to build complete hydropower system models. These examples progressively introduce complexity from simple turbine models to detailed electromechanical systems with grid integration.
</p>

<h5>Organization</h5>
<p>
OpenHPL provides examples in two packages:
</p>
<ul>
<li><strong>OpenHPL.Examples</strong>: Ready-to-run example models demonstrating basic usage of individual components 
(e.g., SimpleTurbine, SimpleGen, BranchingPipes, Gate, VolumeFlowSource, etc.)</li>
<li><strong>OpenHPLTest</strong>: Comprehensive test cases and case studies including validation models, detailed system 
configurations, and integration examples with OpenIPSL (e.g., HPSimplePenstockFrancis, HPElasticKPPenstock, etc.)</li>
</ul>

<h5>Example Models Documented in this Section</h5>
<p>
The examples documented below are from the OpenHPLTest package and represent typical hydropower system configurations 
of varying complexity. They are organized as follows:
</p>
<ul>
<li><strong>Simple models</strong> (HPSimple, HPSimpleGenerator, HPSimpleFrancis): Basic configurations using simplified 
component models for initial design and conceptual studies</li>
<li><strong>Detailed models</strong> (HPDetailed, HPDetailedGenerator, HPDetailedFrancis): Advanced configurations with 
elastic penstock models (KP method), detailed turbine characteristics, and realistic system dynamics</li>
<li><strong>Grid integration models</strong> (HPSimpleFrancisIPSLGen, HPSimpleFrancisGridGen, etc.): Examples demonstrating 
integration with electrical grid models using either simplified Grid model or OpenIPSL library components</li>
<li><strong>Specialized models</strong> (HPSimpleOpenChannel): Examples showcasing specific OpenHPL features like open 
channel flow modeling</li>
</ul>

<p>
Users starting with OpenHPL should first explore the simple examples to understand basic modeling concepts, then progress 
to detailed and grid integration examples as needed for their applications.
</p>
</html>", revisions=""));
end Examples;
