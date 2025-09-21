within OpenHPL.Waterway;
model Pipe "Model of a pipe"
  outer Data data "Using standard data set";
  extends OpenHPL.Icons.Pipe;
  extends OpenHPL.Interfaces.TwoContacts;

  // Geometrical parameters of the pipe:
  parameter SI.Length H = 10 "Height difference from the inlet to the outlet" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Length L = 1000 "Length of the pipe" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Diameter D_i = 1.0 "Diameter of the inlet side" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Diameter D_o = D_i "Diameter of the outlet side" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Height p_eps = data.p_eps "Pipe roughness height" annotation (
    Dialog(group = "Geometry"));
  //parameter Real K_c = 0.1 "Loss coefficient for contraction"
  //  annotation (Dialog(group = "Geometry"));
  // Steady state:
  parameter Boolean SteadyState=data.SteadyState "If true, starts in steady state" annotation (Dialog(group="Initialization"));
  parameter SI.VolumeFlowRate Vdot_0=data.Vdot_0 "Initial flow rate of the pipe" annotation (Dialog(group="Initialization"));

  
  SI.Velocity v "Average Water velocity";
  SI.Force F_f "Friction force";
  // SI.Force F_taper "Tape friction force";
  SI.Momentum M "Water momentum";
  SI.Pressure p_i "Inlet pressure";
  SI.Pressure p_o "Outlet pressure";
  //SI.Pressure dp=p_o-p_i "Pressure difference across the pipe";
  SI.MassFlowRate mdot "Mass flow rate";
  SI.VolumeFlowRate Vdot(start = Vdot_0) "Volume flow rate";
  protected
    SI.Velocity v_o;
    parameter Real delta=(D_i-D_o)/D_i "Contraction factor";
    // parameter Real ddd=;
    parameter SI.Diameter D_ = sqrt((4/C.pi)*A_) "Average diameter";
    parameter SI.Mass m = data.rho * A_ * L      "Mass of water"; 
    parameter SI.Area A_i = D_i ^ 2 * C.pi / 4 "Inlet cross-sectional area";
    parameter SI.Area A_o = D_o ^ 2 * C.pi / 4 "Outlet cross-sectional area";
    parameter SI.Area A_ =  0.5 * (A_i + A_o) "Average cross-sectional area";
  
    parameter Real cos_theta = H / L "Slope ratio";
    
  


initial equation
  if SteadyState then
    der(mdot) = 0;
  /*else
    Testing with no initialization for this case, to avoid conflicts with multiple branches. Should in princple be ok.
    mdot=Vdot_0*data.rho;
    */
  end if;
  assert((D_i-D_o)/L > 0.1, "Change in pipe diameter too large",AssertionLevel.warning);
equation
  
  Vdot = mdot / data.rho "Volumetric flow rate through the pipe";
  v = Vdot / A_ "Average water velocity";
  v_o = Vdot / A_o "Outlet water velocity";
  M = data.rho * L * Vdot "Momentum of water";
 
  F_f = Functions.DarcyFriction.Friction(v, D_, L, data.rho, data.mu, p_eps)*((0.5*delta+1)/(delta^2+2*delta+1)) "Friction force";
 
  der(M) = data.rho * Vdot^2 * (1/A_i - 1/A_o)
           + p_i * A_i - p_o * A_o
           - F_f 
           + m * data.g * cos_theta   "Momentum balance including friction loss";
    
  p_i = i.p "Inlet pressure";
  p_o = o.p "Outlet pressure";
  i.mdot+o.mdot = 0 "Mass balance";
  mdot = i.mdot "Inlet direction for mdot";

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
