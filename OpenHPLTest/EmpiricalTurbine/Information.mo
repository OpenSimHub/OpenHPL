within OpenHPLTest.EmpiricalTurbine;
class Information
  extends Modelica.Icons.Information;
  annotation (
    DocumentationClass=true,
    Documentation(
      info="<html>
<p>The EmpiricalTurbine test package contains a series of test models for documenting and validating the implementation of the EmpiricalTurbine model.</p>
<p>There are two sub-packages:</p>
<ul>
<li>TestBasicFunctions - testing of the Bezier spline algorithm, the search algorithm and the blending function (to find intermediate curves)</li>
<li>TurbineTests - collection of gradually more complex test cases using the EmpiricalTurbine model</li>
</ul>
<p>At the moment there are some robustness issues with the model. In the default configuration Test03_Turbine have issues with convergence at time t=0.34 with the message </p>
<p><span style=\"font-family: monospace;\">Homotopy solver Newton iteration: Maximum number of iterations reached at time 0.340000, but no root found.</span></p>
<p>The following documents testing and investigations to resolve this.</p>
<p>In particular it is important to understand some of the following topics </p>
<ul>
<li><a href=\"https://openmodelica.org/doc/OpenModelicaUsersGuide/latest/solving.html\">Solving Modelica Models</a></li>
<li><a href=\"https://en.wikipedia.org/wiki/Homotopy_analysis_method\">Homotopy analysis method</a></li>
<li><a href=\"https://en.wikipedia.org/wiki/Stiff_equation\">Stiff equation</a></li>
</ul>
<p>and how different implementations may impact the robustness of the models.</p><p>Some observations:</p>
<ul>
<li>Turbine model with only upstream and downstream reservoir and constant opening works fine (Test02).</li>
<li>Turbine model with upstream and downstream reservoir and ramping opening works fine (Test04).</li>
<li>Turbine model with rigid water pipe and constant opening works shows clear convergence issues (Test03).</li>
</ul>
<p><br>Additional comments:</p><p><br>In general convergence issues can either be related to &quot;stiff&quot; problems or singularities or discontinuous functions (or gradients). Running Test03 with the DASSL solver, with startTime=0 and stopTime=1 and varying time step gives the following result.</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"1\"><tr>
<td><p align=\"center\"><h4>Time step</h4></p></td>
<td><p align=\"center\"><h4>Comments</h4></p></td>
</tr>
<tr>
<td><p>0.005</p></td>
<td><p>Convergence issues from t=0.26500 (nonlinear system 82)</p></td>
</tr>
<tr>
<td><p>0.01</p></td>
<td><p>Convergence issues from t=0.34000</p></td>
</tr>
<tr>
<td><p>0.02</p></td>
<td><p>Convergence issues from t=0.34000</p></td>
</tr>
<tr>
<td><p>0.05</p></td>
<td><p>Convergence issues from t=0.683162</p></td>
</tr>
<tr>
<td><p>0.10</p></td>
<td><p>Convergence issues from t=0.683162</p></td>
</tr>
<tr>
<td><p>0.20</p></td>
<td><p>Convergence issues from t=0.683162</p></td>
</tr>
</table>
<p><br><br>Normally, for stiff problems, reducing the time step should improve the convergence. This seems not to be the case here.</p>
</html>"));
end Information;
