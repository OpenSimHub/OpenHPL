within OpenHPL.Types;

record HillChart
 extends Modelica.Icons.Record;
  parameter Integer nCurves;
  parameter Integer nPoints;
  parameter Integer nDim "parameter space, currently 3";
  parameter Real opening[nCurves];
  parameter Real data[nCurves, nPoints, nDim];
  
  annotation(
    Documentation(info = "<html><head></head><body><div>This data record is based on the first version of the empirical turbine model, where normalized data for nED, QED and TED are given for</div><div>a number of normalized openings.&nbsp;</div><div><br></div>The HillChart record contains <b>three</b> integer values:<div>1) <font color=\"#0000ff\">nCurves</font> - number of Bezier curves</div><div>2) <font color=\"#0000ff\">nPoints</font> - number of Bezier control points (order of curve +1)</div><div>3) <font color=\"#0000ff\">nDim</font> - parameter space (currently assumed to be 3. (Model may/will (?) fail for other values).</div><div><br></div><div>The data itself is contained in <b>two</b> multidimensional arrays</div><div><font color=\"#0000ff\">opening[nCurves]</font> - gives the opening $$\in [0,1]$$ for each curve. It is assumed that the array is sorted from smallest to larges value.</div><div><font color=\"#0000ff\">data[nCurves, nPoints, nDim] </font>- gives the Bezier control points for each curve and each parameter (nED,QED,TED)&nbsp;</div></body></html>"));

end HillChart;
