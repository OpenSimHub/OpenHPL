within OpenHPL.ElectroMech.Generators;
model SynchGen "Simple model of the generator connected to the grid"
  extends OpenHPL.Icons.Generator;
  outer Constants Const "Using standard class with constants";
  import Modelica.Constants.pi;
  //// parameters of the generator
  parameter Modelica.SIunits.Power P_op = 80e6 "Active power drawn from generator at Steady State operating condition" annotation (
    Dialog(group = "Nominal parameters")), Q_op = 50e6 "Reactive power drawn from generator at SS operating condition" annotation (
    Dialog(group = "Nominal parameters"));
  parameter Modelica.SIunits.Resistance Ra = 0.01 "Phase winding resistance" annotation (
    Dialog(group = "Nominal parameters")), Re = 0.1 "Equivalent network resistance" annotation (
    Dialog(group = "Network")), xd = 12 "d_axis reactance" annotation (
    Dialog(group = "d-q axes")), xq = 12 "q_axis reactance" annotation (
    Dialog(group = "d-q axes")), xxd = 1.7 "d_axis transient reactance" annotation (
    Dialog(group = "Transient d-q axes")), xxq = 1.7 "q_axis transient reactance" annotation (
    Dialog(group = "Transient d-q axes")), xe = 1.4 "Equivalent network reactance" annotation (
    Dialog(group = "Network"));
  parameter Modelica.SIunits.Time TTdo = 6 "d_axis transient open-circuit time constant" annotation (
    Dialog(group = "Transient d-q axes")), TTqo = 0.1 "q_axis transient open-circuit time constant" annotation (
    Dialog(group = "Transient d-q axes")), TE = 0.05 "Excitation system time constant" annotation (
    Dialog(group = "Excitation system")), TFE = 1 "Stablizer time constant" annotation (
    Dialog(group = "Stablizer"));
  parameter Modelica.SIunits.Voltage Vs = 15000 "Network rms voltage" annotation (
    Dialog(group = "Network")), Efmin = 50000 "Min field voltage" annotation (
    Dialog(group = "Transient d-q axes")), Efmax = 50000 "Max field voltage" annotation (
    Dialog(group = "Transient d-q axes"));
  parameter Real KE = 400 "Excitation system gain" annotation (
    Dialog(group = "Excitation system")), KF = 0.025 "Stablizer gain" annotation (
    Dialog(group = "Stablizer"));
  parameter Integer np = 12 "Number of poles" annotation (
    Dialog(group = "Nominal parameters"));
  parameter Modelica.SIunits.AngularVelocity Wm_op = Const.f * pi / 3 "Grid angular velocity" annotation (
    Dialog(group = "Network"));
  parameter Modelica.SIunits.MomentOfInertia J = 2e5 "Moment of inertia of the generator" annotation (
    Dialog(group = "Mechanical part"));
  parameter Real k_b = 1000 "Friction factor in the generator bearing box, W*s3/rad3" annotation (
    Dialog(group = "Mechanical part"));
  parameter Boolean UseFrequencyOutput = true "If checked - get a connector for frequency output" annotation (
    choices(checkBox = true),
    Dialog(group = "Network")), SelfInitialization = false "If checked - specify initial values" annotation (
    choices(checkBox = true),
    Dialog(group = "Initialization"));
  parameter Modelica.SIunits.Angle DELTA_0 = 37.6452 annotation (
    Dialog(group = "Initialization", enable = SelfInitialization));
  parameter Modelica.SIunits.Voltage EEd_0 = -7207.13 "" annotation (
    Dialog(group = "Initialization", enable = SelfInitialization)), EEq_0 = 18005.2 "" annotation (
    Dialog(group = "Initialization", enable = SelfInitialization)), Ef_0 = 38110.4 "" annotation (
    Dialog(group = "Initialization", enable = SelfInitialization)), Vstabilizer_0 = 0 "" annotation (
    Dialog(group = "Initialization", enable = SelfInitialization));
  parameter Modelica.SIunits.AngularVelocity w_0 = 500 * pi / 30 "" annotation (
    Dialog(group = "Initialization", enable = SelfInitialization));
  //// variables
  Modelica.SIunits.Angle PHI_op = atan(Q_op / P_op) "Power angle at Steady State", DELTA_op = atan((I_op * (xq + xe) * cos(PHI_op) - I_op * (Ra + Re) * sin(PHI_op)) / (Vs + I_op * (Ra + Re) * cos(PHI_op) + I_op * (xq + xe) * sin(PHI_op))), DELTA;
  Modelica.SIunits.Current I_op = sqrt(P_op ^ 2 + Q_op ^ 2) / (3 * Vs) "RMS current (per phase) of the generator", Id_op = -I_op * sin(DELTA_op + PHI_op), Iq_op = I_op * cos(DELTA_op + PHI_op), Idq[2], Id, Iq, It;
  Modelica.SIunits.Voltage Ef_op = Vs * cos(DELTA_op) + (Ra + Re) * Iq_op - (xd + xe) * Id_op, Vt_op = sqrt((Vs + I_op * Re * cos(PHI_op) + I_op * xe * sin(PHI_op)) ^ 2 + (I_op * xe * cos(PHI_op) - I_op * Re * sin(PHI_op)) ^ 2), Vtr = Ef_op / KE + Vt_op, Vstabilizer_op = 0, EEd_op = (xxd - xq) * Iq_op, EEq_op = Ef_op + (xd - xxd) * Id_op, Vt, EEd, EEq, Ef, Vstabilizer;
  Modelica.SIunits.AngularVelocity w_op = 500 * pi / 30, w;
  Modelica.SIunits.Resistance Temp[2, 2];
  Modelica.SIunits.Power Pe, Qe;
  Modelica.SIunits.EnergyFlowRate W_ts_dot, W_fa;
  //// conectors
  Modelica.Blocks.Interfaces.RealOutput f = np / 120 * 30 * w / pi if UseFrequencyOutput "Output generator frequency" annotation (
    Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput w_out = w "Output of the generator's angular velocity" annotation (Placement(visible = true, transformation(origin={110,60}, extent={{-10,-10},
            {10,10}},                                                                                                                                                                    rotation=0)));
  Modelica.Blocks.Interfaces.RealInput P_in = W_ts_dot "Input of mechanical power" annotation (
    Placement(transformation(extent={{-20,-20},{20,20}},      rotation = 270, origin={0,120})));
initial equation
  if SelfInitialization == false then
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
  //// voltage-current relation
  Temp = [Ra + Re, xxq + xe; (-xxd) - xe, Ra + Re];
  Temp * Idq = {EEd + Vs * sin(DELTA), EEq - Vs * cos(DELTA)};
  Id = Idq[1];
  Iq = Idq[2];
  Vt = sqrt((EEd - Ra * Id - xxq * Iq) ^ 2 + (EEq - Ra * Iq + xxd * Id) ^ 2);
  It = sqrt(Id ^ 2 + Iq ^ 2);
  Pe = 3 * (EEd * Id + EEq * Iq);
  Qe = sqrt(9 * Vt ^ 2 * It ^ 2 - Pe ^ 2);
  //// dynamic equations
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
  //// Mechanical equation
  W_fa = 0.5 * k_b * w ^ 2;
  der(w) = (W_ts_dot - Pe) / (J * w);
  // - W_fa;
  ////
  annotation (
    Documentation(info="<html>This is a model of the generator that is connected to the grid. This model could give some transient results. However, it is better to use generator models from IPSL.<div><br></div><div>More info about this model:&nbsp;<a href=\"Resources/Report/Generator_model.pdf\">Resources/Report/Generator_model.pdf</a></div></body></html>"));
end SynchGen;
