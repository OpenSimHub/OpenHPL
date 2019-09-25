within OpenHPL.Waterway;
model Fitting "Different pipes fitting"
  outer Constants Const "Using standard class with constants";
  extends OpenHPL.Icons.Fitting;
  import Modelica.Constants.pi;
  //// geometrical parameters for fitting
  parameter Modelica.SIunits.Diameter D_1 = 5.8 "Pipe diameter from left hand side" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter D_2 = 3.3 "Pipe diameter from right hand side" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg theta = 45 "Angle of the tapered reduction/expansion" annotation (
    Dialog(group = "Geometry", enable = TaperedReduction or TaperedExpansion));
  parameter Modelica.SIunits.Length L(max = 5 * D_2) = 1 "Length of the thick orifice, condition L/D_2<=5. If condition is not stitisfied (L is longer) then use Square Reduction followed by Square Expansion" annotation (
    Dialog(group = "Geometry", enable = ThickOrifice));
  //// conditions for different fitting type
  parameter Functions.Fitting.FittingType fit_type = Functions.Fitting.FittingType.SquareReduction "Type of pipe fitting" annotation (
    Dialog(group = "Type of fitting"));
  //// variables
  Modelica.SIunits.Velocity v "Water velocity";
  Modelica.SIunits.Area A = pi * D_1 / 4 "Cross section area";
  Modelica.SIunits.Pressure dp "Pressure drop of fitting";
  Real phi "Dimensionless factor";
  //// Conector
  extends OpenHPL.Interfaces.ContactPort;
equation
  //// Define velocity
  v = m_dot / Const.rho / A;
  //// Define dimensionless factor base on type of the fitting
  phi = Functions.Fitting.FittingPhi(v, D_1, D_2, L, theta, Const.rho, Const.mu, Const.eps, fit_type);
  //// Define pressure drop
  dp = phi * 0.5 * Const.rho * abs(v) * v;
  //// output pressure conector
  n.p = p.p - dp;
  annotation (
    Documentation(info = "<html>
<p>Various possibilities of the fittings for the pipes with different diameters and also the orifices in the pipe. Here, the pressure drop due to these constrictions is defined.</p>
<p>Should choose only one of constrictions/fitting types. Here is presented the view of all of them:</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/squareredexp.png\"/></p>
<p><img src=\"modelica://OpenHPL/Resources/Images/taperedredexp.png\"/></p>
<p><img src=\"modelica://OpenHPL/Resources/Images/roundedredexp.png\"/></p>
<p><img src=\"modelica://OpenHPL/Resources/Images/orifices.png\"/></p>
</html>"));
end Fitting;
