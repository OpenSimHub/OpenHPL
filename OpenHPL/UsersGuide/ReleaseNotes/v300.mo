within OpenHPL.UsersGuide.ReleaseNotes;
class v300 "Version 3.0.0 (2026-02-02)"
   extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>
<h4>What&apos;s Changed</h4>
<p>
This new version of <code><strong>OpenHPL</strong></code> is a
<strong>non-backwards compatible</strong> release based on the
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/releases/tag/v4.0.0\">
Modelica Standard Library version 4.0.0</a> which contains a series of improvements and bug fixes.
</p>
<p>
This releases is non-backwards compatible with earlier versions of OpenHPL.
This means it contains changes to the names of classes, parameters, variables, connectors, and more.
Users will have to manually edit their existing models that were based on older versions of OpenHPL.
</p>
<h5>💥 Breaking Changes</h5>
  <ul>
    <li>Merge or consolidate TurbineContact and TurbineContacts2 <a href=\"https://github.com/USN-OpenHPL/OpenHPL/pull/54\">#54</a></li>
    <li>Remove calculated values from Interfaces <a href=\"https://github.com/USN-OpenHPL/OpenHPL/pull/66\">#66</a></li>
    <li>Correct the speed in and outputs of the base class for turbine, generator and grid <a href=\"https://github.com/USN-OpenHPL/OpenHPL/pull/71\">#71</a></li>
  </ul>
<h5>🚀 Features</h5>
  <ul>
     <li>Replaces image with improved SVG version <a href=\"https://github.com/USN-OpenHPL/OpenHPL/pull/65\">#65</a></li>
     <li>Add a valve model <a href=\"https://github.com/USN-OpenHPL/OpenHPL/pull/59\">#59</a></li>
     <li>Implementation of a Tainter Gate <a href=\"https://github.com/USN-OpenHPL/OpenHPL/pull/60\">#60</a></li>
     <li>BaseValve and Turbine update to avoid p_a=0 issues and non-linear closing law <a href=\"https://github.com/USN-OpenHPL/OpenHPL/pull/70\">#70</a></li>
     <li>Change to new defaults for more practical use <a href=\"https://github.com/USN-OpenHPL/OpenHPL/pull/68\">#68</a></li>
     <li>Update handling of diverging or converging pipe <a href=\"https://github.com/USN-OpenHPL/OpenHPL/pull/69\">#69</a></li>
  </ul>

<h5>🐛 Bug Fixes</h5>
  <ul>
   <li>Protect Turbine control signal against division by zero error <a href=\"https://github.com/USN-OpenHPL/OpenHPL/pull/56\">#56</a></li>
  </ul>

<h5>New Contributors</h5>
  <ul>
     <li><a href=\"https://github.com/boerrebj\">@boerrebj</a> in <a href=\"https://github.com/USN-OpenHPL/OpenHPL/pull/54\">#54</a></li>
     <li><a href=\"https://github.com/pandeysudan1\">@pandeysudan1</a> in <a href=\"https://github.com/USN-OpenHPL/OpenHPL/pull/66\">#66</a></li>
 </ul>
 <p><strong>Full Changelog:</strong> <a href=\"https://github.com/USN-OpenHPL/OpenHPL/compare/v2.0.1...v3.0.0\">v2.0.1...v3.0.0</a></p>
</html>"));
end v300;
