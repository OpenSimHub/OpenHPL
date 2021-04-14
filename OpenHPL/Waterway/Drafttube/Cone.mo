within OpenHPL.Waterway.Drafttube;
model Cone "Model of the cone of a draft tube"
  outer Data data "Using standard data set";
  extends OpenHPL.Icons.Cone;
  import Modelica.Constants.pi;
  //// geometrical parameters of the pipe
  parameter Modelica.SIunits.Length H_d = 5 "Height difference from the inlet to the outlet" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Length H = 5 "Height of the cone" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter D_i = 4 "Diameter of the inlet side" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter D_o= 4.5
                                              "Diameter of the outlet side, D_o=D_i+2*H*tan(delta/2) D_i+2*H*tan(from_deg(delta/2))" annotation (
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
  Modelica.SIunits.Length L  "Length";
  Real delta  "Diffusion angle";
  Modelica.SIunits.Area A_,A_i,A_o,A_e "Areas";
  Modelica.SIunits.Force F,F_p,Fg_Vdot,F_f,F_D,F_d "Forces";
  Modelica.SIunits.Pressure p_i,p_o,p_e "Pressure";
  Real phi_d,p1_delta,p2_delta  "Non-dimensional values";

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
  m = data.rho*V; V = pi*H/12*(D_i^2+D_e^2+D_i*D_e); D_e=D_o;
  v = Vdot/A_; A_= pi*D_^2/4;Vdot = mdot / data.rho;
  D_ = D_e -(D_e-D_i)/16*(3*D_i^2+2*D_i*D_e+D_e^2)/(D_i^2+D_i*D_e+D_e^2);

  // Relating F with algebraic variables and p_i and p_e (replace p_e with p_o)
  F = F_p-Fg_Vdot-F_f;
  F_p = p_i*A_i-p_e*A_e; A_i = pi*D_i^2/4; A_e = pi*D_e^2/4; p_e=p_o;A_o=A_e;
  Fg_Vdot = m*data.g*H_d/H;
  F_f = F_D + F_d;
  F_D = Functions.DarcyFriction.Friction(v, D_, L, data.rho, data.mu, p_eps);
  L = H/cos(Modelica.SIunits.Conversions.from_deg(delta/2));
  delta = Modelica.SIunits.Conversions.to_deg(2*atan(D_e-D_i)/2/H);
  F_d = 1/2*data.rho*v*abs(v)*A_*phi_d;
  if (delta>=2 and delta<=11) then
      phi_d = p1_delta*(1-(D_i/D_e)^2)^2;
    else
      phi_d = p2_delta*(1-(D_i/D_e)^2)^2;
  end if;
  p1_delta = 0.014*delta^2 - 0.213*delta + 1.105;
  p2_delta = 1.1e-16*delta^8 + 1.05e-13*delta^7 + 4.21e-11*delta^6+9.13e-9*delta^5 + 1.16e-6*delta^4 + 8.90e-5*delta^3+4.14e-3*delta^2 + 0.12*delta - 0.46;


  // link with the pressure connector
  p_i = i.p;
  p_o = o.p;
  annotation (
    Documentation(info="<html>
<p>This is model of a cone used in a drafttube of a hydro power system. </p>
<p>The model is based on DAEs obtained from the momentum balance through the center of mass of the fluid inside the cone.</p>
<p align=\"center\"><br><img src=\"modelica://OpenHPL/Resources/Images/coneForDoc.svg\"/></p>
</html>", revisions="<html>
</html>"));
end Cone;
