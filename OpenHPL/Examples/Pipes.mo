within OpenHPL.Examples;
model Pipes "Example of contracting, contstant and expanding pipe diameters"
    extends Modelica.Icons.Example;

    inner OpenHPL.Data data annotation (
      Placement(transformation(origin={-90,90}, extent={{-10,-10},{10,10}})));
    parameter SI.Diameter Dn=0.3568 "Nominal Diameter";
    Waterway.Reservoir Upstream(h_0 = 100.0, constantLevel=true)
                                                            annotation (
      Placement(transformation(origin={-50,0}, extent={{-10,-10},{10,10}})));
    Waterway.Reservoir Downstream(h_0 = 0.0, constantLevel=true)
                                                               annotation (
      Placement(transformation(origin={50,0}, extent={{10,-10},{-10,10}}, rotation = -0)));
    OpenHPL.Waterway.Pipe pipeExpanding(
    D_i=0.8*Dn,
    D_o=1.2*Dn,
    H=0,
    L=1000) annotation (Placement(transformation(origin={0,20}, extent={{-10,-10},{10,10}})));
    OpenHPL.Waterway.Pipe pipeConstant(
    D_i=Dn,
    D_o=Dn,
    H=0,
    L=1000) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    OpenHPL.Waterway.Pipe pipeContracting(
    D_i=1.2*Dn,
    D_o=0.8*Dn,
    H=0,
    L=1000) annotation (Placement(transformation(origin={0,-20}, extent={{-10,-10},{10,10}})));

equation
  connect(Upstream.o, pipeExpanding.i) annotation (Line(points={{-40,0},{-28,0},{-28,20},{-10,20}}, color={0,128,255}));
  connect(pipeExpanding.o, Downstream.o) annotation (Line(points={{10,20},{30,20},{30,0},{40,0}}, color={0,128,255}));
  connect(Upstream.o, pipeConstant.i) annotation (Line(points={{-40,0},{-10,0}}, color={0,128,255}));
  connect(pipeConstant.o, Downstream.o) annotation (Line(points={{10,0},{40,0}}, color={0,128,255}));
  connect(Upstream.o, pipeContracting.i) annotation (Line(points={{-40,0},{-28,0},{-28,-20},{-10,-20}}, color={0,128,255}));
  connect(pipeContracting.o, Downstream.o) annotation (Line(points={{10,-20},{30,-20},{30,0},{40,0}}, color={0,128,255}));
  annotation (
      experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.02));
end Pipes;
