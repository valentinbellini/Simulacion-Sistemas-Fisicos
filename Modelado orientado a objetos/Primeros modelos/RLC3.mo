model RLC3
  Capacitor cap(v.start=1);
  Inductor ind;
  Resistor res, res2(R=2);
  Ground gr;
equation
  connect(cap.p,res2.p);
  connect(res2.n,ind.p);
  connect(res2.n,res.p);
  connect(cap.n,gr.p);
  connect(ind.n,gr.p);
  connect(res.n,gr.p);
end RLC3;
