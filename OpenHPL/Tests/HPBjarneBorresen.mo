within OpenHPL.Tests;
model HPBjarneBorresen "Model of HP system with simplified models for penstock, turbine, etc."
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir reservoir(h_0=503 - 499.5) annotation (Placement(visible=true, transformation(
        origin={-94,64},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe PN6(
    D_i=1.4,
    D_o=1.4,
    H=499.5 - 470,
    L=3372) annotation (Placement(visible=true, transformation(extent={{-76,50},{-56,70}}, rotation=0)));
  OpenHPL.Waterway.Reservoir tail(h_0=218 - 217) annotation (Placement(visible=true, transformation(
        origin={88,-20},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  OpenHPL.Waterway.PenstockKP K92(
    D_i=1.4,
    D_o=1.4,
    H=238 - 217,
    L=147,
    PipeElasticity=true) annotation (Placement(visible=true, transformation(
        origin={46,-8},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  inner OpenHPL.Data data(Vdot_0=2.4) annotation (Placement(visible=true, transformation(
        origin={-90,92},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.ElectroMech.Turbines.Turbine turbine(C_v=0.8) annotation (Placement(visible=true, transformation(
        origin={62,-26},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe PN10(
    D_i=1.4,
    D_o=1.4,
    H=470 - 440,
    L=972) annotation (Placement(visible=true, transformation(
        origin={-40,54},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe PN16(
    D_i=1.4,
    D_o=1.4,
    H=440 - 380,
    L=300) annotation (Placement(visible=true, transformation(
        origin={-12,48},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.Pipe PN20(
    D_i=1.4,
    D_o=1.4,
    H=380 - 340,
    L=252) annotation (Placement(visible=true, transformation(
        origin={14,44},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  OpenHPL.Waterway.PenstockKP K91(
    D_i=1.4,
    D_o=1.4,
    H=340 - 268,
    L=335,
    PipeElasticity=true) annotation (Placement(visible=true, transformation(
        origin={24,28},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  OpenHPL.Waterway.PenstockKP K10(
    D_i=1.4,
    D_o=1.4,
    H=268 - 238,
    L=122,
    PipeElasticity=true) annotation (Placement(visible=true, transformation(
        origin={36,10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp control(duration = 1, height = 0.2, offset = 0.6, startTime = 500) annotation (
    Placement(visible = true, transformation(origin = {44, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(control.y, turbine.u_t) annotation (
    Line(points = {{56, 66}, {62, 66}, {62, -16}, {62, -16}}, color = {0, 0, 127}));
  connect(tail.n, turbine.n) annotation (
    Line(points = {{77.9, -20.1}, {76.4, -20.1}, {76.4, -20.1}, {74.9, -20.1}, {74.9, -20.1}, {71.9, -20.1}, {71.9, -26.1}, {71.9, -26.1}, {71.9, -26.1}, {71.9, -26.1}}, color = {28, 108, 200}));
  connect(K92.n, turbine.p) annotation (
    Line(points = {{45.9, -18.1}, {46.1375, -18.1}, {46.1375, -18.1}, {46.375, -18.1}, {46.375, -18.1}, {46.85, -18.1}, {46.85, -26.1}, {49.375, -26.1}, {49.375, -26.1}, {51.9, -26.1}}, color = {28, 108, 200}));
  connect(K10.n, K92.p) annotation (
    Line(points = {{46, 10}, {46, 2}}, color = {28, 108, 200}));
  connect(K91.n, K10.p) annotation (
    Line(points = {{24, 18}, {24, 18}, {24, 10}, {26, 10}, {26, 10}}, color = {28, 108, 200}));
  connect(PN20.n, K91.p) annotation (
    Line(points = {{24, 44}, {24, 44}, {24, 38}, {24, 38}}, color = {28, 108, 200}));
  connect(PN16.n, PN20.p) annotation (
    Line(points = {{-2, 48}, {1, 48}, {1, 44}, {4, 44}}, color = {28, 108, 200}));
  connect(PN10.n, PN16.p) annotation (
    Line(points = {{-30, 54}, {-25, 54}, {-25, 48}, {-22, 48}}, color = {28, 108, 200}));
  connect(PN6.n, PN10.p) annotation (
    Line(points = {{-56, 60}, {-53, 60}, {-53, 54}, {-50, 54}}, color = {28, 108, 200}));
  connect(reservoir.n, PN6.p) annotation (
    Line(points = {{-83.9, 63.9}, {-79.95, 63.9}, {-79.95, 59.9}, {-75.9, 59.9}}, color = {28, 108, 200}));
  annotation (
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 0.0001, Interval = 0.4));
end HPBjarneBorresen;
