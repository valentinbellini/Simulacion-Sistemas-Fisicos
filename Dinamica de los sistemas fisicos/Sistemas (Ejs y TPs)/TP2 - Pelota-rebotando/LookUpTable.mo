function LookUpTable
   input Real x;
   output Real y;
   protected
   parameter Real xdata[:]=0.00124*{0,1,2,3,4}; // en metros (1.24mm por vuelta).
  parameter Real ydata[:]=(9.8/1000)*{0,370,910,1540,2300}; // N
   Integer k;
   algorithm
     k:=1;
     while x>xdata[k+1] and k<size(xdata,1)-1 loop
       k:=k+1;
     end while;
     y:=(ydata[k+1]-ydata[k])/(xdata[k+1]-xdata[k])*(x-xdata[k])+ydata[k];
end LookUpTable;
