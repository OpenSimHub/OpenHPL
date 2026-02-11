within OpenHPL.Types;

record TurbineData
 extends Modelica.Icons.Record;
      //
      parameter SI.Length Dn "Nominal diameter";
      parameter SI.Frequency nrps "Best efficiency rotational speed";
      parameter SI.Length Hbep "Best efficiency head";
      parameter SI.VolumeFlowRate Qbep "Best efficiency discharge";
      parameter SI.Torque Tbep "Best efficiency shaft torque";
      parameter Real openingBep "Best efficiency opening";
      parameter SI.Acceleration g;
      parameter SI.Density rho;
      
      annotation(
        Documentation(info = "<html><head></head><body>Data record with key turbine information. Used together with the normalized turbine characteristics to calculate physical values.<div><br></div><table><thead>
<tr><th>Variable</th><th>Description</th></tr>
</thead><tbody>
<tr><td>Dn [m]</td><td>Nominal diameter</td></tr>
<tr><td>nrps [1/s]</td><td>Best efficiency rotational speed</td></tr>
<tr><td>Hbep [m]</td><td>Best efficiency head</td></tr>
<tr><td>Qbep [m³/s]</td><td>Best efficiency discharge</td></tr>
<tr><td>Tbep [Nm]</td><td>Best efficiency torque</td></tr>
<tr><td>openingBep [-]</td><td>Normalize best efficiency opening (must be between 0 and 1)</td></tr>
</tbody>
</table></body></html>"));
   
end TurbineData;
