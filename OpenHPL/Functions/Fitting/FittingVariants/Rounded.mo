within OpenHPL.Functions.Fitting.FittingVariants;
function Rounded "Calculation of phi for rounded reduction/expansion"
  extends Modelica.Icons.Function;
  input SI.ReynoldsNumber N_Re "Reynolds number";
  input SI.Height p_eps "Pipe roughness height, only for exansion";
  input SI.Diameter D_i, D_o "Pipe diameters";
  output Real phi "Dimension factor";
algorithm
  if D_o <= D_i then
    /* Rounded Reduction */
    phi := (0.1 + 50/N_Re)*((D_i/D_o)^4 - 1);
  else
    /* Rounded Expansion (same as Square Expansion) */
    phi := Square(N_Re,p_eps,D_i,D_o);
  end if;
  annotation (preferredView="info", Documentation(info="<html>
<p>Define dimension factor &phi; for Rounded Reduction. Rounded Expansion is the same as Squared Expansion.</p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\" width=\"50%\">
<tr>
<td><p><em>Rounded Reduction:</em></p></td>
<td><p><em>Rounded Expansion:</em></p></td>
</tr>
<tr>
<td><img src=\"modelica://OpenHPL/Resources/Images/RoundedReduction.svg\"/></td>
<td><img src=\"modelica://OpenHPL/Resources/Images/RoundedExpansion.svg\"/></td>
</tr>
</table>
</html>"));
end Rounded;
