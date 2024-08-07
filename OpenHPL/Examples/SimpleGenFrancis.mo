within OpenHPL.Examples;
model SimpleGenFrancis "Model of a hydropower system with Francis turbine model"
  extends Modelica.Icons.Example;
  Waterway.Reservoir reservoir(h_0=48) annotation (Placement(transformation(
        origin={-90,50},
        extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp control(
    duration=980, height = 0.87, offset = 0.09, startTime = 10) annotation (
    Placement(transformation(origin={50,30}, extent={{10,-10},{-10,10}})));
  OpenHPL.Waterway.Pipe intake(H = 23, Vdot(fixed = true)) annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
  Waterway.Pipe discharge(L=600, H=0.5) annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  OpenHPL.Waterway.Reservoir tail(h_0=5) annotation (Placement(transformation(
        origin={90,0},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  ElectroMech.Generators.SynchGen generator(P_op=100e6, UseFrequencyOutput=false) annotation (Placement(transformation(extent={{40,-40},{20,-20}})));
  replaceable
  Waterway.Pipe penstock(
    vertical=true,
    L=600,
    H=428.5,
    D_i=3,
    D_o=3) constrainedby Interfaces.TwoContact
           annotation (Placement(transformation(
        origin={-30,0},
        extent={{-10,-10},{10,10}})));
  OpenHPL.Waterway.SurgeTank surgeTank(h_0 = 71) annotation (Placement(transformation(
        origin={-30,50},
        extent={{-10,-10},{10,10}})));
  OpenHPL.ElectroMech.Turbines.Francis turbine(
    D_i=1.632,
    GivenData=true,
    GivenServoData=true,
    H_n=460,
    P_n=103e6,
    R_1_=2.63/2,
    R_2_=1.55/2,
    R_Y_=3,
    R_v_=2.89/2,
    Reduction=0.1,
    Vdot_n=24.3,
    beta1_=110,
    beta2_=162.5,
    dp_v_condition=false,
    k_ft1_=7e5,
    k_ft2_=0e3,
    k_ft3_=1.63e4,
    k_fv=0e3,
    n_n=500,
    r_Y_=1.2,
    r_v_=1.1,
    u_end_=2.4,
    u_start_=2.28,
    w_1_=0.2,
    w_v_=0.2,
    enable_P_out=true)
              annotation (Placement(transformation(
        origin={30,0},
        extent={{-10,-10},{10,10}})));
  inner OpenHPL.Data data(Vdot_0=4.54) annotation (Placement(transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}})));
  Waterway.Fitting fitting(
    D_i=3,
    D_o=1.63,
    fit_type=OpenHPL.Types.Fitting.Square) annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
equation
  connect(generator.w_out, turbine.w_in) annotation (
    Line(points={{19,-24},{12,-24},{12,-8},{18,-8}}, color = {0, 0, 127}));
  connect(turbine.P_out, generator.P_in) annotation (
    Line(points={{34,11},{34,18},{30,18},{30,-18}},
                                     color = {0, 0, 127}));
  connect(reservoir.o, intake.i) annotation (
    Line(points={{-80,50},{-70,50}}, color = {28, 108, 200}));
  connect(surgeTank.i, intake.o) annotation (
    Line(points={{-40,50},{-50,50}}, color = {28, 108, 200}));
  connect(surgeTank.o, penstock.i) annotation (
    Line(points={{-20,50},{-10,50},{-10,20},{-48,20},{-48,0},{-40,0}}, color = {28, 108, 200}));
  connect(turbine.o, discharge.i) annotation (
    Line(points={{40,0},{50,0}}, color = {28, 108, 200}));
  connect(control.y, turbine.u_t) annotation (
    Line(points={{39,30},{22,30},{22,12}}, color = {0, 0, 127}));
  connect(turbine.i, fitting.o) annotation (
    Line(points={{20,0},{8,0}}, color = {28, 108, 200}));
  connect(tail.o, discharge.o) annotation (
    Line(points={{80,6.66134e-16},{80,0},{70,0}}, color = {28, 108, 200}));
  connect(penstock.o, fitting.i) annotation (
    Line(points={{-20,0},{-12,0}}, color = {28, 108, 200}));
  annotation (experiment(StopTime=1000));
end SimpleGenFrancis;
