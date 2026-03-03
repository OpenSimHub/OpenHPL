within OpenHPLTest.EmpiricalTurbine.TestBasicFunctions;
model Test02_ControlPoints
  extends Modelica.Icons.Example;
  //
protected
  constant Integer NC = 5;
  constant Integer NP = 4;
  constant Integer ND = 3;
  parameter Real openingArray[NC] = {0.10, 0.25, 0.50, 0.75, 1.00};
  parameter Real controlPoints[NC, NP, ND] = {{{0.00, 0.18, 0.26}, {0.41, 0.10, 0.17}, {1.04, 0.31, 0.25}, {1.32, -0.04, -0.21}}, {{0.00, 0.44, 0.73}, {0.43, 0.37, 0.67}, {1.27, 0.55, 0.29}, {1.38, 0.00, -0.19}}, {{0.00, 0.91, 1.55}, {0.59, 0.89, 1.33}, {1.57, 0.79, 0.19}, {1.51, 0.00, -0.29}}, {{0.00, 1.30, 2.11}, {0.78, 1.33, 1.77}, {1.72, 0.92, -0.12}, {1.58, 0.00, -0.28}}, {{0.00, 1.57, 2.41}, {0.92, 1.63, 1.91}, {1.82, 1.02, -0.30}, {1.63, 0.00, -0.35}}};
  parameter OpenHPL.Types.TurbineCharacteristics tc(nCurves = NC, nPoints = NP, nDim = ND, opening = openingArray, data = controlPoints);
public
  Real cPoints1[NP, ND], cPoints2[NP, ND], cPoints3[NP, ND];
  Real[ND] curvePoint1;
  Real[ND]              curvePoint2;
  Real[ND]                           curvePoint3;
equation
  cPoints1 = OpenHPL.Functions.WeightedControlPoints(0.3, tc);
  curvePoint1 = OpenHPL.Functions.deCasteljau(time, ND, cPoints1);
  cPoints2 = OpenHPL.Functions.WeightedControlPoints(0.5, tc);
  curvePoint2 = OpenHPL.Functions.deCasteljau(time, ND, cPoints2);
  cPoints3 = OpenHPL.Functions.WeightedControlPoints(0.67, tc);
  curvePoint3 = OpenHPL.Functions.deCasteljau(time, ND, cPoints3);
  annotation (
    Documentation(info = "<html><head></head><body>Test basic functions for finding intermediate control points and evaluate Bezier curve.<div>Computes three curve trajectories as weighted intermediate curves. Parametrci curve plot of curvePoints1[1] against &nbsp;curvePoints1[2] and similar for curvePonts2 and curvePoints3 should show smooth curves 2D curves.</div></body></html>"),
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
end Test02_ControlPoints;
