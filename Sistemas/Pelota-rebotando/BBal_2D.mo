model BBal_2D
  Boolean contact_y(start=false);
  Real y(start=1.581), vy(start=0.0), F, Fyg, Fb_a, Fb_p, Fk_p, delta_y, Fn;
  parameter Real b_a=0.0, g=9.81, m_p=0.026, r_p=0.0381/2, b_p=0.8, b_ax=0.2;
  
  Boolean contact_x(start=false);
  Real x(start=40.0), vx(start=-50.0), Fx, Fxg, Fxb_a, Fxb_p, Fxk_p, delta_x, Fxn;
  
equation
  //EJE Y
  m_p*der(vy)-F=0;
  der(y)-vy=0;
  Fyg-m_p*g=0;
  Fb_a-b_a*vy=0;
  
  Fb_p-b_p*vy=0;
  Fk_p-LookUpTable(delta_y)=0;
  delta_y-(r_p-y)=0;
  Fn+Fb_p-Fk_p=0;
  
  if contact_y then
    F = -Fyg-Fb_a+Fn;
  else
    F = -Fyg-Fb_a;
  end if;
  
  //EJE X
  m_p*der(vx)-Fx=0;
  der(x)-vx=0;
  Fxg=0;
  Fxb_a-b_ax*vx=0;
  
  Fxb_p-b_p*vx=0;
  Fxk_p-LookUpTable(delta_x)=0;
  delta_x-(r_p-x)=0;
  Fxn+Fxb_p-Fxk_p=0;
  
  if contact_x then
    Fx = -Fxg-Fxb_a+Fxn;
  else
    Fx = -Fxg-Fxb_a;
  end if;
  
algorithm
  
  when y<=r_p then
    contact_y:=true;
  end when;
  
  when Fn<0 then
    contact_y:=false;
  end when;
  
  when x<=r_p then
    contact_x:=true;
  end when;
  
  when Fxn<0 then
    contact_x:=false;
  end when;
  
end BBal_2D;
