within OpenHPL.ElectroMech.Generators;
model SynchGen "Simple model of the generator connected to the grid"
  extends OpenHPL.Icons.Generator;
  outer Data data "Using standard class with constants";
  import Modelica.Constants.pi;
  // parameters of the generator
  parameter SI.Power P_op = 80e6 "Active power drawn from generator at Steady State operating condition" annotation (
    Dialog(group = "Nominal parameters")), Q_op = 50e6 "Reactive power drawn from generator at SS operating condition" annotation (
    Dialog(group = "Nominal parameters"));
  parameter SI.Resistance Ra = 0.01 "Phase winding resistance" annotation (
    Dialog(group = "Nominal parameters")), Re = 0.1 "Equivalent network resistance" annotation (
    Dialog(group = "Network")), xd = 12 "d_axis reactance" annotation (
    Dialog(group = "d-q axes")), xq = 12 "q_axis reactance" annotation (
    Dialog(group = "d-q axes")), xxd = 1.7 "d_axis transient reactance" annotation (
    Dialog(group = "Transient d-q axes")), xxq = 1.7 "q_axis transient reactance" annotation (
    Dialog(group = "Transient d-q axes")), xe = 1.4 "Equivalent network reactance" annotation (
    Dialog(group = "Network"));
  parameter SI.Time TTdo = 6 "d_axis transient open-circuit time constant" annotation (
    Dialog(group = "Transient d-q axes")), TTqo = 0.1 "q_axis transient open-circuit time constant" annotation (
    Dialog(group = "Transient d-q axes")), TE = 0.05 "Excitation system time constant" annotation (
    Dialog(group = "Excitation system")), TFE = 1 "Stablizer time constant" annotation (
    Dialog(group = "Stablizer"));
  parameter SI.Voltage Vs = 15000 "Network rms voltage" annotation (
    Dialog(group = "Network")), Efmin = 50000 "Min field voltage" annotation (
    Dialog(group = "Transient d-q axes")), Efmax = 50000 "Max field voltage" annotation (
    Dialog(group = "Transient d-q axes"));
  parameter Real KE = 400 "Excitation system gain" annotation (
    Dialog(group = "Excitation system")), KF = 0.025 "Stablizer gain" annotation (
    Dialog(group = "Stablizer"));
  parameter Integer np = 12 "Number of poles" annotation (
    Dialog(group = "Nominal parameters"));
  parameter SI.AngularVelocity Wm_op = data.f_0 * pi / 3 "Grid angular velocity" annotation (
    Dialog(group = "Network"));
  parameter SI.MomentOfInertia J = 2e5 "Moment of inertia of the generator" annotation (
    Dialog(group = "Mechanical part"));
  parameter Real k_b = 1000 "Friction factor in the generator bearing box, W*s3/rad3" annotation (
    Dialog(group = "Mechanical part"));
  parameter Boolean UseFrequencyOutput = true "If checked - get a connector for frequency output" annotation (
    choices(checkBox = true),
    Dialog(group = "Network")), SelfInitialization = false "If checked - specify initial values" annotation (
    choices(checkBox = true),
    Dialog(group = "Initialization"));
  parameter SI.Angle DELTA_0 = 37.6452 annotation (
    Dialog(group = "Initialization", enable = SelfInitialization));
  parameter SI.Voltage EEd_0 = -7207.13 "" annotation (
    Dialog(group = "Initialization", enable = SelfInitialization)), EEq_0 = 18005.2 "" annotation (
    Dialog(group = "Initialization", enable = SelfInitialization)), Ef_0 = 38110.4 "" annotation (
    Dialog(group = "Initialization", enable = SelfInitialization)), Vstabilizer_0 = 0 "" annotation (
    Dialog(group = "Initialization", enable = SelfInitialization));
  parameter SI.AngularVelocity w_0 = 500 * pi / 30 "" annotation (
    Dialog(group = "Initialization", enable = SelfInitialization));
  // variables
  SI.Angle PHI_op = atan(Q_op / P_op) "Power angle at Steady State", DELTA_op = atan((I_op * (xq + xe) * cos(PHI_op) - I_op * (Ra + Re) * sin(PHI_op)) / (Vs + I_op * (Ra + Re) * cos(PHI_op) + I_op * (xq + xe) * sin(PHI_op))), DELTA;
  SI.Current I_op = sqrt(P_op ^ 2 + Q_op ^ 2) / (3 * Vs) "RMS current (per phase) of the generator", Id_op = -I_op * sin(DELTA_op + PHI_op), Iq_op = I_op * cos(DELTA_op + PHI_op), Idq[2], Id, Iq, It;
  SI.Voltage Ef_op = Vs * cos(DELTA_op) + (Ra + Re) * Iq_op - (xd + xe) * Id_op, Vt_op = sqrt((Vs + I_op * Re * cos(PHI_op) + I_op * xe * sin(PHI_op)) ^ 2 + (I_op * xe * cos(PHI_op) - I_op * Re * sin(PHI_op)) ^ 2), Vtr = Ef_op / KE + Vt_op, Vstabilizer_op = 0, EEd_op = (xxd - xq) * Iq_op, EEq_op = Ef_op + (xd - xxd) * Id_op, Vt, EEd, EEq, Ef, Vstabilizer;
  SI.AngularVelocity w_op = 500 * pi / 30, w;
  SI.Resistance Temp[2, 2];
  SI.Power Pe, Qe;
  SI.EnergyFlowRate Wdot_ts = P_in, W_fa;
  // connectors
  Modelica.Blocks.Interfaces.RealOutput f = np / 120 * 30 * w / pi if UseFrequencyOutput "Output generator frequency" annotation (
    Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput w_out = w "Output of the generator's angular velocity" annotation (Placement(transformation(origin={110,60}, extent={{-10,-10},
            {10,10}})));
  Modelica.Blocks.Interfaces.RealInput P_in "Input of mechanical power" annotation (
    Placement(transformation(extent={{-20,-20},{20,20}}, rotation = 270, origin={0,120})));
initial equation
  if not SelfInitialization then
    EEd = EEd_op;
    EEq = EEq_op;
    DELTA = DELTA_op;
    Ef = Ef_op;
    Vstabilizer = Vstabilizer_op;
    w = w_op;
  else
    EEd = EEd_0;
    EEq = EEq_0;
    DELTA = DELTA_0;
    Ef = Ef_0;
    Vstabilizer = Vstabilizer_0;
    w = w_0;
  end if;
equation
  // voltage-current relation
  Temp = [Ra + Re, xxq + xe; (-xxd) - xe, Ra + Re];
  Temp * Idq = {EEd + Vs * sin(DELTA), EEq - Vs * cos(DELTA)};
  Id = Idq[1];
  Iq = Idq[2];
  Vt = sqrt((EEd - Ra * Id - xxq * Iq) ^ 2 + (EEq - Ra * Iq + xxd * Id) ^ 2);
  It = sqrt(Id ^ 2 + Iq ^ 2);
  Pe = 3 * (EEd * Id + EEq * Iq);
  Qe = sqrt(9 * Vt ^ 2 * It ^ 2 - Pe ^ 2);
  // dynamic equations
  TTqo * der(EEd) = (-EEd) + (xxq - xq) * Iq;
  TTdo * der(EEq) = (-EEq) + (xd - xxd) * Id + Ef;
  der(DELTA) = (w - Wm_op) * np / 2;
  //if Ef >= Efmax and ((-Ef) + KE * (Vtr - Vt - Vstabilizer)) / TE > 0 then
  //  der(Ef) = 0;
  //elseif Ef < (-Efmin) and ((-Ef) + KE * (Vtr - Vt - Vstabilizer)) / TE < 0 then
  //  der(Ef) = 0;
  //else
  //der(Ef) = ((-Ef) + KE * (Vtr - Vt)) / TE;
  der(Ef) = ((-Ef) + KE * (Vtr - Vt - Vstabilizer)) / TE;
  //end if;
  der(Vstabilizer) = ((-Vstabilizer) + KF * der(Ef)) / TFE;
  // Mechanical equation
  W_fa = 0.5 * k_b * w ^ 2;
  der(w) = (Wdot_ts - Pe) / (J * w);
  // - W_fa;
  //
  annotation (
    Documentation(info= "<html>
<h4>Synchronous Generator Model</h4>
<p>Detailed synchronous generator model connected to the grid, based on d-q decomposition.</p>

<h5>Voltage-Current Relation</h5>
<p>$$ \\left[\\begin{matrix}R_a+R_e & x_q'+x_e\\\\ -x_d'-x_e & R_a+R_e\\end{matrix}\\right]\\left[\\begin{matrix}I_d \\\\ I_q\\end{matrix}\\right]= \\left[\\begin{matrix}E_d'+V_s\\sin\\delta_e \\\\ E_q'-V_s\\cos\\delta_e\\end{matrix}\\right] $$</p>
<p>where:</p>
<ul>
<li>\\(R_a\\) and \\(R_e\\) are phase winding and equivalent network resistances</li>
<li>\\(x_d\\), \\(x_q\\), \\(x_d'\\), \\(x_q'\\) are d-/q-axis normal and transient reactances</li>
<li>\\(x_e\\) is equivalent network reactance</li>
<li>\\(I_d\\), \\(I_q\\) are d-/q-axis currents</li>
<li>\\(E_d'\\), \\(E_q'\\) are d-/q-axis transient voltages</li>
<li>\\(V_s\\) is network RMS voltage</li>
<li>\\(\\delta_e\\) is phase shift angle</li>
</ul>

<h5>Phase Shift Angle Dynamics</h5>
<p>$$ \\frac{d\\delta_e}{dt} = (\\omega - \\omega_s)\\frac{n_p}{2} $$</p>
<p>where \\(n_p\\) is number of poles, \\(\\omega\\) and \\(\\omega_s\\) are generator and grid angular velocities.</p>

<h5>Swing Equation</h5>
<p>$$ \\frac{d\\omega}{dt}=\\frac{\\dot{W}_s-P_e}{J\\omega} $$</p>

<h5>Transient Operation</h5>
<p>$$
\\begin{array}{c}
T_{qo}'\\frac{dE_d'}{dt} =-E_d' + (x_q' - x_q)I_q \\\\
T_{do}'\\frac{dE_q'}{dt} = -E_q' + (x_d - x_d')I_d + E_f
\\end{array}
$$</p>
<p>where \\(T_{do}'\\) and \\(T_{qo}'\\) are d-/q-axis transient open-circuit time constants.</p>

<h5>Excitation System</h5>
<p>Field voltage dynamics:</p>
<p>$$ \\frac{dE_f}{dt} = \\frac{-E_f + K_E\\left(V_{tr}-V_t-V_{stab}\\right)}{T_E} $$</p>
<p>where \\(K_E\\) is excitation system gain, \\(T_E\\) is excitation time constant, \\(V_{tr}\\) is voltage reference set point, 
and \\(V_t = \\sqrt{\\left(E_d'-R_aI_d-x_q'I_q\\right)^2+\\left(E_q'-R_aI_q+x_d'I_d\\right)^2}\\) is terminal voltage.</p>

<h5>Stabilization</h5>
<p>$$ \\frac{dV_{stab}}{dt} = \\frac{-V_{stab} + K_F\\frac{dE_f}{dt}}{T_{FE}} $$</p>
<p>where \\(K_F\\) is stabilizer gain and \\(T_{FE}\\) is stabilizer time constant.</p>

<h5>Output Power</h5>
<p>Active and reactive power:</p>
<p>$$
\\begin{array}{c}
P_e = 3\\left(E_d'I_d+E_q'I_q\\right)\\\\
Q_e = \\sqrt{9V_t^2I_t^2-P_e^2}
\\end{array}
$$</p>
<p>where \\(I_t=\\sqrt{I_d^2+I_q^2}\\) is terminate current.</p>

<h5>Connectors</h5>
<ul>
<li>RealInput: turbine shaft power</li>
<li>RealOutput: angular velocity and frequency</li>
</ul>

<h5>Parameters</h5>
<p>User specifies: nominal active/reactive powers, phase winding resistance, number of poles, network parameters 
(equivalent resistance/reactance, RMS voltage, grid angular velocity), d-/q-axis reactances and time constants, 
field voltage limits, excitation/stabilizer gains and time constants, moment of inertia, friction factor, and 
initialization options.</p>

<p><em>Note: For more advanced modeling, consider using generator models from <a href=\"modelica://OpenIPSL\">OpenIPSL</a>.</em></p>
<p>More details in <a href=\"modelica://OpenHPL.UsersGuide.References\">[Sharefi2011]</a>.</p>
</html>"));
end SynchGen;
