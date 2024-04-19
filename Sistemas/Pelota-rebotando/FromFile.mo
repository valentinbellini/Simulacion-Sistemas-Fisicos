model FromFile
  Real ydata;
    Modelica.Blocks.Sources.CombiTimeTable table(fileName = "/exper1.txt", tableName = "datos",
      tableOnFile = true);
  equation
    ydata=table.y[1];
end FromFile;

 
