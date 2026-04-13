within OpenHPL.Interfaces;
record Elevation "Overconstrained elevation record for connector balance"
  SI.Position z "Elevation at connection point";
  function equalityConstraint
    input Elevation e1;
    input Elevation e2;
    output Real residue[0] "No residual equations — elevation is propagated via spanning tree";
  algorithm
  end equalityConstraint;
end Elevation;
