within OpenHPL.Functions.Fitting;
function FittingPhi
  input Modelica.SIunits.Velocity v "Flow velocity";
  input Modelica.SIunits.Diameter D_1 "Pipe diameter from left hand side";
  input Modelica.SIunits.Diameter D_2 "Pipe diameter from right hand side";
  input Modelica.SIunits.Length L "Fitting length";
  input Modelica.SIunits.Conversions.NonSIunits.Angle_deg theta = 90 "Angle of teh tapered reduction/expansion";
  input Modelica.SIunits.Density rho "Density";
  input Modelica.SIunits.DynamicViscosity mu "Dynamic viscosity of water";
  input Modelica.SIunits.Height eps "Pipe roughness height";
  input Fitting.FittingType fit_type "Type of pipe fitting";
  output Real phi;
protected
  Modelica.SIunits.ReynoldsNumber N_Re;
algorithm
  N_Re := rho * abs(v) * D_1 / mu;
  if fit_type == Fitting.FittingType.SquareReduction then
    phi := DifferentFitting.SquareReduction(N_Re, eps, D_1, D_2);
  elseif fit_type == Fitting.FittingType.SquareExpansion then
    phi := DifferentFitting.SquareExpansion(N_Re, eps, D_1, D_2);
  elseif fit_type == Fitting.FittingType.TaperedReduction then
    phi := DifferentFitting.TaperedReduction(N_Re, eps, D_1, D_2, theta);
  elseif fit_type == Fitting.FittingType.TaperedExpansion then
    phi := DifferentFitting.TaperedExpansion(N_Re, eps, D_1, D_2, theta);
  elseif fit_type == Fitting.FittingType.RoundReduction then
    phi := DifferentFitting.RoundedReduction(N_Re, D_1, D_2);
  elseif fit_type == Fitting.FittingType.RoundExpansion then
    phi := DifferentFitting.SquareExpansion(N_Re, eps, D_1, D_2);
  elseif fit_type == Fitting.FittingType.SharpOrifice then
    phi := DifferentFitting.SharpOrifice(N_Re, eps, D_1, D_2);
  elseif fit_type == Fitting.FittingType.ThickOrifice then
    phi := DifferentFitting.ThickOrifice(N_Re, eps, D_1, D_2, L);
  end if;
  annotation (
    Documentation(info = "<html>
<p>Define dimension factor &phi; for different types of fittings.</p>
</html>"));
end FittingPhi;
