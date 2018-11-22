f = 125e3;
A = 250e-3;
t = (0:1/f/100:10/f)';

S = A*sin(2*pi*f*t)./t;

plot(t,S);