within OpenHPL.Examples.WithOpenIPSL;
model DetailedGenFrancis
  extends SimpleGenFrancis(redeclare Waterway.PenstockKP penstock(
      vertical=true,
      H=428.5,
      D_i=3), data(SteadyState=false));
  annotation (experiment(StopTime=2000));
end DetailedGenFrancis;
