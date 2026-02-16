within OpenHPL.Functions.Fitting.FittingVariants;
function SharpOrifice "Calculation of phi for a Sharp Orifice"
  extends Modelica.Icons.Function;
  input SI.ReynoldsNumber N_Re "Reynolds number";
  input SI.Height p_eps "Pipe roughness height";
  input SI.Diameter D_i, D_o "Pipe diameters";
  output Real phi;
protected
  Real phi_0;
algorithm
  phi_0 := (1 - (D_o / D_i) ^ 2) * ((D_i / D_o) ^ 4 - 1);
  if N_Re < 2500 then
    phi := (2.72 + (D_o / D_i) ^ 2 * (120 / (N_Re + Modelica.Constants.eps) - 1)) * phi_0;
  else
    phi := (2.72 + (D_o / D_i) ^ 2 * 4000 / (N_Re + Modelica.Constants.eps)) * phi_0;
  end if;
  annotation (preferredView="info",
    Documentation(info="<html>
    <p>Calculates the dimension factor &phi; for Sharp Orifice.</p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\" width=\"50%\">
<tr>
<td><p><em>Sharp Orifice:</em></p></td>
</tr>
<tr>
<td><img src=\"modelica://OpenHPL/Resources/Images/OrificeSharp.svg\"/></td>
</tr>
</table>
</html>"));
end SharpOrifice;
