within OpenHPL.Functions.Fitting.DifferentFitting;
function ThickOrifice
  extends Modelica.Icons.Function;
  input Modelica.SIunits.ReynoldsNumber N_Re "Reynold number";
  input Modelica.SIunits.Height eps "Pipe roughness height";
  input Modelica.SIunits.Diameter D_1, D_2;
  //Pipe diameters
  input Modelica.SIunits.Length L;
  output Real phi;
protected
  Real phi_0;
algorithm
  phi_0 := (1 - (D_2 / D_1) ^ 2) * ((D_1 / D_2) ^ 4 - 1);
  if L / D_2 <= 5 then
    phi := (0.584 + 0.0936 / ((L / D_2) ^ 1.5 + 0.225)) * phi_0;
  end if;
  annotation (
    Documentation(info = "<html>
<p>Define dimension factor &phi; for Thick Orifice.  Orifice length should be provided, and this length should not be greater than 5D<sub>2.</sub></p>
<p><img src=\"modelica://OpenHPL/Resources/Images/orifices.png\"/></p>
</html>"));
end ThickOrifice;
