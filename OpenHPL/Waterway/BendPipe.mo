within OpenHPL.Waterway;
model BendPipe "Bend in pipes"
  outer Data data "Using standard class with constants";
  extends OpenHPL.Icons.BendPipe;
  import Modelica.Constants.pi;
  /* conditions for different fitting type */
  parameter Real K_L = 0.5 "Loss coefficient for pipe bends (Guess or from manufacturer's design)" annotation (
    Dialog(group = "Manufacturer's design"));
  /* geometrical parameters for fitting */
  parameter Modelica.SIunits.Diameter D_i = 3 "Pipe diameter of the inlet (LHS)" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter D_o = D_i "Pipe diameter of the outlet (RHS)" annotation (
    Dialog(group = "Geometry"));
  Modelica.SIunits.Velocity v(start=Modelica.Constants.eps) "Water velocity";
  Modelica.SIunits.Area A = pi*D_i^2/4 "Cross section area";
  Modelica.SIunits.Pressure dp "Pressure drop of fitting";
  /* Connector */
  extends OpenHPL.Interfaces.ContactPort;
equation
  v = mdot / data.rho / A;
  dp = K_L * 0.5 * data.rho * v^2;
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
end BendPipe;
