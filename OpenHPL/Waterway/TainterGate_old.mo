within OpenHPL.Waterway;
model TainterGate_old "Model of a tainter gate (no friction considered)"
  outer Data data "Using standard class with system parameters";
  extends Icons.TainterGate;
  extends OpenHPL.Interfaces.ContactPort;

//   parameter SI.Height b_max "Maxium opening of the gate";
//   parameter SI.Height b_min = 0 "Minimum opening of the gate";
  parameter SI.Length r "Radius of the gate arm";
  parameter SI.Height a "Height of the hinge above gate bottom";
  parameter SI.Height b "Width of the gate";
  parameter Real Cc_[3] = {1,2,3} "Polinomial factors of contraction coefficient Cc {linear,quadratic,cube}";
  SI.Height h_i "Inlet water level";
  SI.Height h_o "Outlet water level";
  Real alpha = h_o/(Cc*u);
  Real beta = h_i/h_o;
  Real gamma = (h_o/(Cc*u))^2 - (h_o/h_i)^2 "Loss factor";
  Real psi = (1/beta)^2 - 1 + (gamma^2*(beta-1))/(psi_x1 + psi_x2) "Head-loss parameter";
  Real psi_ = (1/beta)^2 - 1 + (gamma^2*(beta-1))/(psi_x1 - psi_x2) "Neg Head-loss parameter";
  Real psi_x1 = gamma*beta-2*(alpha-1);
  Real psi_x2 =  sqrt((2*(alpha-1)-gamma*beta)^2 - gamma^2*(beta^2-1));

  SI.Angle theta = C.pi/2 - asin((a-u)/r) "Flow angle of the gate";
  Real Cc = Cc_[3]*theta^3 + Cc_[2]*theta^2 + Cc_[1]*theta + 1.002282138151680 "Contraction coefficient";
  SI.VolumeFlowRate Vdot,Vdot_gamma "Volume flow rate through the gate";

    Modelica.Blocks.Interfaces.RealInput u "Opening of the gate [m]" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={0,120})));
equation
  Vdot = b*h_o * sqrt((2*data.g*max(0,(h_i - h_o)))/(psi + 1 - (h_o/h_i)^2)) "Calculated flow";
  Vdot_gamma = b*h_o * sqrt((2*data.g*max(0,(h_i - h_o)))/(gamma + 1 - (h_o/h_i)^2)) "Calculated flow";
  mdot = Vdot * data.rho "Mass flow rate through the gate";
  i.p = h_i * data.g * data.rho + data.p_a "Inlet water pressure";
  o.p = h_o * data.g * data.rho + data.p_a "Outlet water pressure";
end TainterGate_old;
