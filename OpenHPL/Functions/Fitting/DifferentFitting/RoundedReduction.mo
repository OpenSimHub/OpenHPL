within OpenHPL.Functions.Fitting.DifferentFitting;
function RoundedReduction
  input Modelica.SIunits.ReynoldsNumber N_Re "Reynold number";
  input Modelica.SIunits.Diameter D_1, D_2;
  //Pipe diameters
  output Real phi;
algorithm
  phi := (0.1 + 50 / N_Re) * ((D_1 / D_2) ^ 4 - 1);
  annotation (
    Documentation(info = "<html>
<p>Define dimension factor &phi; for Rounded Reduction. Rounded Expansion is the same as Squared Expansion.</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/roundedredexp.png\"/> </p>
</html>"));
end RoundedReduction;
