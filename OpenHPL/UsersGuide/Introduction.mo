within OpenHPL.UsersGuide;
class Introduction "Introduction to OpenHPL"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<h4>Introduction</h4>
<p>
<strong>OpenHPL</strong> is an open-source hydropower library that consists of hydropower unit models 
and is encoded in Modelica. Modelica is a multi-domain as well as a component-oriented modelling 
language that is suitable for complex system modelling. In order to develop the library, OpenModelica 
has been used as an open-source Modelica-based modelling and simulation environment.
</p>
<p>
This hydropower library, <strong>OpenHPL</strong>, provides the capability for the modelling of 
hydropower systems of different complexity. The library includes the following units:
</p>
<ol>
<li>Various waterway units are modelled based on the mass and momentum balances, i.e., reservoirs, 
conduits, surge tank, fittings. A modern method for solving more detailed models (PDEs) is implemented 
in the library, and enables the modelling of the waterway with elastic walls and compressible water as 
well as open channel.</li>
<li>A hydrology model has been implemented and makes it possible to simulate the water inflow to the 
reservoirs.</li>
<li>Mechanistic models, as well as simple look-up table turbine models are implemented for the Francis 
and Pelton turbine types. The Francis turbine model also includes a turbine design algorithm that gives 
all of the needed parameters for the model, based on the turbine's nominal operating values.</li>
<li>The capability for multiphysics connections and work with other libraries is ensured, e.g., connecting 
with the Open-Instance Power System Library <strong>OpenIPSL</strong> makes it possible to model the 
electrical part for the hydropower system.</li>
</ol>
<p>
A detailed description of each hydropower unit and their uses are presented in the following sections of 
this user guide.
</p>
</html>"));
end Introduction;
