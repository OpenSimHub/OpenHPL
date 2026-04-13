within OpenHPL.Examples.WithOpenIPSL;
model DetailedGen
  extends SimpleGen(       redeclare Waterway.PenstockKP penstock(
      vertical=true,
      H=428.5,
      D_i=3), data(SteadyState=false));
  annotation (experiment(StopTime=2000));
end DetailedGen;
