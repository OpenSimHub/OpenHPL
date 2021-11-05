within OpenHPL.Functions.DarcyFriction;
function Friction "Friction force with Darcy friction factor"
  extends Modelica.Icons.Function;
  import Modelica.Constants.pi;
  input SI.Velocity v "Flow velocity";
  input SI.Diameter D "Pipe diameter";
  input SI.Length L "Pipe length";
  input SI.Density rho "Density";
  input SI.DynamicViscosity mu "Dynamic viscosity of water";
  input SI.Height p_eps "Pipe roughness height";
  // Function output (response) value
  output SI.Force F_f "Friction force";
  // Local (protected) quantities
protected
  SI.ReynoldsNumber N_Re "Reynolds number";
  Real f "friction factor";
algorithm
  N_Re := rho * abs(v) * D / mu;
  f := fDarcy(N_Re, D, p_eps);
  F_f := 0.5 * pi * f * rho * L * v * abs(v) * D / 4;
  annotation (
    Documentation(info = "<html>
<p>Function for defining the friction forces using the Darcy friction factor.</p>
</html>"));
end Friction;
