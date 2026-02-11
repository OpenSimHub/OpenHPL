within OpenHPL.UsersGuide.Examples;
class HPDetailed "HPDetailed example model"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4>HPDetailed</h4>
<p>
In this model of the hydropower system, the simplified models are used for conduits and turbine modelling, except for 
the penstock that is modelled with the more detailed <em>PenstockKP</em> unit. The generator is not included in the model. 
The simple <em>Pipe</em> unit is used to represent the intake and discharge races. The simple <em>Turbine</em> unit is 
used to represent the turbine. The <em>Reservoir</em> unit is used to represent the reservoir and the tailwater (here, 
this unit uses a simple model of the reservoir that only depends on the water depth in the reservoir). Data from the 
Sundsbarm hydropower plant is used for this example model.
</p>
</html>", revisions=""));
end HPDetailed;
