within OpenHPL.Waterway;
model BendPipe "Bend in pipes"
  outer Data data "Using standard class with constants";
  extends OpenHPL.Icons.BendPipe;
  extends OpenHPL.Interfaces.ContactPort;

  parameter Real K_L = 0.5 "Loss coefficient for pipe bends (Guess or from manufacturer's design)" annotation (
    Dialog(group = "Manufacturer's design"));
  parameter SI.Diameter D_i = 3 "Pipe diameter of the inlet (LHS)" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Diameter D_o = D_i "Pipe diameter of the outlet (RHS)" annotation (
    Dialog(group = "Geometry"));
  SI.Velocity v(start=Modelica.Constants.eps) "Water velocity";
  SI.Area A = C.pi*D_i^2/4 "Cross-sectional area";
  SI.Pressure dp "Pressure difference across the pipe";

equation
  v = mdot / data.rho / A;
  dp = K_L * 0.5 * data.rho * v^2;
  o.p = i.p - dp "Pressure of the output connector";
  annotation (
    Documentation(info="<html>
<p>Usually minor head losses in pipes are considered to be due to fittings, diffusers, nozzles, bend in pipes, etc. We are more interested in head loss due to bend pipes for this model.</p>
<p>A typical loss coefficient value for flanged and threaded elbows, tees, gates, valves, etc., can be taken as,</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://OpenHPL/Resources/Images/MinorLoss.png\"
           alt=\"MinorLoss.png\">
    </td>
  </tr>
  <caption align=\"bottom\">Note: This is page excerpt is taken from 
  <a href=\"modelica://OpenHPL.UsersGuide.References\">[White2009]</a>, page 422.</caption>
</table> 

</html>"));
end BendPipe;
