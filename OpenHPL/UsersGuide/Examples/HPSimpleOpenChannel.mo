within OpenHPL.UsersGuide.Examples;
class HPSimpleOpenChannel "HPSimple_OpenChannel example model"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4>HPSimple_OpenChannel</h4>
<p>
In this model of the hydropower system, the simplified models are used for conduits and turbine modelling. The generator 
is not included in the model. The simple <em>Pipe</em> unit is used to represent the penstock and intake race. The 
discharge race is an open channel here, and the <em>OpenChannel</em> unit is used for modelling. The simple 
<em>Turbine</em> unit is used to represent the turbine. The <em>Reservoir</em> unit is used to represent the reservoir 
and the tailwater (here, this unit uses a simple model of the reservoir that only depends on the water depth in the 
reservoir).
</p>
</html>", revisions=""));
end HPSimpleOpenChannel;
