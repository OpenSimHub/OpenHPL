within OpenHPL.Waterway;
model Pipe "Model of the pipe"
  outer Data data "Using standard data set";
  extends OpenHPL.Icons.Pipe;
  extends OpenHPL.Interfaces.ContactPort;

  //// geometrical parameters of the pipe
  parameter SI.Length H = 25 "Height difference from the inlet to the outlet" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Length L = 6600 "Length of the pipe" annotation (
    Dialog(group = "Geometry"));
  final parameter Real cos_theta = H/L "Slope ratio";
  parameter SI.Diameter D_i = 5.8 "Diameter of the inlet side" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Diameter D_o = D_i "Diameter of the outlet side" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Height p_eps = data.p_eps "Pipe roughness height" annotation (
    Dialog(group = "Geometry"));
  //// condition of steady state
  parameter Boolean SteadyState = data.Steady "if true - starts from Steady State" annotation (
    Dialog(group = "Initialization"));
  //// steady state value for flow rate
  parameter SI.VolumeFlowRate Vdot_0 = data.V_0 "Initial flow rate in the pipe" annotation (
    Dialog(group = "Initialization"));
  //// possible parameters for temperature variation. Not finished...
  //parameter Boolean TempUse = data.TempUse "If checked - the water temperature is not constant" annotation (Dialog(group = "Initialization"));
  //parameter SI.Temperature T_0 = data.T_0 "Initial water temperature in the pipe" annotation (Dialog(group = "Initialization", enable = TempUse));
  //// variables
  SI.Diameter D_av = 0.5 * (D_i + D_o) "Average diameter";
  SI.Mass m "water mass";
  SI.Area A_i = D_i ^ 2 * C.pi / 4 "Cross-sectional area of inlet";
  SI.Area A_o = D_o ^ 2 * C.pi / 4 "Cross-sectional area of outlet";
  SI.Area A_av = D_av ^ 2 * C.pi / 4 "Average cross-sectional area";

  SI.Velocity v "Water velocity";
  SI.Force F_f "Friction force";
  SI.Momentum M "Water momentum";
  SI.Pressure dp=o.p-i.p "Pressure difference across the pipe";
  SI.VolumeFlowRate Vdot(start = Vdot_0) "Flow rate";

  /* variables for temperature. Not in use for now...
  //Real W_f, W_e;
  //SI.Temperature T( start = T_0);
  */

initial equation
  if SteadyState then
    der(M) = 0;
  end if;
equation
  Vdot = mdot / data.rho "Water volumetric flow rate through the pipe";
  v = Vdot / A_av "Water velocity";
  M = data.rho * L * Vdot "Momentum and mass of water";
  m = data.rho * A_av * L "Mass of water";
  F_f = Functions.DarcyFriction.Friction(v, D_av, L, data.rho, data.mu, p_eps) "Friction force";
  der(M) = data.rho * Vdot ^ 2 * (1 / A_i - 1 / A_o) + i.p * A_i - o.p * A_o - F_f + m * data.g * cos_theta
    "Momentum balance";
  /* possible temperature variation implementation. Not finished...
  W_f = -F_f * v;
  W_e = Vdot * (p_i- p_o);
  if TempUse then
    data.c_p * m * der(T) = Vdot * data.rho * data.c_p * (p.T - T) + W_e - W_f;
    0 = Vdot * data.rho * data.c_p * (p.T - n.T) + W_e - W_f;
  else
    der(n.T) = 0;
  end if;
  n.T = T;
  */
  annotation (
    Documentation(info= "<html><p>The simple model of the pipe gives possibilities
    for easy modelling of different conduit: intake race, penstock, tail race, etc.</p>
    <p>This model is described by the momentum differential equation, which depends
    on pressure drop through the pipe together with friction and gravity forces.
    The main defined variable is volumetric flow rate <em>Vdot</em>.</p>
    <p align=\"center\"><img src=\"modelica://OpenHPL/Resources/Images/pipe.svg\"> </p>
    <p>In this pipe model, the flow rate changes simultaneously in the whole pipe
    (an information about the speed of wave propagation is not included here).
    Water pressures can be shown just in the boundaries of pipe
    (inlet and outlet pressure from connectors).&nbsp;</p>
    <p>It should be noted that this pipe model provides possibilities for modelling
    of pipes with both a positive and a negative slopes (positive or negative height difference).</p>
    <p>More info about the pipe model can be found in 
        <a href=\"modelica://OpenHPL.UsersGuide.References\">[Vytvytskyi2017]</a>
    and <a href=\"modelica://OpenHPL.UsersGuide.References\">[Splavska2017]</a>.</p>
</html>"));
end Pipe;
