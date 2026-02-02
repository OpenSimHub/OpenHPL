within OpenHPL.Waterway;
model Pipe "Model of a pipe"
  outer Data data "Using standard data set";
  extends OpenHPL.Icons.Pipe;
  extends OpenHPL.Interfaces.TwoContacts;

  // Geometrical parameters of the pipe:
  parameter SI.Length H = 0 "Height difference from the inlet to the outlet" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Length L = 1000 "Length of the pipe" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Diameter D_i = 1.0 "Diameter of the inlet side" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Diameter D_o = D_i "Diameter of the outlet side" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Height p_eps = data.p_eps "Pipe roughness height" annotation (
    Dialog(group = "Geometry"));

  // Steady state:
  parameter Boolean SteadyState=data.SteadyState "If true, starts in steady state" annotation (Dialog(group="Initialization"));
  parameter SI.VolumeFlowRate Vdot_0=data.Vdot_0 "Initial flow rate of the pipe" annotation (Dialog(group="Initialization"));

  
  SI.Velocity v "Average Water velocity";
  SI.Force F_f "Friction force";
  SI.Pressure p_i "Inlet pressure";
  SI.Pressure p_o "Outlet pressure";
  //SI.Pressure dp=p_o-p_i "Pressure difference across the pipe";
  SI.MassFlowRate mdot "Mass flow rate";
  SI.VolumeFlowRate Vdot "Volume flow rate";
 
  protected
    parameter SI.Diameter D_ = ( D_i + D_o )/2 "Average diameter";
    parameter SI.Area A_i = D_i ^ 2 * C.pi / 4 "Inlet cross-sectional area";
    parameter SI.Area A_o = D_o ^ 2 * C.pi / 4 "Outlet cross-sectional area";
    parameter SI.Area A_ =  D_  ^ 2 * C.pi / 4 "Average cross-sectional area";
    parameter Real delta=2*(D_i-D_o)/(D_i+D_o) "Contraction factor";
    parameter Real cf=1+2*delta^2 "Conical pipe function";
    parameter Real cos_theta = H / L "Slope ratio";
    parameter Real phi = Modelica.Units.Conversions.to_deg(Modelica.Math.atan((abs(D_i-D_o)/(2*L)))) "Cone half angle";

initial equation
  if SteadyState then
    der(mdot) = 0;
  end if;
  algorithm
    assert( phi < 1.0 , "Change in pipe diameter is too large. (angle= "+String(phi)+" )",AssertionLevel.warning);
equation
  
  Vdot = mdot / data.rho "Volumetric flow rate through the pipe";
  v = Vdot / A_ "Average water velocity";
  F_f = Functions.DarcyFriction.Friction(v, D_, L, data.rho, data.mu, p_eps)*cf "Friction force";
  L * der(mdot)=(p_i+ data.rho *data.g * H)*A_i-p_o*A_o -F_f;
  p_i = i.p "Inlet pressure";
  p_o = o.p "Outlet pressure";
  i.mdot+o.mdot = 0 "Mass balance";
  mdot = i.mdot "Inlet direction for mdot";

  annotation (
    Documentation(info= "<html><head></head><body><p>The simple model of the pipe gives possibilities
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
    and <a href=\"modelica://OpenHPL.UsersGuide.References\">[Splavska2017a]</a>.</p><p>Updated formulation for non-equal inlet- and outlet diameter.</p><p><br></p><p><br></p>
</body></html>"));
end Pipe;
