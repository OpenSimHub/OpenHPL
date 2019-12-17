within OpenHPL.Tests;
model HPDraftTube "Testing the draft tube models."
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(H_r=48) annotation (Placement(visible=true, transformation(
        origin={-88,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = -0.04615, offset = 0.7493, startTime = 600) annotation (
    Placement(visible = true, transformation(origin={32,64},     extent = {{-10, -10}, {10, 10}}, rotation=270)));
  OpenHPL.Waterway.Pipe intake(H=23) annotation (Placement(visible=true, transformation(extent={{-68,40},
            {-48,60}},                                                                                              rotation=0)));
  OpenHPL.Waterway.Pipe discharge(
    H=4.92,
    L=5,
    D_i=3,
    D_o=4.73)                                   annotation (Placement(visible=true, transformation(extent={{54,30},
            {74,50}},                                                                                                         rotation=0)));
  OpenHPL.Waterway.Reservoir tail(H_r=5, Input_level=false) annotation (Placement(visible=true, transformation(
        origin={90,40},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.Pipe penstock(
    D_i=3,
    D_o=3,
    H=428.5,
    L=600,
    vertical=true) annotation (Placement(visible=true, transformation(
        origin={2,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.SurgeTank surgeTank(h_0=69.9) annotation (Placement(visible=true, transformation(
        origin={-28,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Turbines.Turbine turbine(C_v=3.7, ConstEfficiency=false) annotation (Placement(visible=true, transformation(
        origin={32,30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  inner OpenHPL.Data data annotation (Placement(visible=true, transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.Reservoir         reservoir1(H_r=48)
                                               annotation (Placement(visible=true, transformation(
        origin={-88,-18},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control1(
    duration=1,
    height=-0.04615,
    offset=0.7493,
    startTime=600)                                                                                        annotation (
    Placement(visible = true, transformation(origin={32,-4},     extent = {{-10, -10}, {10, 10}}, rotation=270)));
  Waterway.Pipe         intake1(H=23)
                                     annotation (Placement(visible=true, transformation(extent={{-68,-28},
            {-48,-8}},                                                                                              rotation=0)));
  Waterway.Reservoir         tail1(H_r=5, Input_level=false)
                                                            annotation (Placement(visible=true, transformation(
        origin={90,-28},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Waterway.Pipe         penstock1(
    D_i=3,
    D_o=3,
    H=428.5,
    L=600,
    vertical=true) annotation (Placement(visible=true, transformation(
        origin={2,-18},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.SurgeTank         surgeTank1(h_0=69.9)
                                                 annotation (Placement(visible=true, transformation(
        origin={-28,-18},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Turbines.Turbine turbine1(C_v=3.7, ConstEfficiency=false)
                                                                       annotation (Placement(visible=true, transformation(
        origin={32,-38},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.DraftTube draftTube(
    H=4.92,
    L=5,
    D_i=3,
    D_o=4.73) annotation (Placement(transformation(extent={{54,-42},{74,-22}})));
equation
  connect(turbine.o, discharge.i) annotation (
    Line(points={{42,30},{46,30},{46,40},{54,40}},          color = {28, 108, 200}));
  connect(penstock.o, turbine.i) annotation (
    Line(points={{12,50},{16.95,50},{16.95,30},{22,30}},                         color = {28, 108, 200}));
  connect(reservoir.o, intake.i) annotation (
    Line(points={{-78,50},{-68,50}},                                              color = {28, 108, 200}));
  connect(intake.o, surgeTank.i) annotation (
    Line(points={{-48,50},{-38,50}},                                              color = {28, 108, 200}));
  connect(surgeTank.o, penstock.i) annotation (
    Line(points={{-18,50},{-8,50}},                                               color = {28, 108, 200}));
  connect(discharge.o, tail.o) annotation (Line(points={{74,40},{80,40}},
                                                                        color={28,108,200}));
  connect(turbine.u_t, control.y)
    annotation (Line(points={{32,42},{32,53}}, color={0,0,127}));
  connect(penstock1.o, turbine1.i) annotation (Line(points={{12,-18},{16.95,-18},
          {16.95,-38},{22,-38}}, color={28,108,200}));
  connect(reservoir1.o, intake1.i)
    annotation (Line(points={{-78,-18},{-68,-18}}, color={28,108,200}));
  connect(intake1.o, surgeTank1.i)
    annotation (Line(points={{-48,-18},{-38,-18}}, color={28,108,200}));
  connect(surgeTank1.o, penstock1.i)
    annotation (Line(points={{-18,-18},{-8,-18}}, color={28,108,200}));
  connect(turbine1.u_t, control1.y)
    annotation (Line(points={{32,-26},{32,-15}}, color={0,0,127}));
  connect(turbine1.o, draftTube.i) annotation (Line(points={{42,-38},{48,-38},{
          48,-32},{54,-32}}, color={28,108,200}));
  connect(tail1.o, draftTube.o) annotation (Line(points={{80,-28},{78,-28},{78,
          -32},{74,-32}}, color={28,108,200}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPDraftTube;
