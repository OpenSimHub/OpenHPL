within OpenHPL.Examples;
model HPDetailed_Francis "Model of the HP system with Francis turbine and simplified models for conduits (connected to the grid generator is also used)"
  extends Modelica.Icons.Example;
  Waterway.Reservoir reservoir(H_r=48) annotation (Placement(visible=true, transformation(
        origin={-90,10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(duration = 1980, height = 0.87, offset = 0.09, startTime = 10) annotation (
    Placement(visible = true, transformation(origin={50,30},    extent={{10,-10},{-10,10}},      rotation = 0)));
  OpenHPL.Waterway.Pipe intake(H=23) annotation (Placement(visible=true, transformation(extent={{-70,0},{-50,20}},  rotation=0)));
  Waterway.Pipe discharge(L=600, H=0.5) annotation (Placement(visible=true, transformation(extent={{50,-10},{70,10}},rotation=0)));
  OpenHPL.Waterway.Reservoir tail(H_r=5) annotation (Placement(visible=true, transformation(
        origin={90,0},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  ElectroMech.Generators.SynchGen generator(P_op=100e6, UseFrequencyOutput=false) annotation (Placement(visible=true, transformation(extent={{40,-40},{20,-20}},
                                                                                                                                                               rotation=0)));
  OpenHPL.Waterway.SurgeTank surgeTank(h_0=70.9386) annotation (Placement(visible=true, transformation(
        origin={-30,10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.ElectroMech.Turbines.Francis turbine(
    D_i=1.632,
    GivenData=true,
    GivenServoData=true,
    Given_losses=true,
    H_n=460,
    P_n=103e6,
    R_1_=2.63/2,
    R_2_=1.55/2,
    R_Y_=3,
    R_v_=2.89/2,
    Reduction=0.1,
    V_dot_n=24.3,
    WaterCompress=false,
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
    w_v_=0.2) annotation (Placement(visible=true, transformation(
        origin={30,0},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner OpenHPL.Constants Const(V_0 = 4.5199) annotation (
    Placement(visible = true, transformation(origin={-90,90},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Waterway.PenstockKP penstockKP(
    D_i=3,
    H=428.5,
    PipeElasticity=true,
    h_s0=70.9386) annotation (Placement(visible=true, transformation(
        origin={0,10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  connect(penstockKP.o, turbine.i) annotation (
    Line(points={{10,10},{14,10},{14,0},{20,0}},                      color = {28, 108, 200}));
  connect(surgeTank.o, penstockKP.i) annotation (
    Line(points={{-20,10},{-10,10}},                            color = {28, 108, 200}));
  connect(generator.w_out, turbine.w_in) annotation (
    Line(points={{19,-24},{8,-24},{8,-8},{18,-8}},          color = {0, 0, 127}));
  connect(turbine.P_out, generator.P_in) annotation (
    Line(points={{30,-11},{30,-18}},                        color = {0, 0, 127}));
  connect(reservoir.o, intake.i) annotation (
    Line(points={{-80,10},{-70,10}},                                        color = {28, 108, 200}));
  connect(surgeTank.i, intake.o) annotation (
    Line(points={{-40,10},{-50,10}},                                        color = {28, 108, 200}));
  connect(turbine.o, discharge.i) annotation (
    Line(points={{40,0},{50,0}},                                        color = {28, 108, 200}));
  connect(control.y, turbine.u_t) annotation (
    Line(points={{39,30},{30,30},{30,12}},          color = {0, 0, 127}));
  connect(tail.o, discharge.o) annotation (
    Line(points={{80,8.88178e-16},{80,0},{70,0}},                                       color = {28, 108, 200}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4),
    Diagram);
end HPDetailed_Francis;
