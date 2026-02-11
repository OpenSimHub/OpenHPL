within OpenHPL.UsersGuide.Examples;
class HPSimpleFrancisIPSLGenInfBus "HPSimple_Francis_IPSLGenInfBus example model"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4>HPSimple_Francis_IPSLGenInfBus</h4>
<p>
Here, the <em>HPDetailed_Francis</em> example model (uses the <em>PenstockKP</em> and <em>Francis</em> units) is extended 
by synergy with the <em>OpenIPSL</em> for generator and power system (including infinite bus) modelling. The 
<em>Governor</em> unit from the <em>OpenHPL</em> is also used here. The penstock is modelled with the more detailed 
<em>PenstockKP</em> unit. The turbine is modelled with the more detailed <em>Francis</em> unit. The simple <em>Pipe</em> 
unit is used to represent the intake and discharge races. The <em>Reservoir</em> unit is used to represent the reservoir 
and the tailwater (here, this unit uses a simple model of the reservoir that only depends on the water depth in the 
reservoir).
</p>
</html>", revisions=""));
end HPSimpleFrancisIPSLGenInfBus;
