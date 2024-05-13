model PanelBoost
  Capacitor cap(C=1e-4);
  Inductor ind(L=1e-4);
  Ground gr;
  Switch sw;
  Diode di;
  Resistor rs(R=0.35),rsh(R=200),rl(R=10);
  Diode dio;
  ConstCurr cc(I=2);
  parameter Real dc=0.75;
  parameter Real T=1e-4;
equation
  connect(cc.p,dio.p);
  connect(cc.p,rsh.p);
  connect(cc.p,rs.p);
  connect(cc.n,dio.n);
  connect(cc.n,rsh.n);
  connect(cc.n,gr.p);
  connect(rs.n,ind.p);
  connect(ind.n,sw.p);
  connect(ind.n,di.p);
  connect(di.n,cap.p);
  connect(cap.p,rl.p);
  connect(cap.n,rl.n);
  connect(cap.n,sw.n);
  connect(cap.n,gr.p);
  
algorithm
  when sample(0,T) then
    sw.s:=1;
  end when;
  when sample(dc*T,T) then
    sw.s:=0;
  end when;
end PanelBoost;
