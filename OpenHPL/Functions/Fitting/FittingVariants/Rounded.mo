within OpenHPL.Functions.Fitting.FittingVariants;
function Rounded "Calculation of phi for rounded reduction/expansion"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.ReynoldsNumber N_Re "Reynolds number";
  input Modelica.SIunits.Height eps "Pipe roughness height, only for exansion";
  input Modelica.SIunits.Diameter D_i, D_o "Pipe diameters";
  output Real phi "Dimension factor";
algorithm
  if D_o <= D_i then
    /* Rounded Reduction */
    phi := (0.1 + 50/N_Re)*((D_i/D_o)^4 - 1);
  else
    /* Rounded Expansion (same as Square Expansion) */
    phi := Square(N_Re,eps,D_i,D_o);
  end if;
  annotation (Documentation(info="<html>
<p>Define dimension factor &phi; for Rounded Reduction. Rounded Expansion is the same as Squared Expansion.</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/roundedredexp.png\"/> </p>
</html>"));
end Rounded;
