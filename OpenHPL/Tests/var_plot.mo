within OpenHPL.Tests;
model var_plot
  Modelica.Blocks.Sources.CombiTimeTable turbine_pressure1(columns = {2}, fileName = "C:/Users/liubomyr/OneDrive/Documents/PhD/HydroCord/Pressure_in.txt", tableName = "pressure", tableOnFile = true);
  Modelica.Blocks.Sources.CombiTimeTable turbine_pressure2(columns = {2}, fileName = "C:/Users/liubomyr/OneDrive/Documents/PhD/HydroCord/Pressure_out.txt", tableName = "pressure", tableOnFile = true);
  Modelica.Blocks.Sources.CombiTimeTable turbine_flow(columns = {2}, fileName = "C:/Users/liubomyr/OneDrive/Documents/PhD/HydroCord/Turbine_flow.txt", tableName = "flow", tableOnFile = true);
end var_plot;
