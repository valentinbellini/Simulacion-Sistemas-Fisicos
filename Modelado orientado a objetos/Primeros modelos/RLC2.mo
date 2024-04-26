model RLC2
  Capacitor cap(v.start=1);
  Inductor ind;
  Resistor res, res2(R=2);
  Ground gr;
equation
  //Node 1
  cap.Vp - res2.Vp = 0;
  -cap.i - res2.i = 0;
  //Node 2
  res2.Vn-ind.Vp = 0;
  res2.Vn - res.Vp = 0;
  res2.i - ind.i - res.i = 0;
  //Node 3
  cap.Vn - gr.Vp = 0;
  res.Vn - gr.Vp = 0;
  ind.Vn - gr.Vp = 0;
  res.i + ind.i + cap.i - gr.i = 0;
end RLC2;
