within OpenHPL.Examples;
model HPDetailed_Francis "Model of the HP system with Francis turbine and simplified models for conduits (connected to the grid generator is also used)"
  extends Modelica.Icons.Example;
  Waterway.Reservoir reservoir(H_r=48) annotation (Placement(visible=true, transformation(
        origin={-90,60},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(duration = 1980, height = 0.87, offset = 0.09, startTime = 10) annotation (
    Placement(visible = true, transformation(origin = {10, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenHPL.Waterway.Pipe intake(H=23) annotation (Placement(visible=true, transformation(extent={{-76,50},{-56,70}}, rotation=0)));
  Waterway.Pipe discharge(L=600, H=0.5) annotation (Placement(visible=true, transformation(extent={{54,30},{74,50}}, rotation=0)));
  OpenHPL.Waterway.Reservoir tail(H_r=5) annotation (Placement(visible=true, transformation(
        origin={94,44},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  ElectroMech.Generators.SynchGen generator(P_op=100e6, UseFrequencyOutput=false) annotation (Placement(visible=true, transformation(extent={{16,-4},{40,20}}, rotation=0)));
  OpenHPL.Waterway.SurgeTank surgeTank(h_0=70.9386) annotation (Placement(visible=true, transformation(
        origin={-36,66},
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
        origin={28,36},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner OpenHPL.Constants Const(V_0 = 4.5199) annotation (
    Placement(visible = true, transformation(origin = {-90, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Waterway.PenstockKP penstockKP(
    D_i=3,
    H=428.5,
    PipeElasticity=true,
    h_s0=70.9386) annotation (Placement(visible=true, transformation(
        origin={-12,48},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  connect(penstockKP.n, turbine.p) annotation (
    Line(points = {{-2, 48}, {-2, 48}, {-2, 36}, {18, 36}, {18, 36}}, color = {28, 108, 200}));
  connect(surgeTank.n, penstockKP.p) annotation (
    Line(points = {{-26, 66}, {-22, 66}, {-22, 48}, {-22, 48}}, color = {28, 108, 200}));
  connect(generator.w_out, turbine.w_in) annotation (
    Line(points={{35.2,20},{32,20},{32,30},{16,30}},        color = {0, 0, 127}));
  connect(turbine.P_out, generator.P_in) annotation (
    Line(points={{28,25},{22,25},{22,20},{20.8,20}},        color = {0, 0, 127}));
  connect(reservoir.n, intake.p) annotation (
    Line(points={{-80,60},{-76,60}},                                        color = {28, 108, 200}));
  connect(surgeTank.p, intake.n) annotation (
    Line(points={{-46,66},{-48,66},{-48,60},{-56,60}},                      color = {28, 108, 200}));
  connect(turbine.n, discharge.p) annotation (
    Line(points={{38,36},{48,36},{48,40},{54,40}},                      color = {28, 108, 200}));
  connect(control.y, turbine.u_t) annotation (
    Line(points={{21,84},{28,84},{28,48}},          color = {0, 0, 127}));
  connect(tail.n, discharge.n) annotation (
    Line(points={{84,44},{84,41.95},{80,41.95},{80,40},{74,40}},                        color = {28, 108, 200}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4),
    Diagram);
end HPDetailed_Francis;
