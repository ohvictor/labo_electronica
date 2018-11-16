clear all

Ac = 250e-3; % Vpp
f = 0.7e6; % Hz
w = 2*pi*f;

k = (1:10)';
n = 2*k-1;

Bn = Ac*4./(pi.*n);
wn = w*n;

figure(1);
stem(n*w ,Bn);

% s01 = @(x) 0.3183*sin(4.3982e6*x);
% s03 = @(x) 0.1061*sin(1.3196e7*x);
% s05 = @(x) 0.0637*sin(2.1991e7*x);
% s07 = @(x) 0.0455*sin(3.0788e7*x);
% s09 = @(x) 0.0354*sin(3.9584e7*x);
% s11 = @(x) 0.0289*sin(4.8381e7*x);
% s13 = @(x) 0.0245*sin(5.7177e7*x);
% s15 = @(x) 0.0212*sin(6.5973e7*x);
% s17 = @(x) 0.0287*sin(7.4660e7*x);
% s19 = @(x) 0.0168*sin(8.3566e7*x);

s01 = @(x) Ac*4/pi/1*sin(w*1*x);
s03 = @(x) Ac*4/pi/3*sin(w*3*x);
s05 = @(x) Ac*4/pi/5*sin(w*5*x);
s07 = @(x) Ac*4/pi/7*sin(w*7*x);
s09 = @(x) Ac*4/pi/9*sin(w*9*x);
s11 = @(x) Ac*4/pi/11*sin(w*11*x);
s13 = @(x) Ac*4/pi/13*sin(w*13*x);
s15 = @(x) Ac*4/pi/15*sin(w*15*x);
s17 = @(x) Ac*4/pi/17*sin(w*17*x);
s19 = @(x) Ac*4/pi/19*sin(w*19*x);

xx = (0:1e-2:1);
Sf = s01(xx)+s03(xx)+s05(xx)+s07(xx)+s09(xx)+s11(xx)+s13(xx)+s15(xx)+s17(xx)+s19(xx);


figure(2);
plot(xx,Sf);


