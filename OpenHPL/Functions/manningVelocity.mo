within OpenHPL.Functions;
function manningVelocity "Compute velocity from Manning's equation"
  extends Modelica.Icons.Function;
  input SI.Height h "Water depth";
  input Real S "Slope (bed slope + water surface gradient)";
  input SI.Length w "Channel width";
  input Real n "Manning's roughness coefficient";
  output SI.Velocity v "Flow velocity";
protected
  SI.Length R_h "Hydraulic radius";
algorithm
  R_h := w * h / (w + 2 * h);
  v := sign(S) * R_h ^ (2.0 / 3) * abs(S) ^ 0.5 / n;
end manningVelocity;
