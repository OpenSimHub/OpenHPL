within OpenHPL.Examples;
model VolumeFlowSource "Example demonstrating the use of VolumeFlowSource"
  extends Modelica.Icons.Example;
  OpenHPL.Waterway.Reservoir tail1         annotation (Placement(transformation(extent={{60,30},{40,50}})));
  inner OpenHPL.Data data annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  OpenHPL.Waterway.VolumeFlowSource volumeFlowConstant annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
  Waterway.Pipe pipe1(H=0) annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Waterway.Pipe pipe2(H=0) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  OpenHPL.Waterway.Reservoir tail2         annotation (Placement(transformation(extent={{60,-10},{40,10}})));
  OpenHPL.Waterway.VolumeFlowSource volumeFlowInput(useInput=true, useFilter=false) annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
  Modelica.Blocks.Sources.Sine sine(freqHz=0.01)                 annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.CombiTimeTable logdata(table=[1,0.256342739; 2,0.245221436; 3,0.266113698; 4,0.249561667; 5,0.525063097; 6,0.479064316; 7,0.494991362; 8,0.489708632; 9,0.50391084; 10,0.492354929; 11,0.509279788; 12,0.495274216; 13,0.493877858; 14,0.520679474; 15,0.499932915; 16,0.494227827; 17,0.472558141; 18,0.441845328; 19,0.398698032; 20,0.369865984; 21,0.341512531; 22,0.317958236; 23,0.300121665; 24,0.283421665; 25,0.271103382; 26,0.29000932; 27,0.276437521; 28,0.279719085; 29,0.273819894;
        30,0.530646265; 31,0.494690746; 32,0.668753743; 33,0.748319328; 34,1.156479597; 35,1.622769237; 36,1.455329537; 37,1.440503478; 38,1.388660312; 39,1.321571827; 40,1.428969026; 41,1.335716724; 42,1.240077496; 43,1.147016048; 44,1.046641827; 45,0.957466781; 46,0.877434254; 47,0.760209978; 48,0.685476542; 49,0.611937046; 50,0.5434497; 51,0.486470848; 52,0.437200874; 53,0.387043357; 54,0.346913666; 55,0.321531206; 56,0.3025949; 57,0.289946347; 58,0.76049149; 59,1.301532745; 60,1.66047287; 61,
        1.468578339; 62,1.445258141; 63,1.381029367; 64,1.308333635; 65,1.429936647; 66,1.324193954; 67,1.215524554; 68,1.132795691; 69,1.039966226; 70,0.957139969; 71,0.881121516; 72,0.764806509; 73,0.679720461; 74,1.153712869; 75,1.617045045; 76,1.342065096; 77,1.21108222; 78,1.097126365; 79,0.956687152; 80,0.846820831; 81,0.726776063; 82,0.637088716; 83,0.566960931; 84,0; 85,0.081746899; 86,0.287258357; 87,0.440648884; 88,0.623197138; 89,0.745818675; 90,0.877141893; 91,1.14376235; 92,1.091307402;
        93,1.166081309; 94,1.204966307; 95,1.155335188; 96,1.090149403; 97,1.023901701; 98,0.955312788; 99,0.895717919; 100,0.781589091; 101,0.711237729; 102,0.642216742; 103,0.592425168; 104,0.53075856; 105,0.470919639; 106,0.424907953; 107,0.379154414; 108,0.341206133; 109,0.313439339; 110,0.291419089; 111,0.282484144], extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
                                                                     annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Waterway.Pipe pipe3(H=0) annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Waterway.Reservoir         tail3         annotation (Placement(transformation(extent={{60,-50},{40,-30}})));
  Waterway.VolumeFlowSource volumeFlowFiltered(useInput=true, useFilter=true) annotation (Placement(transformation(extent={{-48,-50},{-28,-30}})));
equation
  connect(pipe1.o, tail1.o) annotation (Line(points={{10,40},{40,40}}, color={0,128,255}));
  connect(volumeFlowConstant.o, pipe1.i) annotation (Line(points={{-30,40},{-10,40}}, color={0,128,255}));
  connect(volumeFlowInput.o, pipe2.i) annotation (Line(points={{-28,0},{-10,0}}, color={0,128,255}));
  connect(pipe2.o, tail2.o) annotation (Line(points={{10,0},{40,0}}, color={0,128,255}));
  connect(sine.y, volumeFlowInput.outFlow) annotation (Line(points={{-59,0},{-50,0}}, color={0,0,127}));
  connect(volumeFlowFiltered.o, pipe3.i) annotation (Line(points={{-28,-40},{-10,-40}}, color={0,128,255}));
  connect(pipe3.o,tail3. o) annotation (Line(points={{10,-40},{40,-40}},
                                                                     color={0,128,255}));
  connect(volumeFlowFiltered.outFlow, logdata.y[1]) annotation (Line(points={{-50,-40},{-59,-40}}, color={0,0,127}));
  annotation (experiment(StopTime=120));
end VolumeFlowSource;
