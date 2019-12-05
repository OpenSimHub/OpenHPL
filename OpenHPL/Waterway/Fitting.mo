within OpenHPL.Waterway;
model Fitting "Different pipes fitting"
  outer Data data "Using standard class with constants";
  extends OpenHPL.Icons.Fitting;
  import Modelica.Constants.pi;
  /* conditions for different fitting type */
  parameter Types.Fitting fit_type=OpenHPL.Types.Fitting.Square "Type of pipe fitting";
  /* geometrical parameters for fitting */
  parameter Modelica.SIunits.Diameter D_i = 5.8 "Pipe diameter of the inlet (LHS)" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter D_o = 3.3 "Pipe diameter of the outlet (RHS)" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg theta = 45 "If Tapered fitting: angle of the tapered reduction/expansion"
  annotation (Dialog(group = "Geometry", enable=fit_type == OpenHPL.Types.Fitting.Tapered));
  parameter Modelica.SIunits.Length L(max = 5 * D_o) = 1 "If Thick Orifice: length of the thick orifice, condition L/D_2<=5. If this condition is not satisfied (L is longer) then use Square Reduction followed by Square Expansion" annotation (
    Dialog(group = "Geometry", enable=fit_type == OpenHPL.Types.Fitting.ThickOrifice));
  /* variables */
  Modelica.SIunits.Velocity v "Water velocity";
  Modelica.SIunits.Area A = pi * D_i^2 / 4 "Cross section area";
  Modelica.SIunits.Pressure dp "Pressure drop of fitting";
  Real phi "Dimensionless factor based on the type of fitting ";
  /* Connector */
  extends OpenHPL.Interfaces.ContactPort;
equation
  v = mdot / data.rho / A;
  phi =Functions.Fitting.FittingPhi(
    v,
    D_i,
    D_o,
    L,
    theta,
    data.rho,
    data.mu,
    data.p_eps,
    fit_type);
  dp = phi * 0.5 * data.rho * abs(v) * v;
  o.p = i.p - dp "Pressure of the output connector";
  annotation (
    Documentation(info="<html>
    <p>Various possibilities of the fittings for the pipes with different diameters 
    and also the orifices in the pipe. 
    Here, the pressure drop due to these constrictions is defined.</p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\" width=\"50%\"><tr>
<td><p><em>Squared Reduction:</em></p></td>
<td><p><em>Squared Expansion:</em></p></td>
</tr>
<tr>
<td><img src=\"modelica://OpenHPL/Resources/Images/SquaredReduction.svg\"/></td>
<td><img src=\"modelica://OpenHPL/Resources/Images/SquaredExpansion.svg\"/></td>
</tr>
<tr>
<td><p><em>Tapered Reduction:</em></p></td>
<td><p><em>Tapered Expansion:</em></p></td>
</tr>
<tr>
<td><img src=\"modelica://OpenHPL/Resources/Images/TaperedReduction.svg\"/></td>
<td><img src=\"modelica://OpenHPL/Resources/Images/TaperedExpansion.svg\"/></td>
</tr>
<tr>
<td><p><em>Rounded Reduction:</em></p></td>
<td><p><em>Rounded Expansion:</em></p></td>
</tr>
<tr>
<td><img src=\"modelica://OpenHPL/Resources/Images/RoundedReduction.svg\"/></td>
<td><img src=\"modelica://OpenHPL/Resources/Images/RoundedExpansion.svg\"/></td>
</tr>
<tr>
<td><p><em>Sharp Orifice:</em></p></td>
<td><p><em>Thick Orifice:</em></p></td>
</tr>
<tr>
<td><img src=\"modelica://OpenHPL/Resources/Images/OrificeSharp.svg\"/></td>
<td><img src=\"modelica://OpenHPL/Resources/Images/OrificeThick.svg\"/></td>
</tr>
</table>
</html>"));
end Fitting;
