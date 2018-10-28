clear
Lx = (0.4e-3:1e-5:2.1e-3);
f = 10e3;
w = 2*pi*f;
Ls = 10e-6;

Rx = w*Lx.*sqrt(Ls./(Lx-Ls));

Rs = real( 1./((1./Rx) + 1./(w*1i.*Lx)) );
figure(1)
plot(Rs,Lx);

Rsx = (3:0.1:10);
Lpx = -1./(w.*imag(1./(Rsx+w*1i*Ls)));

figure(2)
plot(Rsx,Lpx);
