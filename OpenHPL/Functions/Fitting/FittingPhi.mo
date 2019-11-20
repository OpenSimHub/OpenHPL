within OpenHPL.Functions.Fitting;
function FittingPhi "Calculates the dimension factor phi based in the fitting type"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.Velocity v "Flow velocity";
  input Modelica.SIunits.Diameter D_i "Pipe diameter of inlet (LHS)";
  input Modelica.SIunits.Diameter D_o "Pipe diameter of outlet (RHS)";
  input Modelica.SIunits.Length L "Fitting length";
  input Modelica.SIunits.Conversions.NonSIunits.Angle_deg theta = 90 "Angle of the tapered reduction/expansion";
  input Modelica.SIunits.Density rho "Density";
  input Modelica.SIunits.DynamicViscosity mu "Dynamic viscosity of water";
  input Modelica.SIunits.Height eps "Pipe roughness height";
  input Fitting.FittingType fit_type "Type of pipe fitting";
  output Real phi;
protected
  Modelica.SIunits.ReynoldsNumber N_Re;
algorithm
  N_Re := rho * abs(v) * D_i / mu;
  if fit_type == FittingType.Square then
    phi := DifferentFitting.Square(N_Re, eps, D_i, D_o);
  elseif fit_type == FittingType.Tapered then
    phi := DifferentFitting.Tapered(N_Re, eps, D_i, D_o, theta);
  elseif fit_type == FittingType.Rounded then
    phi := DifferentFitting.Rounded(N_Re, eps, D_i, D_o);
  elseif fit_type == FittingType.SharpOrifice then
    phi := DifferentFitting.SharpOrifice(N_Re, eps, D_i, D_o);
  elseif fit_type == FittingType.ThickOrifice then
    phi := DifferentFitting.ThickOrifice(N_Re, eps, D_i, D_o, L);
  end if;
  annotation (
    Documentation(info = "<html>
<p>Define dimension factor &phi; for different types of fittings.</p>
</html>"));
end FittingPhi;
