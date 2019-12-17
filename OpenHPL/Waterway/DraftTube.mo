within OpenHPL.Waterway;
model DraftTube "Model of a draft tube for reaction turbines"
  outer Data data "Using standard data set";
  extends OpenHPL.Icons.DraftTube;
  import Modelica.Constants.pi;
  // geometrical parameters of the draft tube
  parameter Modelica.SIunits.Length H = 10 "Vertical height of draft tube" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Length L = 10.15 "Slant height of draft tube" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter D_i = 5 "Diameter of the inlet side" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter D_o = 13.52 "Diameter of the outlet side" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Height p_eps = data.p_eps "Pipe roughness height" annotation (
    Dialog(group = "Geometry"));
  // condition of steady state
  parameter Boolean SteadyState = data.Steady "if true - starts from Steady State" annotation (
    Dialog(group = "Initialization"));
  // staedy state value for flow rate
  parameter Modelica.SIunits.VolumeFlowRate Vdot_0 = data.V_0 "Initial flow rate in the pipe" annotation (
    Dialog(group = "Initialization"));
  // possible parameters for temperature variation. Not finished...
  // parameter Boolean TempUse = data.TempUse "If checked - the water temperature is not constant" annotation (Dialog(group = "Initialization"));
  // parameter Modelica.SIunits.Temperature T_0 = data.T_0 "Initial water temperature in the pipe" annotation (Dialog(group = "Initialization", enable = TempUse));
  // variables
  Modelica.SIunits.Diameter D_ = 0.5 * (D_i + D_o) "Average diameter";
  Modelica.SIunits.Mass m "Mass of water inside draft tube";
  Modelica.SIunits.Volume V "Volume of water inside draft tube";
  Modelica.SIunits.Momentum M "Momentum of water inside the draft tube";
  Modelica.SIunits.Force Mdot "Rate of change of water momentum";
  Modelica.SIunits.Force F "Total force acting in the tube";
  Modelica.SIunits.Force F_p "Pressure force";
  Modelica.SIunits.Force F_f "Fluid frictional force";
  Modelica.SIunits.Force F_g "Weight of water";
  Modelica.SIunits.Area A_i = D_i ^ 2 * pi / 4 "Inlet cross section area";
  Modelica.SIunits.Area A_o = D_o ^ 2 * pi / 4 "Outlet cross section area";
  Modelica.SIunits.Area A_ = D_ ^ 2 * pi / 4 "Average cross section area";
  //Real cos_theta = H / L "slope ratio";
  Modelica.SIunits.Velocity v "Water velocity";
  Modelica.SIunits.Pressure p_i "Inlet pressure";
  Modelica.SIunits.Pressure p_o "Outlet pressure";
  Modelica.SIunits.Pressure dp = p_o-p_i "Pressure drop in and out of draft tube";
  Modelica.SIunits.VolumeFlowRate Vdot(start = Vdot_0, fixed = true) "Volumeteric flow rate";

 // connectors
  extends OpenHPL.Interfaces.ContactPort;
initial equation
  if SteadyState == true then
    der(M) = 0;
    //der(n.T) = 0;
  else
    Vdot = Vdot_0;
    //n.T = p.T;
  end if;
equation
  m = data.rho*V "Mass of water inside the draft tube";
  V = 1/3*pi*H/4*(D_i^2+D_o^2+D_i*D_o) "Volume of water inside the draft tube";
  mdot = data.rho*Vdot;
  der(M) = Mdot + F;
  M = m*v;
  v = Vdot/A_;
  Mdot = mdot*v;
  F = F_p-F_g-F_f;
  F_p = p_i * A_i - p_o * A_o;
  F_f = Functions.DarcyFriction.Friction(v, D_, L, data.rho, data.mu, p_eps);
  F_g = m*data.g;
  // connector
  p_i = i.p;
  p_o = o.p;
  annotation (
    Documentation(info="<html><p>This is the simple model of the conical diffuser draft tube</p>
    <p>This model is described by the momentum differential equation, which depends
    on pressure drop through the pipe together with friction and gravity forces.
    The main defined variable is volumetric flow rate <i>Vdot</i>.</p>
    <p align=\"center\"><img src=\"modelica://OpenHPL/Resources/Images/pipe.png\"> </p>
    <p>In this pipe model, the flow rate changes simultaniusly in the whole pipe
    (an information about the speed of wave propagation is not included here).
    Water pressures can be shown just in the boundaries of pipe
    (inlet and outlet pressure from connectors).&nbsp;</p>
</html>"));
end DraftTube;
