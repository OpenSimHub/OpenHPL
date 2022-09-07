within OpenHPL.UsersGuide.ReleaseNotes;
class v200 "Version 2.0.0 (2022-09-07)"
   extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>
<h4>What&apos;s Changed</h4>
<p>
This new version of <code><strong>OpenHPL</strong></code> is a 
<strong>non-backward compatible</strong> release based on the 
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/releases/tag/v4.0.0\">
Modelica Standard Library version 4.0.0</a> which contains a series of improvements and bugfixes.
</p>
<p>
This release is non-backward compatible to earlier versions of OpenHPL.
This means it contains changes to the names of classes, parameters, variables, connectors, and more.
Users will have to manually edit their existing models that were based on older versions of OpenHPL.
</p>
<h5>Highlights</h5>
<ul>
<li>Changed the license to the
<a href=\"modelica://OpenHPL/Resources/LICENSE\">Mozilla Public License, v. 2.0</a> .</li>
<li>More waterway components like draft tube and different bend type types.</li>
<li>The different fitting types can now be selected via a drop-down list.</li>
<li>The mechanics of turbine and generator are now modelled by using rotational mechanic components
allowing for proper physical connections with torque feedback.</li>
<li>New <a href=\"modelica://OpenHPL.ElectroMech.PowerSystem\">PowerSystem</a> package for 
simulating active power flow using rotational mechanic equivalents.</li>
<li>Cleaner look by using 2D-icons</li>
<li>Examples that use the <a href=\"https://openipsl.org\">OpenIPSL</a> have been placed in a
separate sub-package and are using 
<a href=\"https://github.com/OpenIPSL/OpenIPSL/releases/tag/v3.0.1\">OpenIPSL 3.0.1</a>.</li>
</ul>
<h5>Full Changelog</h5>
<p><code><a href=\"https://github.com/OpenSimHub/OpenHPL/compare/v1.0.0...v2.0.0\">v1.0.0...v2.0.0</a></code></p>
</html>"));
end v200;
