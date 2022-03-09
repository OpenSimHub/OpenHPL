within OpenHPL.Waterway;
model DraftTube "Model of a draft tube for reaction turbines"
  outer Data data "Using standard data set";
  extends OpenHPL.Icons.DraftTube;
  import Modelica.Constants.pi;
  parameter Types.DraftTube DraftTubeType = OpenHPL.Types.DraftTube.ConicalDiffuser "Types of draft tube" annotation (
    Dialog(group = "Draft tube types"));

  // geometrical parameters of the draft tube
  parameter SI.Length H = 7 "Vertical height of conical diffuser" annotation (
    Dialog(group = "Geometry",enable=DraftTubeType == OpenHPL.Types.DraftTube.ConicalDiffuser));
  parameter SI.Length L = 7.017 "Slant height of conical diffuser, for conical diffuser L=H/cos(diffusion_angle/2), diffusion_anlge=8" annotation (
    Dialog(group = "Geometry",enable=DraftTubeType == OpenHPL.Types.DraftTube.ConicalDiffuser));
  parameter SI.Diameter D_i = 4 "Diameter of the inlet side" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Diameter D_o = 4.978 "Diameter of the outlet side, for conical diffuser D_o=D_i+2*H*tan(diffusion_angle/2)" annotation (
    Dialog(group = "Geometry"));

  parameter SI.Length L_m = 4 "Length of Main section of Moody spreading pipe" annotation (
    Dialog(group = "Geometry",enable=DraftTubeType == OpenHPL.Types.DraftTube.MoodySpreadingPipe));
  parameter SI.Length L_b = 3 "Length of Branch section of Moody spreading pipe" annotation (
    Dialog(group = "Geometry",enable=DraftTubeType == OpenHPL.Types.DraftTube.MoodySpreadingPipe));

  parameter SI.Conversions.NonSIunits.Angle_deg theta = 5 "Angle at which conical diffuser is inclined" annotation (
    Dialog(group = "Geometry",enable=DraftTubeType == OpenHPL.Types.DraftTube.ConicalDiffuser));
  parameter SI.Conversions.NonSIunits.Angle_deg theta_moody = 30 "Angle at which Moody spreading pipes are branched possible value is 15,30,45,60 or 90)" annotation (
    Dialog(group = "Geometry",enable=DraftTubeType == OpenHPL.Types.DraftTube.MoodySpreadingPipe));
  parameter SI.Height p_eps = data.p_eps "Pipe roughness height" annotation (
    Dialog(group = "Geometry"));
  // condition of steady state
  parameter Boolean SteadyState=data.SteadyState "If true, starts in steady state" annotation (Dialog(group="Initialization"));
  // staedy state value for flow rate
  parameter SI.VolumeFlowRate Vdot_0=data.Vdot_0 "Initial volume flow rate" annotation (Dialog(group="Initialization"));
  // possible parameters for temperature variation. Not finished...
  // parameter Boolean TempUse = data.TempUse "If checked - the water temperature is not constant" annotation (Dialog(group = "Initialization"));
  // parameter SI.Temperature T_0 = data.T_0 "Initial water temperature in the pipe" annotation (Dialog(group = "Initialization", enable = TempUse));
  // variables
  SI.Diameter D_ = 0.5 * (D_i + D_o) "Average diameter";
  SI.Area A_i = D_i ^ 2 * pi / 4 "Inlet cross-section area of draft tube";
  SI.Area A_o = D_o ^ 2 * pi / 4 "Outlet cross-section area of draft tube";
  SI.Area A_ = D_ ^ 2 * pi / 4 "Average cross-section area of conical diffuser";

  SI.Mass m "Mass of water inside conical diffuser";
  SI.Mass m_m "Mass of water inside Main section Moody spreading pipes";
  SI.Mass m_b "Mass of water inside Branch section Moody spreading pipes";

  SI.MassFlowRate mdot_m "Mass flow rate inside Main section of Moody spreading pipes";
  SI.MassFlowRate mdot_b "Mass flow rate inside Branch section of Moody spreading pipes";

  SI.Volume V "Volume of water inside the draft tube";
  SI.Momentum M "Momentum of water inside the draft tube";
  SI.Force Mdot "Rate of change of water momentum";
  SI.Force F "Total force acting in the tube";
  SI.Force F_p "Pressure force";
  SI.Force F_f "Fluid frictional force";
  SI.Force F_g "Weight of water";
  SI.Force F_fm "Fluid frictional force in the Main section of Moody spreading pipe";
  SI.Force F_fb "Fluid frictional force in the Branch section of Moody spreading pipe";

  //Real cos_theta = H / L "slope ratio";
  SI.Velocity v "Water velocity for conical diffuser";
  SI.Velocity v_m "Water velocity inside Main section of Moody spreading pipes";
  SI.Velocity v_b "Water velocity inside Branch section of Moody spreading pipes";
  SI.Pressure p_i "Inlet pressure";
  SI.Pressure p_o "Outlet pressure";
  //SI.Pressure dp = p_o-p_i "Pressure drop in and out of draft tube";
  Real phi_d "Generalized friction factor for draft tube";
  Real phi_d_o "Initial generalized friction factor for Moody spreading pipes";

  SI.VolumeFlowRate Vdot(start = Vdot_0, fixed = true) "Volume flow rate";
  SI.VolumeFlowRate Vdot_b "Volume flow rate for Branch section of Moody spreading pipes";

  Real cos_theta = Modelica.Math.cos(SI.Conversions.from_deg(theta))
                                                                                  "Calculating cos_theta";
  Real cos_theta_moody = Modelica.Math.cos(SI.Conversions.from_deg(theta_moody))
                                                                                              "Calculating cos_theta_moody";

  Real cos_theta_moody_by_2 = Modelica.Math.cos(SI.Conversions.from_deg(theta_moody/2))
                                                                                              "Calculating cos_theta_moody_by_2";

 // connectors
  extends OpenHPL.Interfaces.ContactPort;
initial equation
  if SteadyState then
    der(M) = 0;
    //der(n.T) = 0;
  else
    Vdot = Vdot_0;
    //n.T = p.T;
  end if;
equation
  der(M) = Mdot + F "Momentum balance";
  if DraftTubeType == OpenHPL.Types.DraftTube.ConicalDiffuser then
    M = m*v;
    m = data.rho*V "Mass of water inside the draft tube";
    m_m=0;m_b=0; // Unimportant for conical diffuser
    V = pi*H/12*(D_i^2+D_o^2+D_i*D_o) "Volume of water inside the draft tube";
    v = Vdot/A_;
    Vdot_b = 0; // Unimportant for conical diffuser
    v_m=0;v_b=0; // Unimportant for conical diffuser

    Mdot = mdot*v;
    mdot = data.rho*Vdot;
    mdot_m=0; mdot_b=0; // Unimportant for conical diffuser

    F = F_p-F_g-F_f;
    F_p = p_i * A_i - p_o * A_o;
    F_f = Functions.DarcyFriction.Friction(v, D_, L, data.rho, data.mu, p_eps)+1/2*data.rho*v*abs(v)*A_i*phi_d;
    F_fm=0;F_fb=0;
    phi_d = 0.23*(1-D_i/D_o)^2;
    phi_d_o=0; // Unimportant for conical diffuser
    F_g = m*data.g*cos_theta;

  elseif DraftTubeType == OpenHPL.Types.DraftTube.MoodySpreadingPipe then
    // Taking momentum balance only on y-direction
    M = m_m*v_m+2*m_b*v_b*cos_theta_moody_by_2;
    m_m=data.rho*A_i*L_m; m_b=data.rho*A_o*L_m;
    m = m_m+2*m_b;
    v_m = Vdot/A_i; v_b=A_i/(2*A_o)*v_m; v=v_m;
    V = A_i*L_m+2*A_o*L_b;

    Mdot = mdot_m*v_m+2*mdot_b*cos_theta_moody_by_2;
    mdot_m=data.rho*Vdot; mdot_b=data.rho*Vdot_b; Vdot_b=A_o*v_b;
    mdot = mdot_m;

    F = F_p-F_g-F_f;
    F_p = p_i*A_i-2*p_o*A_o*cos_theta_moody_by_2;
    F_g = m_m*data.g+2*m_b*data.g*cos_theta_moody_by_2;
    F_f = F_fm+2*F_fb*cos_theta_moody_by_2+data.rho*v_m*abs(v_m)*A_i*phi_d;
    F_fm = Functions.DarcyFriction.Friction(v_m, D_i, L_m, data.rho, data.mu, p_eps);
    F_fb = Functions.DarcyFriction.Friction(v_b, D_o, L_b, data.rho, data.mu, p_eps);

    // calculating phi_d
    phi_d = 1+(v_b/v_m)^2-2*v_b/v_m*cos_theta_moody-phi_d_o*(v_b/v_m)^2;
    // phi_d_o is calculated based on theta_moody
    if theta_moody == 15 then
      phi_d_o = 0.04;
    elseif theta_moody == 30 then
      phi_d_o = 0.16;
    elseif theta_moody == 45 then
      phi_d_o = 0.36;
    elseif theta_moody == 60 then
      phi_d_o = 0.64;
    elseif theta_moody == 90 then
      phi_d_o = 1;
    end if;

  end if;
  // connector
    p_i = i.p;
    p_o = o.p;
  annotation (
    Documentation(info="<html>
<p>Two of the draft tubes are modeled using <em>Momentum balance . </em>They are:</p>
<ul>
<li><strong>Conical diffuser:</strong> It is the most well-know draft tube which has efficiency of around 90&percnt;  and mostly used for low head reaction turbines.</li>
<li><strong>Moody spreading draft tubes:</strong> When conical diffuser length exceeds beyond its stability for high head reaction turbines, either a elbow type draft tube is used which has around 70&percnt; of efficiency. However, other choice is to use Moody spreading draft tube that has efficiency of around 80&percnt;. The construction and design of Moody spreading draft tube is daunting and time consuming but it is mostly chosen for handling water whril at turbine&apos;s outlet.</li>
</ul>
<p><br>The conical diffuser and Moody spreading draft tubes are shown below:</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/conicalDiffuser.svg\" width=\"500\"/></p>
<p><img src=\"modelica://OpenHPL/Resources/Images/moodySpreadingDT.svg\" width=\"500\"/></p>
</html>"));
end DraftTube;
