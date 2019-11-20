within OpenHPL.Functions.Fitting.DifferentFitting;
function Square "Calculation of phi for Square reduction/expansion"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.ReynoldsNumber N_Re "Reynolds number";
  input Modelica.SIunits.Height eps "Pipe roughness height";
  input Modelica.SIunits.Diameter D_i, D_o "Pipe diameters";
  output Real phi "Dimension factor";
protected
  Real f_D "Friction factor";
algorithm
  f_D := Functions.DarcyFriction.fDarcy(N_Re, D_i, eps);
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
<p>Caluclates the dimension factor <strong>&phi;</strong> for square reduction/expansion.</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/squareredexp.png\"/></p>
</html>"));
end Square;
