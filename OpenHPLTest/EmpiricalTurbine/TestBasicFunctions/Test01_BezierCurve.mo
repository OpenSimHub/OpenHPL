within OpenHPLTest.EmpiricalTurbine.TestBasicFunctions;
model Test01_BezierCurve
  extends Modelica.Icons.Example;
  Real[ndim] curvePoint;
protected
  constant Integer ndim = 3;
  parameter Real controlPoints[6, ndim] = {{0.00, 1.46, 2.60}, {0.53, 1.45, 2.33}, {0.77, 1.19, 1.80}, {1.63, 0.86, -0.58}, {1.13, 0.24, 0.31}, {1.43, -0.17, -0.52}};
equation
  curvePoint = OpenHPL.Functions.deCasteljau(time, ndim, controlPoints);
  annotation (
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.001),
    Documentation(info = "<html><head></head><body>Basic test of evaluation of Bezier curve using deCasteljau algorithm.<div>Parametric curve plot of curvePoint[1] againts curvPoint[2] should show a smooth trajectory of QED vs nED.<br><div><br></div><div><br></div></div></body></html>"));
end Test01_BezierCurve;
