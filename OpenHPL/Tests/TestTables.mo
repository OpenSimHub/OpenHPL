within OpenHPL.Tests;
model TestTables "Test and compare the table blocks"
  extends Modelica.Icons.Example;
  Sources.CombiTimeTable combiTimeTable1(
    tableOnFile=true,
    fileName=Modelica.Utilities.Files.loadResource("modelica://OpenHPL/Resources/Tables/test.csv"),
    nHeaderLines=1,
    columns={2})
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable2(
    tableOnFile=true,
    tableName="tab1",
    fileName=Modelica.Utilities.Files.loadResource("modelica://OpenHPL/Resources/Tables/test.txt"),
    columns={2})
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  annotation (experiment(StopTime=45));
end TestTables;
