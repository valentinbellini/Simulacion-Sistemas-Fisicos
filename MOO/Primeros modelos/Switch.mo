model Switch
  extends OnePort;
  parameter Real Ron=1e-5,Roff=1e5;
  discrete Real s;
equation
  v= if s>0.5 then i*Ron else i*Roff;
end Switch;
