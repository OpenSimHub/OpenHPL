within OpenHPL.Functions.Fitting.DifferentFitting;
function SquareExpansion
  input Modelica.SIunits.ReynoldsNumber N_Re "Reynold number";
  input Modelica.SIunits.Height eps "Pipe roughness height";
  input Modelica.SIunits.Diameter D_1, D_2;
  //Pipe diameters
  output Real phi;
protected
  Real f_D "friction factor";
algorithm
  f_D := Functions.DarcyFriction.fDarcy(N_Re, D_1, eps);
  if N_Re < 4000 then
    phi := 2 * (1 - (D_1 / D_2) ^ 4);
  else
    phi := (1 + 0.8 * f_D) * (1 - (D_1 / D_2) ^ 2) ^ 2;
  end if;
  annotation (
    Documentation(info = "<html>
<p>Define dimension factor &phi; for Square Expansion</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/squareredexp.png\"/></p>
</html>"));
end SquareExpansion;
