within OpenHPL.Functions.DarcyFriction;
function fDarcy "Darcy friction factor"
  extends Modelica.Icons.Function;
  input SI.ReynoldsNumber N_Re "Reynolds number";
  input SI.Diameter D "Pipe diameter";
  input SI.Height p_eps "Pipe roughness height";
  // Function output (response) value
  output Real fD "Darcy friction factor";
  // Local (protected) quantities
protected
  Real arg;
  // Algorithm for computing specific enthalpy
  SI.ReynoldsNumber N_Re_lam = 2100, N_Re_tur = 2300;
  Real X[4, 4], Y[4], K[4];
algorithm
  X := [N_Re_lam ^ 3, N_Re_lam ^ 2, N_Re_lam, 1; N_Re_tur ^ 3, N_Re_tur ^ 2, N_Re_tur, 1; 3 * N_Re_lam ^ 2, 2 * N_Re_lam, 1, 0; 3 * N_Re_tur ^ 2, 2 * N_Re_tur, 1, 0];
  Y := {64 / N_Re_lam, 1 / (2 * log10(p_eps / 3.7 / D + 5.74 / N_Re_tur ^ 0.9)) ^ 2, -64 / N_Re_lam ^ 2, -0.25 * 0.316 / N_Re_tur ^ 1.25};
  K := Modelica.Math.Matrices.inv(X) * Y;
  arg := p_eps / 3.7 / D + 5.74 / (N_Re + Modelica.Constants.eps) ^ 0.9;
  if N_Re <= 0 then
    fD := 0;
  elseif N_Re <= 2100 then
    fD := 64 / N_Re;
  elseif N_Re < 2300 then
    fD := K[1] * N_Re ^ 3 + K[2] * N_Re ^ 2 + K[3] * N_Re + K[4];
  else
    fD := 1 / (2 * log10(arg)) ^ 2;
  end if;
  annotation (
    Documentation(info="<html>
<p>Function for defining the Darcy friction factor using the <code>Reynolds&nbsp;number</code>. Has different equations for laminar (Reynolds number &LT; 2100) and turbulent (Reynolds number &GT; 2300) flows and also for transitional zone (2100 &LT; Reynolds number &LT; 2300).</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/darcyf.svg\"/></p>
</html>"));
end fDarcy;
