within OpenHPL.UsersGuide.ReleaseNotes;
class v400 "Version 4.0.0 (2026-08-24)"
   extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>
<h4>What&apos;s Changed</h4>
<p>This new version of <strong><code>OpenHPL</code></strong> is a <strong>non-backwards compatible</strong> release based on the <a href=\"https://github.com/modelica/ModelicaStandardLibrary/releases/tag/v4.0.0\">Modelica Standard Library version 4.0.0</a> which contains a series of improvements and bug fixes. </p>
<p>This releases is non-backwards compatible with earlier versions of OpenHPL. This means it contains changes to the names of classes, parameters, variables, connectors, and more. A conversion-script is provided that takes care of some of the changes but not all. Users will have to check their existing models that were based on older versions of OpenHPL. </p>
<h4>💥 BREAKING CHANGES</h4>
<ul>
<li>refactor!: Consolidates RunOff models with flexible input by <a href=\"https://github.com/dietmarw\">@dietmarw</a> in <a href=\"https://github.com/OpenSimHub/OpenHPL/pull/88\">#88</a></li>
<li>refactor!: Rename pipe <span style=\"font-family: monospace;\">vertical</span> parameter to <span style=\"font-family: monospace;\">slanted</span> by <a href=\"https://github.com/dietmarw\">@dietmarw</a> in <a href=\"https://github.com/OpenSimHub/OpenHPL/pull/92\">#92</a></li>
<li>refactor!: Refactoring the drafttube model and removing the superfluous theta parameter. by <a href=\"https://github.com/dietmarw\">@dietmarw</a> in <a href=\"https://github.com/OpenSimHub/OpenHPL/pull/96\">#96</a></li>
</ul>
<h4>🚀 Features</h4>
<ul>
<li>feat: Adds pipe friction method selection by <a href=\"https://github.com/dietmarw\">@dietmarw</a> in <a href=\"https://github.com/OpenSimHub/OpenHPL/pull/75\">#75</a></li>
<li>feat: Enable LaTeX rendering for OpenModelica by <a href=\"https://github.com/dietmarw\">@dietmarw</a> in <a href=\"https://github.com/OpenSimHub/OpenHPL/pull/77\">#77</a></li>
<li>feat: Convert the old LaTeX based User&apos;s Guide into Modelica documentation by <a href=\"https://github.com/dietmarw\">@dietmarw</a> in <a href=\"https://github.com/OpenSimHub/OpenHPL/pull/79\">#79</a></li>
<li>feat: Adds variable efficiency table to Turbine model by <a href=\"https://github.com/dietmarw\">@dietmarw</a> in <a href=\"https://github.com/OpenSimHub/OpenHPL/pull/81\">#81</a></li>
<li>feat: Added partial base class TorqueEquation for use with turbine models by <a href=\"https://github.com/boerrebj\">@boerrebj</a> in <a href=\"https://github.com/OpenSimHub/OpenHPL/pull/78\">#78</a></li>
<li>feat: Adds creek intake to SurgeTank model by <a href=\"https://github.com/dietmarw\">@dietmarw</a> in <a href=\"https://github.com/OpenSimHub/OpenHPL/pull/84\">#84</a></li>
<li>feat: Add automatic elevation propagation by <a href=\"https://github.com/dietmarw\">@dietmarw</a> in <a href=\"https://github.com/OpenSimHub/OpenHPL/pull/89\">#89</a></li>
<li>feat: Have a common FrictionSpec block for choosing the Friction method by <a href=\"https://github.com/dietmarw\">@dietmarw</a> in <a href=\"https://github.com/OpenSimHub/OpenHPL/pull/91\">#91</a></li>
<li>feat: Add elevation display to surge tank and reservoir models by <a href=\"https://github.com/dietmarw\">@dietmarw</a> in <a href=\"https://github.com/OpenSimHub/OpenHPL/pull/93\">#93</a></li>
<li>feat: New version of OpenChannel by <a href=\"https://github.com/dietmarw\">@dietmarw</a> in <a href=\"https://github.com/OpenSimHub/OpenHPL/pull/85\">#85</a></li>
<li>feat: add an empirical turbine model by <a href=\"https://github.com/boerrebj\">@boerrebj</a> in <a href=\"https://github.com/OpenSimHub/OpenHPL/pull/83\">#83</a></li>
</ul>
<h4>🐛 Bug Fixes</h4>
<ul>
<li>fix: Changes initial system frequency to unit speed by <a href=\"https://github.com/dietmarw\">@dietmarw</a> in <a href=\"https://github.com/OpenSimHub/OpenHPL/pull/76\">#76</a></li>
<li>fix: pipe initialization by <a href=\"https://github.com/boerrebj\">@boerrebj</a> in <a href=\"https://github.com/OpenSimHub/OpenHPL/pull/80\">#80</a></li>
<li>fix: Fixes Pipe initialisation parameter name by <a href=\"https://github.com/dietmarw\">@dietmarw</a> in <a href=\"https://github.com/OpenSimHub/OpenHPL/pull/90\">#90</a></li>
<li>fix: Improved robust handling of conical pipes by <a href=\"https://github.com/boerrebj\">@boerrebj</a> in <a href=\"https://github.com/OpenSimHub/OpenHPL/pull/94\">#94</a></li>
</ul>
<h5>Full Changelog</h5>
<p><code><a href=\"https://github.com/OpenSimHub/OpenHPL/compare/v3.0.1...v4.0.0\">v3.0.1...v4.0.0</a></code></p>
</html>"));
end v400;
