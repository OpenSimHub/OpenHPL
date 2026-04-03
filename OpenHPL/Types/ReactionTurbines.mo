within OpenHPL.Types;

record ReactionTurbines "Collection of empirical turbine characteristics for use together with the EmpiricalTurbine model"
  extends Modelica.Icons.Record;
  protected
      parameter Real oA[5]={0.10,0.25,0.50,0.75,1.00};
      parameter Real cP1[5,4,3]={{{ 0.00,0.27,0.45 },{ 0.58,0.33,0.42 },{ 1.04,0.16,0.11 },{ 1.43,-0.13,-0.42 }},{{ 0.00,0.64,1.17 },{ 0.70,0.74,1.04 },{ 1.13,0.31,0.13 },{ 1.43,-0.17,-0.50 }},{{ 0.00,1.25,2.27 },{ 0.90,1.30,1.71 },{ 1.29,0.53,-0.05 },{ 1.43,-0.18,-0.52 }},{{ 0.00,1.71,2.95 },{ 1.05,1.71,1.99 },{ 1.31,0.63,-0.17 },{ 1.44,-0.16,-0.53 }},{{ 0.00,2.10,3.41 },{ 1.15,1.98,2.04 },{ 1.31,0.76,-0.18 },{ 1.45,-0.13,-0.54 }}};
   
  	parameter Real cP2[5,4,3]={{{ 0.00,0.18,0.26 },{ 0.41,0.10,0.17 },{ 1.04,0.31,0.25 },{ 1.32,-0.04,-0.21 }},{{ 0.00,0.44,0.73 },{ 0.43,0.37,0.67 },{ 1.27,0.55,0.29 },{ 1.38,0.00,-0.19 }},{{ 0.00,0.91,1.55 },{ 0.59,0.89,1.33 },{ 1.57,0.79,0.19 },{ 1.51,0.00,-0.29 }},{{ 0.00,1.30,2.11 },{ 0.78,1.33,1.77 },{ 1.72,0.92,-0.12 },{ 1.58,0.00,-0.28 }},{{ 0.00,1.57,2.41 },{ 0.92,1.63,1.91 },{ 1.82,1.02,-0.30 },{ 1.63,0.00,-0.35 }}};
     public
     TurbineCharacteristics turbine1(nCurves = 5, nDim = 3, nPoints = 4, opening = oA, data = cPoints) "N_QE=0.07";
     TurbineCharacteristics turbine2(nCurves = 5, nDim = 3, nPoints = 4, opening = oA, data = cPoints) "N_EQ=0.20";
end ReactionTurbines;
