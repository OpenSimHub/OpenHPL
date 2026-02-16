within OpenHPL;
package UsersGuide "User's Guide"
  extends Modelica.Icons.Information;

  annotation (preferredView="info", DocumentationClass=true, Documentation(info="<html>
<blockquote style=\"background-color: #e8f4f8; border-left: 4px solid #0078d7; padding: 10px; margin: 10px 0;\">
<strong>Documentation Structure:</strong> This User's Guide provides high-level information about the library,
installation, examples, and guidance for model selection. <strong>Detailed technical documentation (equations,
parameters, implementation details) is provided directly in each model class.</strong> Navigate to the specific
model you're interested in (e.g., <a href=\"modelica://OpenHPL.Waterway.Pipe\">Pipe</a>,
<a href=\"modelica://OpenHPL.ElectroMech.Turbines.Turbine\">Turbine</a>) to see complete technical documentation.
</blockquote>

<p>
<strong>OpenHPL</strong> is an open-source hydropower library that consists of hydropower unit models
and is encoded in Modelica. Modelica is a multi-domain as well as a component-oriented
modelling language that is suitable for complex system modelling. In order to develop
the library, OpenModelica has been used as an open-source Modelica-based modelling
and simulation environment.
</p>
<p>
This hydropower library, <strong>OpenHPL</strong>, provides the capability for the modelling of hydro-
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
based on the turbine's nominal operating values.
</li>
<li>The capability for multiphysics connections and work with other libraries is ensured,
e.g., connecting with the Open-Instance Power System Library <strong>OpenIPSL</strong> makes it
possible to model the electrical part for the hydropower system.
</li>
</ol>

<h5>Acknowledgements</h5>
<p>
The very first version 1.0.0 of this library was created as part of the PhD thesis <a href=\"modelica://OpenHPL.UsersGuide.References\">[Vytvytskyi2019]</a>,
which was supported by the <strong>Norwegian Research Council</strong> under the project <em>\"Hydropower Systems Design and Analysis\"</em> (HydroCen Grant No. 257588).
</p>
</html>"));
end UsersGuide;
