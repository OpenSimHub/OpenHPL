within OpenHPL.Examples;
model DetailedGenFrancis
  extends SimpleGenFrancis(redeclare Waterway.PenstockKP penstock);
  annotation (experiment(StopTime=1000));
end DetailedGenFrancis;
