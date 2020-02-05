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
<p>Usually minor head losses in pipes are cosidered to be due to fittings, diffusers, nozzles, bend in pipes, etc. We are more interested in head loss due to bend pipes for this model.</p>
<p>A typical loss coefficient values for flanged and threaded elbows, tees, gates, valves, etc., can be taken as,</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/MinorLoss.png\"/></p>
<p>Note: This is page excerpt taken from<i> Fluid Mechanics</i> by Frank M. White from page 422, edition-6th. </p>
</html>"));
end BendPipe;
