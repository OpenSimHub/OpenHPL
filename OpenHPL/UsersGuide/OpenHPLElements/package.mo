within OpenHPL.UsersGuide;
package OpenHPLElements "OpenHPL Library Elements"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<h4>OpenHPL Elements</h4>
<p>
An overview of each element of the hydropower library <strong>OpenHPL</strong> is provided in this section. 
A screenshot of <strong>OpenHPL</strong> in OpenModelica is shown in the figure below.
</p>
<p align=\"center\">
  <img src=\"modelica://OpenHPL/Resources/Images/Library.png\" alt=\"OpenModelica screenshot\" width=\"700\"/>
</p>
<p><em>Figure: Screenshot of OpenModelica with the hydropower library.</em></p>

<h5>Library Structure</h5>
<p>
The library is divided into various packages:
</p>
<dl>
<dt><code>Copyright</code></dt>
<dd>A documentation class that provides a reference to the license for this library.</dd>

<dt><code>UsersGuide</code></dt>
<dd>A documentation class that provides the user's guide of this library.</dd>

<dt><code>Data</code></dt>
<dd>A record that determines the common data set for this library. It is possible to insert this class 
into models and use the common data set for the whole model.</dd>

<dt><code>Examples</code></dt>
<dd>A package that provides various examples of using the library for hydropower systems as well as 
examples of using <strong>OpenHPL</strong> together with power system library &mdash; <strong>OpenIPSL</strong>.</dd>

<dt><code>Waterway</code></dt>
<dd>A package that consists of various unit models for the waterway of the hydropower system, such as 
reservoirs, conduits, surge tank, pipe fittings, etc.</dd>

<dt><code>ElectroMech</code></dt>
<dd>A package that provides the electro-mechanical components of the hydropower system and consists of 
two main sub-packages:
  <dl>
    <dt><code>Turbines</code></dt>
    <dd>with various turbine unit models</dd>
    <dt><code>Generators</code></dt>
    <dd>with simplified models of a generator</dd>
  </dl>
</dd>

<dt><code>Controllers</code></dt>
<dd>A package that holds a simple model for a governor of the hydropower system.</dd>

<dt><code>Interfaces</code></dt>
<dd>A package of gives connector interfaces for the library components.</dd>

<dt><code>Functions</code></dt>
<dd>A package of functions that consists of three sub-packages:
  <ul>
    <li><code>Fitting</code> &mdash; Functions for calculation of pressure drop for various pipe fittings.</li>
    <li><code>DarcyFriction</code> &mdash; Functions to calculate the friction term in the pipe.</li>
    <li><code>KP07</code> &mdash; Functions for PDEs using Kurganov-Petrova (KP) scheme.</li>
  </ul>
</dd>

<dt><code>Icons</code></dt>
<dd>Package of icons used in the library.</dd>

<dt><code>Types</code></dt>
<dd>Package of types used in the library.</dd>

<dt><code>Tests</code></dt>
<dd>Package of various testing models. Not guaranteed to work and meant for development only.</dd>
</dl>

<p>
Below, a detailed description of each unit model of the <strong>OpenHPL</strong> is provided.
</p>
</html>"));
end OpenHPLElements;
