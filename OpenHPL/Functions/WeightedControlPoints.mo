within OpenHPL.Functions;

function WeightedControlPoints
extends Modelica.Icons.Function;
  /*
  */
  input Real opening;
  input OpenHPL.Types.HillChart hc "Hill chart";
  output Real data[hc.nPoints, hc.nDim];
protected
  Real td[hc.nPoints, hc.nDim];
  Real beta;
  Integer i;
  
algorithm
//if (opening >= hc.opening[1] and opening <= hc.opening[hc.nPoints]) then
    i:=1;
    while (i < hc.nCurves ) loop
      if (opening < hc.opening[i]) then
// Defined as closed guide vanes
        for j in 1:hc.nPoints loop
          td[j,1] := hc.data[1, j, 1];
          td[j,2] :=  0.0;
// Torque set to zero. Must be corrected in the future
          td[j,3] :=  0.0 ;
        end for;
        break;
     elseif ( (hc.opening[i] <= opening) and (opening <= hc.opening[i+1]) ) then
        beta:=(opening-hc.opening[i])/(hc.opening[i+1]-hc.opening[i]);
        for j in 1:hc.nPoints loop
          for k in 1:hc.nDim loop
            td[j,k] := (1.-beta)*hc.data[i, j, k]+ beta*hc.data[i+1, j, k] ;
          end for;
        end for;
         break;
      else
        i:=i+1;
      end if;
    end while;
    
  data:=td;
annotation(
    Documentation(info = "<html><head></head><body>Compute an intermediate turbine characteristics based on linear interpolation of the two closest curves. The turbine opening is used as argument for finding the closest curves. Assumes that the opening in the HillChart data is monotonously increasing. If data at small opening is missing, the flow and speed data for the first curve is used and the torque is set to zero.</body></html>"));


end WeightedControlPoints;
