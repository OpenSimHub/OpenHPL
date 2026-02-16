within OpenHPL.Functions.Fitting;
function FittingPhi "Calculates the dimension factor phi based in the fitting type"
  extends Modelica.Icons.Function;
  input SI.Velocity v "Flow velocity";
  input SI.Diameter D_i "Pipe diameter of inlet (LHS)";
  input SI.Diameter D_o "Pipe diameter of outlet (RHS)";
  input SI.Length L "Fitting length";
  input Modelica.Units.NonSI.Angle_deg theta=90 "Angle of the tapered reduction/expansion";
  input SI.Density rho "Density";
  input SI.DynamicViscosity mu "Dynamic viscosity of water";
  input SI.Height p_eps "Pipe roughness height";
  input Types.Fitting fit_type "Type of pipe fitting";
  output Real phi;
protected
  SI.ReynoldsNumber N_Re;
algorithm
  N_Re := rho * abs(v) * D_i / mu;
  if fit_type == Types.Fitting.Square then
    phi :=FittingVariants.Square(
      N_Re,
      p_eps,
      D_i,
      D_o);
  elseif fit_type == Types.Fitting.Tapered then
    phi :=FittingVariants.Tapered(
      N_Re,
      p_eps,
      D_i,
      D_o,
      theta);
  elseif fit_type == Types.Fitting.Rounded then
    phi :=FittingVariants.Rounded(
      N_Re,
      p_eps,
      D_i,
      D_o);
  elseif fit_type == Types.Fitting.SharpOrifice then
    phi :=FittingVariants.SharpOrifice(
      N_Re,
      p_eps,
      D_i,
      D_o);
  elseif fit_type == Types.Fitting.ThickOrifice then
    phi :=FittingVariants.ThickOrifice(
      N_Re,
      p_eps,
      D_i,
      D_o,
      L);
  end if;
  annotation (preferredView="info",
    Documentation(info = "<html>
<p>Define dimension factor &phi; for different types of fittings.</p>
</html>"));
end FittingPhi;
