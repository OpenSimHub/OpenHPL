within OpenHPL.UsersGuide.Examples;
class HPSimpleGenerator "HPSimple_generator example model"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4>HPSimple_generator</h4>
<p>
In this model of the hydropower system, the simplified models are used for conduits, turbine, and generator modelling. 
The simple <em>Pipe</em> unit is used to represent the penstock, intake and discharge races. The simple <em>Turbine</em> 
unit is used to represent the turbine. The <em>SimpleGen</em> unit is used to represent the generator. The 
<em>Reservoir</em> unit is used to represent the reservoir and tailwater (here, this unit uses a simple model of the 
reservoir that only depends on the water depth in the reservoir). Data from the Sundsbarm hydropower plant is used for 
this example model.
</p>
</html>", revisions=""));
end HPSimpleGenerator;
