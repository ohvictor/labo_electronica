clear
R1 = 10e3; %Ohm
Rx = 0; %Ohm
C3 = 100e-9; %F

f = 10e3; %Hz
w = 2*pi*f;
Vg = 10; %V

N = 20; %Vueltas
Lx = (0.2:(1/N):2.1)';

QN = 20;
Qx = (0.25*QN:(0.75*QN/20):QN)';
R3 = Qx/(w*C3);
R4 = Lx/(C3*R1);

Z1 = R1;
Zx = Rx + 1i*w*Lx;
Z3 = 1./(1./R3 + 1i*w*C3);
Z4 = R4;

Va = Vg .* Z3./(Z1+Z3);
Vb = Vg .* Z4./(Zx+Z4);

%Vd = Va - Vb;

for i=1:length(Va)
    for j=1:length(Vb)
        Vd(i,j) = abs(Va(i)-Vb(j));
    end
end

mesh(Lx,Qx,Vd);
xlabel('Lx');
ylabel('Qx');
zlabel('Vd');
