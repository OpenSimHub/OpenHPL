within OpenHPL.Waterway;
model Pipe "Model of a pipe"
  outer Data data "Using standard data set";
  extends OpenHPL.Icons.Pipe;
  extends OpenHPL.Interfaces.TwoContacts;

  // Geometrical parameters of the pipe:
  parameter SI.Length H = 25 "Height difference from the inlet to the outlet" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Length L = 6600 "Length of the pipe" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Diameter D_i = 5.8 "Diameter of the inlet side" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Diameter D_o = D_i "Diameter of the outlet side" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Height p_eps = data.p_eps "Pipe roughness height" annotation (
    Dialog(group = "Geometry"));
  parameter Real K_c = 0.1 "Loss coefficient for contraction"
    annotation (Dialog(group = "Geometry"));
  // Steady state:
  parameter Boolean SteadyState=data.SteadyState "If true, starts in steady state" annotation (Dialog(group="Initialization"));
  parameter SI.VolumeFlowRate Vdot_0=data.Vdot_0 "Initial flow rate of the pipe" annotation (Dialog(group="Initialization"));

  SI.Diameter D_ = 0.5 * (D_i + D_o) "Average diameter";
  SI.Mass m "Water mass";
  SI.Area A_i = D_i ^ 2 * C.pi / 4 "Inlet cross-sectional area";
  SI.Area A_o = D_o ^ 2 * C.pi / 4 "Outlet cross-sectional area";
  SI.Area A_ = D_ ^ 2 * C.pi / 4 "Average cross-sectional area";
  Real cos_theta = H / L "Slope ratio";
  SI.Velocity v "Water velocity";
  SI.Velocity v_o "Outlet water velocity";
  SI.Force F_f "Friction force";
  SI.Force F_taper "Tapering (local contraction) loss";
  SI.Momentum M "Water momentum";
  SI.Pressure p_i "Inlet pressure";
  SI.Pressure p_o "Outlet pressure";
  SI.Pressure dp=p_o-p_i "Pressure difference across the pipe";
  SI.MassFlowRate mdot "Mass flow rate";
  SI.VolumeFlowRate Vdot(start = Vdot_0) "Volume flow rate";

  /* TBD:
  // temperature variation. Not finished...
  parameter Boolean TempUse = data.TempUse "If checked - the water temperature is not constant" annotation (Dialog(group = "Initialization"));
  parameter SI.Temperature T_0 = data.T_0 "Initial water temperature in the pipe" annotation (Dialog(group = "Initialization", enable = TempUse));
  Real W_f, W_e;
  SI.Temperature T( start = T_0);
  */

protected
  parameter SI.Diameter D_eff=
    if abs(D_i - D_o)< C.eps then
      D_i
    else
      (D_i - D_o) / log(D_i/D_o) "Effective diameter for a linear taper";

initial equation
  if SteadyState then
    der(M) = 0;
  end if;
equation
  Vdot = mdot / data.rho "Volumetric flow rate through the pipe";
  v = Vdot / A_ "Average water velocity";
  v_o = Vdot / A_o "Outlet water velocity";
  M = data.rho * L * Vdot "Momentum of water";
  m = data.rho * A_ * L "Mass of water";
  F_f = Functions.DarcyFriction.Friction(v, D_eff, L, data.rho, data.mu, p_eps)
    "Friction force";
  F_taper = K_c * 0.5 * data.rho * A_o * v_o * abs(v_o)
    "Tapering (local contraction) loss";
  der(M) = data.rho * Vdot^2 * (1/A_i - 1/A_o)
           + p_i * A_i - p_o * A_o
           - F_f - F_taper
           + m * data.g * cos_theta
    "Momentum balance including tapering loss";
  // Connnections
  p_i = i.p "Inlet pressure"; 
  p_o = o.p "Outlet pressure";
  i.mdot+o.mdot = 0 "Mass balance";
  mdot = i.mdot "Inlet direction for mdot";

  /* TBD:
  // possible temperature variation implementation. Not finished...
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
    Documentation(info="<html><p>The simple model of the pipe gives possibilities
    for easy modelling of different conduit: intake race, penstock, tail race, etc.</p>
    <p>This model is described by the momentum differential equation, which depends
    on pressure drop through the pipe together with friction and gravity forces.
    The main defined variable is volumetric flow rate <code>Vdot</code>.</p>
    <p align=\"center\"><img src=\"modelica://OpenHPL/Resources/Images/pipe.svg\"> </p>
    <p>In this pipe model, the flow rate changes simultaneously in the whole pipe
    (an information about the speed of wave propagation is not included here).
    Water pressures can be shown just in the boundaries of pipe
    (inlet and outlet pressure from connectors).</p>
    <p>It should be noted that this pipe model provides possibilities for modelling
    of pipes with both a positive and a negative slopes (positive or negative height difference).</p>
    <p>If the pipe is slightly tapered then this can be taken into account by adjusting
    <code>K_c</code> based on your taper geometry: 0.05–0.15 for gentle cones,
      up to 0.6 for sharp contractions.</p>
    <p>More info about the pipe model can be found in
        <a href=\"modelica://OpenHPL.UsersGuide.References\">[Vytvytskyi2017]</a>
    and <a href=\"modelica://OpenHPL.UsersGuide.References\">[Splavska2017a]</a>.</p>
</html>"));
end Pipe;
