within OpenHPL;
package UsersGuide "User's Guide"
  extends Modelica.Icons.Information;

  annotation (DocumentationClass=true, Documentation(info="<html>
<p>
OpenHPL is an open-source hydropower library that consists of hydropower unit models
and is encoded in Modelica. Modelica is a multi-domain as well as a component-oriented
modelling language that is suitable for complex system modelling. In order to develop
the library, OpenModelica has been used as an open-source Modelica-based modelling
and simulation environment.
</p>
<p>
This hydropower library, OpenHPL, provides the capability for the modelling of hydro-
power systems of different complexity. The library includes the following units:
</p>
<ol>
<li>Various waterway units are modelled based on the mass and momentum balances,
i.e., reservoirs, conduits, surge tank, fittings. A modern method for solving more
detailed models (PDEs) is implemented in the library, and enables the modelling of
the waterway with elastic walls and compressible water as well as open channel.
</li>
<li>A hydrology model has been implemented and makes it possible to simulate the
water inflow to the reservoirs.
</li>
<li>Mechanistic models, as well as simple look-up table turbine models are implemented
for the Francis and Pelton turbine types. The Francis turbine model also includes
a turbine design algorithm that gives all of the needed parameters for the model,
based on the turbine’s nominal operating values.
</li>
<li>The capability for multiphysics connections and work with other libraries is ensured,
e.g., connecting with the Open-Instance Power System Library OpenIPSL makes it
possible to model the electrical part for the hydropower system.
</li>
</ol>
<p>
A detailed description of each hydropower unit and their uses are presented below in 
the <a href=\"modelica://OpenHPL/Resources/Documents/UsersGuide.pdf\">User's Guide PDF</a>
and <a href=\"modelica://OpenHPL.UsersGuide.References\">[Vytvytskyi2019]</a>.
</p>
</html>"));
end UsersGuide;
