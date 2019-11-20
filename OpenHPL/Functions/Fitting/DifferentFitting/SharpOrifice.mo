within OpenHPL.Functions.Fitting.DifferentFitting;
function SharpOrifice "Calculation of phi for a Sharp Orifice"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.ReynoldsNumber N_Re "Reynolds number";
  input Modelica.SIunits.Height eps "Pipe roughness height";
  input Modelica.SIunits.Diameter D_i, D_o "Pipe diameters";
  output Real phi;
protected
  Real phi_0;
algorithm
  phi_0 := (1 - (D_o / D_i) ^ 2) * ((D_i / D_o) ^ 4 - 1);
  if N_Re < 2500 then
    phi := (2.72 + (D_o / D_i) ^ 2 * (120 / N_Re - 1)) * phi_0;
  else
    phi := (2.72 + (D_o / D_i) ^ 2 * 4000 / N_Re) * phi_0;
  end if;
  annotation (
    Documentation(info = "<html>
    <p>Calculates the dimension factor &phi; for Sharp Orifice.</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/orifices.png\"/></p>
</html>"));
end SharpOrifice;
