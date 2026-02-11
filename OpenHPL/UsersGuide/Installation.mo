within OpenHPL.UsersGuide;
class Installation "Installation instructions"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<h4>Installation</h4>
<p>
<strong>OpenHPL</strong> can be opened either in open-source 
<a href=\"https://openmodelica.org\">OpenModelica</a> or commercial 
<a href=\"https://www.3ds.com/products-services/catia/products/dymola\">Dymola</a> modelling and 
simulation environments, which are based on the Modelica language. Here, OpenModelica is emphasized 
due to free availability.
</p>

<h5>Installing OpenModelica</h5>
<p>
To install OpenModelica:
</p>
<ul>
<li>For Windows users, follow the instructions at 
<a href=\"https://openmodelica.org/download/download-windows\">https://openmodelica.org/download/download-windows</a></li>
<li>For other operating systems, find the installation instructions at 
<a href=\"https://openmodelica.org\">https://openmodelica.org</a> in the \"Download\" tab</li>
</ul>

<h5>Modelica and OpenModelica Tutorials</h5>
<p>
Some tutorials exist for:
</p>
<ul>
<li>Modelica at <a href=\"http://book.xogeny.com\">http://book.xogeny.com</a></li>
<li>OpenModelica at <a href=\"https://goo.gl/76274H\">https://goo.gl/76274H</a></li>
</ul>

<h5>Installing OpenHPL</h5>
<p>
The <strong>OpenHPL</strong> can be found at 
<a href=\"https://openhpl.opensimhub.org\">https://openhpl.opensimhub.org</a>. 
To install this library, follow the instructions at the project homepage.
</p>

<h5>Scripting API Integration</h5>
<p>
In addition, Modelica models in OpenModelica can be simulated within a scripting language and further 
analysed using the analysis tools in the scripting language:
</p>
<ul>
<li><a href=\"https://www.python.org\">Python</a> via the 
<a href=\"https://www.openmodelica.org/doc/OpenModelicaUsersGuide/latest/ompython.html\">OMPython API</a></li>
<li><a href=\"https://julialang.org\">Julia</a> via the 
<a href=\"https://openmodelica.org/doc/OpenModelicaUsersGuide/latest/omjulia.html\">OMJulia API</a></li>
</ul>
<p>
The installation instructions for both these APIs can be found in the links provided above.
</p>
</html>"));
end Installation;
