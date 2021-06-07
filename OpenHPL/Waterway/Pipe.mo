within OpenHPL.Waterway;
model Pipe "Model of the pipe"
  outer Data data "Using standard data set";
  extends OpenHPL.Icons.Pipe;
  import Modelica.Constants.pi;
  //// geometrical parameters of the pipe
  parameter Modelica.SIunits.Length H = 25 "Height difference from the inlet to the outlet" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Length L = 6600 "Length of the pipe" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter D_i = 5.8 "Diameter of the inlet side" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter D_o = D_i "Diameter of the outlet side" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Height p_eps = data.p_eps "Pipe roughness height" annotation (
    Dialog(group = "Geometry"));
  //// condition of steady state
  parameter Boolean SteadyState = data.Steady "if true - starts from Steady State" annotation (
    Dialog(group = "Initialization"));
  //// staedy state value for flow rate
  parameter Modelica.SIunits.VolumeFlowRate Vdot_0 = data.V_0 "Initial flow rate in the pipe" annotation (
    Dialog(group = "Initialization"));
  //// possible parameters for temperature variation. Not finished...
  //parameter Boolean TempUse = data.TempUse "If checked - the water temperature is not constant" annotation (Dialog(group = "Initialization"));
  //parameter Modelica.SIunits.Temperature T_0 = data.T_0 "Initial water temperature in the pipe" annotation (Dialog(group = "Initialization", enable = TempUse));
  //// variables
  Modelica.SIunits.Diameter D_ = 0.5 * (D_i + D_o) "Average diameter";
  Modelica.SIunits.Mass m "water mass";
  Modelica.SIunits.Area A_i = D_i ^ 2 * pi / 4 "Inlet cross section area";
  Modelica.SIunits.Area A_o = D_o ^ 2 * pi / 4 "Outlet cross section area";
  Modelica.SIunits.Area A_ = D_ ^ 2 * pi / 4 "Average cross section area";
  Real cos_theta = H / L "slope ratio";
  Modelica.SIunits.Velocity v "Water velocity";
  Modelica.SIunits.Force F_f "Friction force";
  Modelica.SIunits.Momentum M "Water momentum";
  Modelica.SIunits.Pressure p_i "Inlet pressure";
  Modelica.SIunits.Pressure p_o "Outlet pressure";
  Modelica.SIunits.Pressure dp=p_o-p_i "Pressure difference across the pipe";
  Modelica.SIunits.VolumeFlowRate Vdot(start = Vdot_0) "Flow rate";

  //// variables for temperature. Not in use for now...
  //Real W_f, W_e;
  //Modelica.SIunits.Temperature T( start = T_0);
  //// connectors
  extends OpenHPL.Interfaces.ContactPort;
initial equation
  if SteadyState == true then
    der(M) = 0;
  end if;
equation
  //// Water volumetric flow rate through the pipe
  Vdot = mdot / data.rho;
  //// Water velocity
  v = Vdot / A_;
  //// Momentum and mass of water
  M = data.rho * L * Vdot;
  m = data.rho * A_ * L;
  //// Friction force
  F_f = Functions.DarcyFriction.Friction(v, D_, L, data.rho, data.mu, p_eps);
  //// momentum balance
  der(M) = data.rho * Vdot ^ 2 * (1 / A_i - 1 / A_o) + p_i * A_i - p_o * A_o - F_f + m * data.g * cos_theta;
  //// pipe presurre
  p_i = i.p;
  p_o = o.p;
  //// possible temperature variation implementation. Not finished...
  //W_f = -F_f * v;
  //W_e = Vdot * (p_i- p_o);
  //if TempUse == true then
  //data.c_p * m * der(T) = Vdot * data.rho * data.c_p * (p.T - T) + W_e - W_f;
  //0 = Vdot * data.rho * data.c_p * (p.T - n.T) + W_e - W_f;
  //else
  //der(n.T) = 0;
  //end if;
  //n.T = T;
  ////
  annotation (
    Documentation(info= "<html><p>The simple model of the pipe gives possibilities
    for easy modelling of different conduit: intake race, penstock, tail race, etc.</p>
    <p>This model is described by the momentum differential equation, which depends
    on pressure drop through the pipe together with friction and gravity forces.
    The main defined variable is volumetric flow rate <em>Vdot</em>.</p>
    <p align=\"center\"><img src=\"modelica://OpenHPL/Resources/Images/pipe.svg\"> </p>
    <p>In this pipe model, the flow rate changes simultaniusly in the whole pipe
    (an information about the speed of wave propagation is not included here).
    Water pressures can be shown just in the boundaries of pipe
    (inlet and outlet pressure from connectors).&nbsp;</p>
    <p>It should be noted that this pipe model provides possibilities for modelling
    of pipes with both a positive and a negative slopes (positive or negative height diference).</p>
    <p>More info about the pipe model can be found in 
	<a href=\"modelica://OpenHPL.UsersGuide.References\">[Vytvytskyi2017]</a>
    and <a href=\"modelica://OpenHPL.UsersGuide.References\">[Splavska2017]</a>.</p>
</html>"));
end Pipe;
