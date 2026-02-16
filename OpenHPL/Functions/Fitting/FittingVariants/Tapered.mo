within OpenHPL.Functions.Fitting.FittingVariants;
function Tapered "Calculation of phi for Tapered reduction/expansion"
  extends Modelica.Icons.Function;
  input SI.ReynoldsNumber N_Re "Reynolds number";
  input SI.Height p_eps "Pipe roughness height";
  input SI.Diameter D_i, D_o "Pipe diameters";
  input Modelica.Units.NonSI.Angle_deg theta "Angle of taper";
  output Real phi "Dimension factor";
protected
  Real f_D "Friction factor";
algorithm
  if D_o <= D_i then
    /* Tapered Reduction */
    if theta < 22.5 then
      phi :=1.6*sin(Modelica.Units.Conversions.from_deg(theta)/4)*Square(
        N_Re,
        p_eps,
        D_i,
        D_o);
    else
      phi :=sqrt(sin(Modelica.Units.Conversions.from_deg(theta)/4))*Square(
        N_Re,
        p_eps,
        D_i,
        D_o);
    end if;
  else
    /* Tapered Expansion */
    if theta < 22.5 then
      phi :=2.6*sin(Modelica.Units.Conversions.from_deg(theta)/4)*Square(
        N_Re,
        p_eps,
        D_i,
        D_o);
    else
      phi := Square(N_Re,p_eps,D_i,D_o);
    end if;
  end if;
  annotation (preferredView="info",
    Documentation(info="<html>
<p>Calculates the dimension factor &phi; for Tapered reduction/expansion.
 The tapered angle &theta; should be specified.</p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\" width=\"50%\">
<tr>
<td><p><em>Tapered Reduction:</em></p></td>
<td><p><em>Tapered Expansion:</em></p></td>
</tr>
<tr>
<td><img src=\"modelica://OpenHPL/Resources/Images/TaperedReduction.svg\"/></td>
<td><img src=\"modelica://OpenHPL/Resources/Images/TaperedExpansion.svg\"/></td>
</tr>
</table>
</html>"));
end Tapered;
