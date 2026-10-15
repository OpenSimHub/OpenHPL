package OpenHPL "Open-source hydropower library"
  extends Icons.Logo;
  import C = Modelica.Constants;
  import Modelica.Units.SI;

  annotation (
    version="4.0.0",
    versionDate="2026-08-24",
    conversion(from(version={"3.0.0","3.0.1"}, script="modelica://OpenHPL/Resources/Scripts/ConvertOpenHPL_from_3.0.x_to_4.0.0.mos")),
    Protection(access = Access.packageDuplicate),
    uses(OpenIPSL(version="3.0.0"), Modelica(version="4.0.0")),
    preferredView="info",
    Documentation(info="<html>
<p>The OpenHPL is an open-source hydropower library that
consists of hydropower unit models and is modelled using Modelica.</p>
<p>It is developed at the <a href=\"https://www.usn.no/english\">University of South-Eastern Norway (USN)</a>, Campus Porsgrunn. </p>
<p>For more information see the <a href=\"modelica://OpenHPL.UsersGuide\">User's Guide</a>.</p>
</html>",
    __OpenModelica_infoHeader = "<script defer src=\"https://cdn.jsdelivr.net/npm/mathjax@4/tex-svg.js\"></script>"));
end OpenHPL;