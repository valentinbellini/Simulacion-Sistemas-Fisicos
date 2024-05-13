model ConstCurr
  extends OnePort;
  parameter Real I=1;
equation
  i= -I;
end ConstCurr;
