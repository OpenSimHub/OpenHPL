within OpenHPL.Functions.Fitting.FittingVariants;
function ThickOrifice
  extends Modelica.Icons.Function;
  input SI.ReynoldsNumber N_Re "Reynolds number";
  input SI.Height p_eps "Pipe roughness height";
  input SI.Diameter D_i, D_o "Pipe diameters";
  input SI.Length L;
  output Real phi;
protected
  Real phi_0;
algorithm
  phi_0 := (1 - (D_o / D_i) ^ 2) * ((D_i / D_o) ^ 4 - 1);
  if L / D_o <= 5 then
    phi := (0.584 + 0.0936 / ((L / D_o) ^ 1.5 + 0.225)) * phi_0;
  end if;
  annotation (preferredView="info",
    Documentation(info="<html>
    <p>Define dimension factor &phi; for Thick Orifice.
    Orifice length should be provided and this length should not be greater than 5D<sub>o</sub>.</p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\" width=\"50%\">
<tr>
<td><p><em>Thick Orifice:</em></p></td>
</tr>
<tr>
<td><img src=\"modelica://OpenHPL/Resources/Images/OrificeThick.svg\"/></td>
</tr>
</table>
</html>"));
end ThickOrifice;
