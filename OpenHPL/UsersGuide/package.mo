within OpenHPL;
package UsersGuide "User's Guide Version 1.0.0"
  extends Modelica.Icons.Information;

  annotation (preferredView="info", DocumentationClass=true, Documentation(info="<html>
<h4>OpenHPL User's Guide</h4>
<p align=\"center\">
<img src=\"modelica://OpenHPL/Resources/Images/Library.png\" width=\"400\"/>
</p>
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
<p>
A more detailed description is presented in the following subsections of this User's Guide,
the <a href=\"modelica://OpenHPL/Resources/Documents/UsersGuide.pdf\">User's Guide PDF</a>
and the PhD thesis [Vytvytskyi2019].
</p>

<h5>User's Guide Contents</h5>
<ul>
<li><a href=\"modelica://OpenHPL.UsersGuide.Introduction\">Introduction</a> &mdash; Overview of OpenHPL capabilities</li>
<li><a href=\"modelica://OpenHPL.UsersGuide.Installation\">Installation</a> &mdash; Installation instructions for OpenModelica and OpenHPL</li>
<li><a href=\"modelica://OpenHPL.UsersGuide.OpenHPLElements\">OpenHPL Elements</a> &mdash; Detailed description of library components</li>
<li><a href=\"modelica://OpenHPL.UsersGuide.BasicExample\">Basic Example</a> &mdash; Step-by-step example for creating models</li>
<li><a href=\"modelica://OpenHPL.UsersGuide.ReleaseNotes\">Release Notes</a> &mdash; Version history and changes</li>
<li><a href=\"modelica://OpenHPL.UsersGuide.References\">References</a> &mdash; Citations and related publications</li>
</ul>

<h5>Acknowledgements</h5>
<p>
This work is supported by the <strong>Norwegian Research Council</strong> under the project <em>\"Hydropower Systems Design and Analysis\"</em> (HydroCen Grant No. 257588).
</p>
</html>"));
end UsersGuide;
