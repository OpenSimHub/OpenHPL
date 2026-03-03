within OpenHPL.Types;
record TurbineCharacteristics
 extends Modelica.Icons.Record;
  parameter Integer nCurves;
  parameter Integer nPoints;
  parameter Integer nDim "parameter space, currently 3";
  parameter Real opening[nCurves];
  parameter Real data[nCurves, nPoints, nDim];

  annotation(
    Documentation(info="<html>
<p>This data record is based on the first version of the empirical turbine model, where normalized data for nED, QED and TED are given for
a number of normalized openings.</p>
<p>The HillChart record contains <strong>three</strong> integer values:</p>
<ol>
<li><font color=\"#0000ff\">nCurves</font> - number of Bezier curves</li>
<li><font color=\"#0000ff\">nPoints</font> - number of Bezier control points (order of curve +1)</li>
<li><font color=\"#0000ff\">nDim</font> - parameter space (currently assumed to be 3. (Model may/will (?) fail for other values).</li>
</ol>
<p>The data itself is contained in <strong>two</strong> multidimensional arrays:</p>
<ul>
<li><font color=\"#0000ff\">opening[nCurves]</font> - gives the opening \\(\\in [0,1]\\) for each curve. It is assumed that the array is sorted from smallest to larges value.</li>
<li><font color=\"#0000ff\">data[nCurves, nPoints, nDim]</font> - gives the Bezier control points for each curve and each parameter (nED,QED,TED).</li>
</ul>
</html>"));

end TurbineCharacteristics;
