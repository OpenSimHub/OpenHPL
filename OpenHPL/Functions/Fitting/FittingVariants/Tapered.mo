within OpenHPL.Functions.Fitting.FittingVariants;
function Tapered "Calculation of phi for Tapered reduction/expansion"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.ReynoldsNumber N_Re "Reynolds number";
  input Modelica.SIunits.Height eps "Pipe roughness height";
  input Modelica.SIunits.Diameter D_i, D_o "Pipe diameters";
  input Modelica.SIunits.Conversions.NonSIunits.Angle_deg theta "Angle of taper";
  output Real phi "Dimension factor";
protected
  Real f_D "Friction factor";
algorithm
  if D_o <= D_i then
    /* Tapered Reduction */
    if theta < 22.5 then
      phi := 1.6*sin(Modelica.SIunits.Conversions.from_deg(theta)/4)
             *Square(N_Re,eps,D_i,D_o);
    else
      phi := sqrt(sin(Modelica.SIunits.Conversions.from_deg(theta)/4))
             *Square(N_Re,eps,D_i,D_o);
    end if;
  else
    /* Tapered Expansion */
    if theta < 22.5 then
      phi := 2.6*sin(Modelica.SIunits.Conversions.from_deg(theta)/4)
             *Square(N_Re,eps,D_i,D_o);
    else
      phi :=  Square(N_Re,eps,D_i,D_o);
    end if;
  end if;
  annotation (
    Documentation(info="<html>
<p>Calulates the dimension factor &phi; for Tapered reduction/expansion.
 The tapered angle &theta; should be specified.</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/taperedredexp.png\"/></p>
</html>"));
end Tapered;
