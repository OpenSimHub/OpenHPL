within OpenHPL.Functions;

function deCasteljau
 extends Modelica.Icons.Function;
  input Real t "Parameter between 0 and 1";
  input Integer ndim "Dimensional space";
  input Real[:, ndim] controlPoints "Array of control points [n,ndim]";
  output Real[ndim] point "Computed point on the curve";
protected
  Integer n = size(controlPoints, 1);
  Real temp[n, ndim];
algorithm
// Initialize temp with control points
  temp := controlPoints;
// Perform De Casteljau iterations
  for r in 1:n - 1 loop
    for i in 1:n - r loop
      for k in 1:ndim loop
        temp[i, k] := (1 - t)*temp[i, k] + t*temp[i + 1, k];
      end for;
    end for;
  end for;
// The first element now contains the point on the curve
for k in 1:ndim loop
  point[k] := temp[1, k];
end for;
annotation(
    Documentation(info = "<html><head></head><body>Implementation of Bezier curve evaluation using the deCasteljau algorithm.<div>At the moment only one single Bezier curve per parameter dimension is assumed, but the order of the curve is arbritray, but define by the number of control points (e.g. curve order = number of control points - 1).</div></body></html>"));


end deCasteljau;
