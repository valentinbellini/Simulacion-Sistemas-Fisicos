model BBall
  Boolean contact(start=false);
  Real y_cm(start=2.0533), v_cm(start=0.0), F_m, F_g, F_aire, F_piso, F_res, delta_y;
  parameter Real b_aire=0.0, b_piso=2.5, g=9.81, m=0.026, r=0.0381/2;
equation
  
  m*der(v_cm)- F_m = 0;
  der(y_cm)-v_cm=0;
  F_g - m*g=0;
  F_aire-b_aire*v_cm=0;
  
  F_piso-b_piso*v_cm=0;
  F_res-LookUpTable(delta_y)=0;
  delta_y-(r-y_cm)=0;
  //Fn+Fb_p-Fk_p=0;
  
  if contact then
    F_m + F_g + F_piso - F_res = 0;
  else
    F_m + F_g + F_aire = 0;
  end if;
  
algorithm

  when y_cm<=r then
    contact:=true;
  end when;
  
  when y_cm>r then
    contact:=false;
  end when;
  
end BBall;
