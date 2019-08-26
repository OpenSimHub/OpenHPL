within OpenHPL.Functions.Fitting.DifferentFitting;
function SquareReduction
  input Modelica.SIunits.ReynoldsNumber N_Re "Reynold number";
  input Modelica.SIunits.Height eps "Pipe roughness height";
  input Modelica.SIunits.Diameter D_1, D_2;
  //Pipe diameters
  output Real phi;
protected
  Real f_D "friction factor";
algorithm
  f_D := Functions.DarcyFriction.fDarcy(N_Re, D_1, eps);
  if N_Re < 2500 then
    phi := (1.2 + 160 / N_Re) * ((D_1 / D_2) ^ 4 - 1);
  else
    phi := (0.6 + 0.48 * f_D) * (D_1 / D_2) ^ 2 * ((D_1 / D_2) ^ 2 - 1);
  end if;
  annotation (
    Documentation(info = "<html>
<p>Define dimension factor &phi; for square reduction.</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/squareredexp.png\"/></p>
</html>"));
end SquareReduction;
