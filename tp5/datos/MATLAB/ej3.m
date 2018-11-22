

m = 0.5;
fp = 900e3;
Ap = 200e-3;
fm = 100e3;
t = (0:1/fm/100:4/fm)';

Sp = Ap*sin(2*pi*fp*t);
Sm = m*sin(2*pi*fm*t);

Sam = Sp.*( 1 + Sm);

plot(t,Sam);