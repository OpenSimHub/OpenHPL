within OpenHPL.Waterway.Drafttube;
model Elbow "Model of the cone of a draft tube"
  outer Data data "Using standard data set";
  extends OpenHPL.Icons.Elbow;
  import Modelica.Constants.pi;
  //// geometrical parameters of the pipe
  parameter Modelica.SIunits.Length H_d = 5 "Height difference from the inlet to the outlet" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg delta = 75 "Bend angle of the elbow" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Length L = 6 "Length of the elbow" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter D_i = 4 "Diameter of the inlet side" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter D_o= 4.5
                                              "Diameter of the outlet side" annotation (
    Dialog(group = "Geometry"));
     parameter Modelica.SIunits.Length R_o= 7 "Radius of curvature through the center of the elbow" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Height p_eps = data.p_eps "Pipe roughness height" annotation (
    Dialog(group = "Geometry"));
  //// condition of steady state
  parameter Boolean SteadyState = data.Steady "if true - starts from Steady State" annotation (
    Dialog(group = "Initialization"));
  //// staedy state value for flow rate
  parameter Modelica.SIunits.VolumeFlowRate Vdot_0 = data.V_0 "Initial flow rate in the cone" annotation (
    Dialog(group = "Initialization"));
  //// possible parameters for temperature variation. Not finished...
  //parameter Boolean TempUse = data.TempUse "If checked - the water temperature is not constant" annotation (Dialog(group = "Initialization"));
  //parameter Modelica.SIunits.Temperature T_0 = data.T_0 "Initial water temperature in the pipe" annotation (Dialog(group = "Initialization", enable = TempUse));

  // variables
  Modelica.SIunits.Momentum M "Water momentum";
  Modelica.SIunits.Mass m "water mass";
  Modelica.SIunits.Velocity v "Water velocity";
  Modelica.SIunits.Volume V "Volume of water";
  Modelica.SIunits.Diameter D_e,D_  "Diameters";
  Modelica.SIunits.Length L_CM,EI,EM,IM  "Lengths";
  Modelica.SIunits.Area A_,A_i,A_o,A_e "Areas";
  Modelica.SIunits.Force F,F_p,Fg_Vdot,F_f,F_D,F_d "Forces";
  Modelica.SIunits.Pressure p_i,p_o,p_e "Pressure";
  Real phi_dk,zeta_d,zeta_k,kappa  "Non-dimensional values";

  Modelica.SIunits.VolumeFlowRate Vdot(start = Vdot_0) "Flow rate";

  //// variables for temperature. Not in use for now...
  //Real W_f, W_e;
  //Modelica.SIunits.Temperature T( start = T_0);

  // connector
  extends OpenHPL.Interfaces.ContactPort;

initial equation
  if SteadyState == true then
    der(M) = 0;
  end if;
equation
  der(M) = F;

  // Equations as in the paper (link later)
  // Relating M with algebraic variables and Vdot
  M = m*v;
  m = data.rho*V; V = pi*L/12*(D_i^2+D_e^2+D_i*D_e); D_e=D_o;
  v = Vdot/A_; A_= pi*D_^2/4;mdot=data.rho*Vdot;
  if D_i<D_e then
      L_CM = L/16*(3*D_i^2+2*D_i*D_e+D_e^2)/(D_i^2+D_i*D_e+D_e^2);
      D_ = D_e-(D_e-D_i)*L_CM/L;
    else
      L_CM =L/16*(D_i^2+2*D_i*D_e+3*D_e^2)/(D_i^2+D_i*D_e+D_e^2);
      D_ = D_i-(D_i-D_e)*L_CM/L;
  end if;

  // Relating F with algebraic variables and p_i and p_e
  F = F_p-Fg_Vdot-F_f;
  F_p = p_i*A_i-p_e*A_e; A_i = pi*D_i^2/4; A_e = pi*D_e^2/4; p_e=p_o;A_o=A_e;
  Fg_Vdot = m*data.g*H_d/EI;
  EI = (IM^2+EM^2+2*IM*EM*cos(Modelica.SIunits.Conversions.from_deg(delta)))^2;IM = L_CM; EM = L-L_CM;
  F_f = F_D + F_d;
  F_D = Functions.DarcyFriction.Friction(v, D_, L, data.rho, data.mu, p_eps);
  F_d = 1/2*data.rho*v*abs(v)*A_*phi_dk;
  phi_dk = zeta_d*zeta_k;
  zeta_d = 1.1e-7*delta^3 + 8.46e-5*delta^2 + 0.018*delta-0.02;
  zeta_k = 2.24*kappa^4 + 11.2*kappa^3 + 21.26*kappa^2 - 18.35*kappa+6.24;
  kappa = R_o/D_;
  // link with the pressure connector
  p_i = i.p;
  p_o = o.p;
  annotation (
    Documentation(info= "<html><p>The simple model of the pipe gives possibilities
    for easy modelling of different conduit: intake race, penstock, tail race, etc.</p>
    <p>This model is described by the momentum differential equation, which depends
    on pressure drop through the pipe together with friction and gravity forces.
    The main defined variable is volumetric flow rate <i>Vdot</i>.</p>
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
end Elbow;
