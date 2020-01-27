within OpenHPL.Waterway;
model DraftTube "Model of a draft tube for reaction turbines"
  outer Data data "Using standard data set";
  extends OpenHPL.Icons.DraftTube;
  import Modelica.Constants.pi;
  parameter Types.DraftTube DraftTubeType = OpenHPL.Types.DraftTube.ConicalDiffuser "Types of draft tube" annotation (
    Dialog(group = "Draft tube types"));

  // geometrical parameters of the draft tube
  parameter Modelica.SIunits.Length H = 10 "Vertical height of conical diffuser" annotation (
    Dialog(group = "Geometry",enable=DraftTubeType == OpenHPL.Types.DraftTube.ConicalDiffuser));
  parameter Modelica.SIunits.Length L = 10.15 "Slant height of conical diffuser" annotation (
    Dialog(group = "Geometry",enable=DraftTubeType == OpenHPL.Types.DraftTube.ConicalDiffuser));
  parameter Modelica.SIunits.Diameter D_i = 5 "Diameter of the inlet side of conical diffuser" annotation (
    Dialog(group = "Geometry",enable=DraftTubeType == OpenHPL.Types.DraftTube.ConicalDiffuser));
  parameter Modelica.SIunits.Diameter D_o = 13.52 "Diameter of the outlet side of conical diffuser" annotation (
    Dialog(group = "Geometry",enable=DraftTubeType == OpenHPL.Types.DraftTube.ConicalDiffuser));

  parameter Modelica.SIunits.Length L_m = 10.15 "Length of Main section of Moody spreading pipe" annotation (
    Dialog(group = "Geometry",enable=DraftTubeType == OpenHPL.Types.DraftTube.MoodySpreadingPipe));
  parameter Modelica.SIunits.Length L_b1 = 10.15 "Length of Branch-1 of Moody spreading pipe" annotation (
    Dialog(group = "Geometry",enable=DraftTubeType == OpenHPL.Types.DraftTube.MoodySpreadingPipe));
  parameter Modelica.SIunits.Length L_b2 = 10.15 "Length of Branch-2 of Moody spreading pipe" annotation (
    Dialog(group = "Geometry",enable=DraftTubeType == OpenHPL.Types.DraftTube.MoodySpreadingPipe));
  parameter Modelica.SIunits.Diameter D = 13.52 "Diameter of the Moody spreading pipe" annotation (
    Dialog(group = "Geometry",enable=DraftTubeType == OpenHPL.Types.DraftTube.MoodySpreadingPipe));

  parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg theta = 5 "Angle at which conical diffuser is inclined" annotation (
    Dialog(group = "Geometry",enable=DraftTubeType == OpenHPL.Types.DraftTube.ConicalDiffuser));
  parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg theta_moody = 30 "Angle at which moody's spreading pipes are branched" annotation (
    Dialog(group = "Geometry",enable=DraftTubeType == OpenHPL.Types.DraftTube.MoodySpreadingPipe));
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

  Modelica.SIunits.Pressure p_o1 "Outlet pressure at Branch-1 of Moody spreading pipe";
  Modelica.SIunits.Pressure p_o2 "Outlet pressure at Branch-1 of Moody spreading pipe";

  Modelica.SIunits.Volume V "Volume of water inside draft tube";
  Modelica.SIunits.Momentum M "Momentum of water inside the draft tube";
  Modelica.SIunits.Force Mdot "Rate of change of water momentum";
  Modelica.SIunits.Force F "Total force acting in the tube";
  Modelica.SIunits.Force F_p "Pressure force";
  Modelica.SIunits.Force F_f "Fluid frictional force";
  Modelica.SIunits.Force F_g "Weight of water";
  Modelica.SIunits.Area A_i = D_i ^ 2 * pi / 4 "Inlet cross section area of conical diffuser";
  Modelica.SIunits.Area A_o = D_o ^ 2 * pi / 4 "Outlet cross section area of conical diffuser";
  Modelica.SIunits.Area A_ = D_ ^ 2 * pi / 4 "Average cross section area of conical diffuser";
  Modelica.SIunits.Area A = D ^ 2 * pi / 4 "Crossection area of Main section of Moody spreading pipe";
  //Real cos_theta = H / L "slope ratio";
  Modelica.SIunits.Velocity v "Water velocity";
  Modelica.SIunits.Pressure p_i "Inlet pressure";
  Modelica.SIunits.Pressure p_o "Outlet pressure";
  //Modelica.SIunits.Pressure dp = p_o-p_i "Pressure drop in and out of draft tube";
  Modelica.SIunits.VolumeFlowRate Vdot(start = Vdot_0, fixed = true) "Volumeteric flow rate";

  Real cos_theta = Modelica.Math.cos(Modelica.SIunits.Conversions.from_deg(theta))
                                                                                  "Calculating cos_theta";
  Real cos_theta_moody = Modelica.Math.cos(Modelica.SIunits.Conversions.from_deg(theta_moody))
                                                                                              "Calculating cos_theta_moody";

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
  der(M) = Mdot + F "Momentum balance";
  if DraftTubeType == OpenHPL.Types.DraftTube.ConicalDiffuser then

    M = m*v;
    m = data.rho*V "Mass of water inside the draft tube";
    V = 1/3*pi*H/4*(D_i^2+D_o^2+D_i*D_o) "Volume of water inside the draft tube";
    v = Vdot/A_;

    Mdot = mdot*v;
    mdot = data.rho*Vdot;

    F = F_p-F_g-F_f;
    F_p = p_i * A_i - p_o * A_o;
    F_f = Functions.DarcyFriction.Friction(v, D_, L, data.rho, data.mu, p_eps);
    F_g = m*data.g*cos_theta;

    // connector
    p_i = i.p; p_o1=0; p_o2=0;
    p_o = o.p;
  elseif DraftTubeType == OpenHPL.Types.DraftTube.MoodySpreadingPipe then
    // Taking momentum balance only on y-direction
    M = m*v;
    m = data.rho*A*(L_m+1/4*cos_theta_moody*(L_b1+L_b2));
    v = Vdot/A;  V = 0;//Volume is not useful for this type draft tube

    Mdot = mdot*v;
    mdot = data.rho*Vdot;

    F = F_p - F_f - F_g;
    F_p = p_i*A - (p_o1-p_o2)*A/4*cos_theta_moody;
    F_f = Functions.DarcyFriction.Friction(v, D, L_m, data.rho, data.mu, p_eps)+
          Functions.DarcyFriction.Friction(v/2, D/2, L_b1, data.rho, data.mu, p_eps)*cos_theta_moody+
          Functions.DarcyFriction.Friction(v/2, D/2, L_b2, data.rho, data.mu, p_eps)*cos_theta_moody;



    F_g = data.rho*A*data.g*(L_m+1/4*cos_theta_moody*(L_b1+L_b2));
    //F_g = data.rho*A*L_m*data.g+data.rho*A/4*L_b1*cos_theta_moody*data.g+data.rho*A/4*L_b2*cos_theta_moody*data.g;
    // connector
    p_i = i.p; p_o = 0;
    p_o1 = p_o2;
    p_o1 + p_o2 = o.p;
  end if;
  annotation (
    Documentation(info="<html>
<p>Two of the draft tubes are modeled using <i>Momentum balance . </i>They are:</p>
<ul>
<li><b>Conical diffuser:</b> It is the most well-know draft tube which has efficiency of around 90&percnt;  and mostly used for low head reaction turbines.</li>
<li><b>Moody spreading draft tubes:</b> When conical diffuser length exceeds beyond its stability for high head reaction turbines, either a elbow type draft tube is used which has around 70&percnt; of efficiency. However, other choice is to use Moody spreading draft tube that has efficiency of around 80&percnt;. The construction and design of Moody spreading draft tube is daunting and time consuming but it is mostly choosen for handling water whril at turbine&apos;s outlet.</li>
</ul>
<p><br>The conical diffuser and Moody spreading draft tubes are shown below:</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/conicalDiffuser.svg\"/></p>
<p><img src=\"modelica://OpenHPL/Resources/Images/moodySpreadingDT.svg\"/></p>
</html>"));
end DraftTube;
