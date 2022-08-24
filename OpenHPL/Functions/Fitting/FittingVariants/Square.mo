within OpenHPL.Functions.Fitting.FittingVariants;
function Square "Calculation of phi for Square reduction/expansion"
  extends Modelica.Icons.Function;
  input SI.ReynoldsNumber N_Re "Reynolds number";
  input SI.Height p_eps "Pipe roughness height";
  input SI.Diameter D_i, D_o "Pipe diameters";
  output Real phi "Dimension factor";
protected
  Real f_D "Friction factor";
algorithm
  f_D := Functions.DarcyFriction.fDarcy(N_Re, D_i, p_eps);
  if D_o <= D_i then
    /* Square Reduction */
    if N_Re < 2500 then
      phi := (1.2 + 160/N_Re)*((D_i/D_o)^4 - 1);
    else
      phi := (0.6 + 0.48*f_D)*(D_i/D_o)^2*((D_i/D_o)^2 - 1);
    end if;
  else
    /* Square Expansion */
    if N_Re < 4000 then
      phi := 2*(1 - (D_i/D_o)^4);
    else
      phi := (1 + 0.8*f_D)*(1 - (D_i/D_o)^2)^2;
    end if;
  end if;
  annotation (Documentation(info="<html>
<p>Calculates the dimension factor <strong>&phi;</strong> for square reduction/expansion.</p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\" width=\"50%\"><tr>
<td><p><em>Squared Reduction:</em></p></td>
<td><p><em>Squared Expansion:</em></p></td>
</tr>
<tr>
<td><img src=\"modelica://OpenHPL/Resources/Images/SquaredReduction.svg\"/></td>
<td><img src=\"modelica://OpenHPL/Resources/Images/SquaredExpansion.svg\"/></td>
</tr>
</table>
</html>"));
end Square;
