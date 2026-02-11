within OpenHPL.UsersGuide.Examples;
class HPSimpleFrancis "HPSimple_Francis example model"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4>HPSimple_Francis</h4>
<p>
In this model of the hydropower system, the simplified model is used for conduits modelling. The turbine and the generator 
are modelled with more detailed <em>Francis</em> and <em>SynchGen</em> units, respectively. The simple <em>Pipe</em> 
unit is used to represent the penstock, intake and discharge races. The <em>Reservoir</em> unit is used to represent the 
reservoir and the tailwater (here, this unit uses a simple model of the reservoir that only depends on the water depth 
in the reservoir). Data from the Sundsbarm hydropower plant is used for this example model.
</p>
</html>", revisions=""));
end HPSimpleFrancis;
