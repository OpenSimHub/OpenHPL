within OpenHPL.UsersGuide.BasicExample;
class OMPythonAPI "Using OMPython API"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<h4>OMPython API</h4>
<p>
To run simulations of a hydropower model from Python using the OMPython API for OpenModelica:
</p>

<h5>Step 1: Import and Create Object</h5>
<p>
Import the \"Modelica system\" environment and create an object of the OpenModelica model:
</p>
<pre>
from OMPython import ModelicaSystem
hps_s = ModelicaSystem(\"OpenHPL_example.mo\", \"OpenHPL_example\", 
                      [\"Modelica\", \"OpenHPL/package.mo\"])
</pre>

<h5>Step 2: Set Simulation Options</h5>
<p>
Specify simulation options, parameters, and input variables:
</p>
<pre>
hps_s.setSimulationOptions(stepSize=0.1, stopTime=1000)
hps_s.getSimulationOptions()  # get list of options
hps_s.getParameters()  # get list of parameters
hps_s.setParameters(**{\"turbine.H_n\":460})  # set parameter
hps_s.getInputs()  # get list of inputs
hps_s.setInputs(u=[(0,0.75),(100,0.75),(101,0.7),(1000,0.7)])  # ramp signal
</pre>

<h5>Step 3: Run and Get Results</h5>
<p>
Run simulation and retrieve results:
</p>
<pre>
hps_s.simulate()
hps_s.getSolutions()  # get list of solution variables
time, Vdot, p_tr1, p_tr2 = hps_s.getSolutions(\"time\", \"turbine.Vdot\", 
                                               \"turbine.p_tr1\", \"turbine.p_tr2\")
</pre>
<p>
Results can be plotted using <em>matplotlib</em> package.
</p>

<h5>Step 4: Linearization (Optional)</h5>
<p>
Linearize the model for further analysis:
</p>
<pre>
hps_s.setLinearizationOptions(stopTime=0.1)
hps_s.getLinearizationOptions()
As,Bs,Cs,Ds = hps_s.linearize()  # get A, B, C, D matrices
hps_s.getLinearStates()
hps_s.getLinearInputs()
hps_s.getLinearOutputs()
</pre>

<p>
<strong>Note:</strong> Similar functionality is available with OMJulia API for Julia. See OMJulia documentation 
for details.
</p>
</html>"));
end OMPythonAPI;
