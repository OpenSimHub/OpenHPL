within OpenHPL.UsersGuide.OpenHPLElements.WaterwayModels;
class Fitting "Description of Fitting unit"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4>Fitting</h4>
<p>
There are various possibilities of the fittings for the pipes with different diameters as well as the existence 
of orifices in the pipe. In this unit <code>Fitting</code>, the pressure drop due to these constrictions is 
defined using the pressure drop equation and function <code>FittingPhi</code>. The <code>Fitting</code> unit uses 
the <code>ContactPort</code> connector model in order to have inlet and outlet connectors and the possibility to 
define pressure drop between those connectors. Then, this unit can be connected to the other waterway units.
</p>

<p>
When the <code>Fitting</code> unit is in use, the user can postulate the specific type of fitting that is of 
interest and required based on the geometry parameters for this fitting.
</p>
</html>"));
end Fitting;
