within OpenHPL.Functions.DarcyFriction;
function Friction "Friction force with Darcy friction factor"
  extends Modelica.Icons.Function;
  import Modelica.Constants.pi;
  input Modelica.SIunits.Velocity v "Flow velocity";
  input Modelica.SIunits.Diameter D "Pipe diameter";
  input Modelica.SIunits.Length L "Pipe length";
  input Modelica.SIunits.Density rho "Density";
  input Modelica.SIunits.DynamicViscosity mu "Dynamic viscosity of water";
  input Modelica.SIunits.Height eps "Pipe roughness height";
  // Function output (response) value
  output Modelica.SIunits.Force F_f "Friction force";
  // Local (protected) quantities
protected
  Modelica.SIunits.ReynoldsNumber N_Re "Reynolds number";
  Real f "friction factor";
algorithm
  N_Re := rho * abs(v) * D / mu;
  f := fDarcy(N_Re, D, eps);
  F_f := 0.5 * pi * f * rho * L * v * abs(v) * D / 4;
  annotation (
    Documentation(info = "<html>
<p>Function for defining the friction forces using the Darcy friction factor.</p>
</html>"));
end Friction;
