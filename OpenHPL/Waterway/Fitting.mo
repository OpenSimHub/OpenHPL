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
  v = m_dot / para.rho / A;
  phi =Functions.Fitting.FittingPhi(
    v,
    D_i,
    D_o,
    L,
    theta,
    para.rho,
    para.mu,
    para.eps,
    fit_type);
  dp = phi * 0.5 * para.rho * abs(v) * v;
  o.p = i.p - dp "Pressure of the output connector";
  annotation (
    Documentation(info = "<html>
    <p>Various possibilities of the fittings for the pipes with different diameters 
    and also the orifices in the pipe. 
    Here, the pressure drop due to these constrictions is defined.</p>
    <p>Should choose only one of constrictions/fitting types. Here is presented the view of all of them:</p>
    <p><img src=\"modelica://OpenHPL/Resources/Images/squareredexp.png\"/></p>
    <p><img src=\"modelica://OpenHPL/Resources/Images/taperedredexp.png\"/></p>
    <p><img src=\"modelica://OpenHPL/Resources/Images/roundedredexp.png\"/></p>
    <p><img src=\"modelica://OpenHPL/Resources/Images/orifices.png\"/></p>
</html>"));
end Fitting;
