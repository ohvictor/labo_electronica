clear
%Constantes
R4 = 1e-6; %Ohm
C3 = 100e-9; %F

f = 10e3; %Hz
w = 2*pi*f;
Vg = 50; %V

%Resistencia 3
M = 20; %Vueltas al Potenciometro
QN = 5;
Qm = 0.25*QN;
QM = QN;
R3M = QM/(w*C3);
R3m = Qm/(w*C3);
dR3 = (R3M-R3m)/M;
R3 = (R3m:dR3:R3M)';

%Resistencia 1
N = 20; %Vueltas al Potenciometro
LM = 2.1e-3; %H
Lm = 0.4e-3; %H
R1M = LM/(C3*R4);
R1m = Lm/(C3*R4);
dR1 = (R1M-R1m)/N;
R1 = (R1m:dR1:R1M)';

%Componentes(Random)

Rx = 5; %Ohm. No la se, pero no va a afectar mucho los calculos
Lx = (LM-Lm)*rand()+Lm;
%Lx = L; %Alternatively
% Lx = Lm;

Qx = (QM-Qm)*rand()+Qm;
%Qx = Q; %Alternatively
% Qx = Qm;

%Impedancias en Puente de Maxwell
Z1 = R1;
Zx = Rx + 1i*w*Lx;
Z3 = 1./(1./R3 + 1i*w*C3);
Z4 = R4;

%Calculos
Vd = zeros(length(R3),length(R1));
for i=1:length(R3)
    for j=1:length(R1)
        Vd(i,j) = abs(Vg*(Z3(i)*Zx - Z1(j)*Z4)/((Z1(j) + Z3(i))*(Zx + Z4)));
    end
end

%Coordenadas
Qxx = w *C3.*R3;
Lyy = C3*R4.*R1;

figure(1);
% %Coordenadas R
surf(R3,R1,Vd);
xlabel('R3'); %Qx
ylabel('R1'); %Lx
zlabel('Vd');
title('Voltajes');

%Coordenadas Q,L

% surf(Qxx,Lyy,Vd);
% xlabel('Qx'); %Qx
% ylabel('Lx'); %Lx
% zlabel('Vd');

mindV = min(min(Vd));

%view(90,0);
%90,0 veo el plano YZ
%180,0 veo el plano XZ

% %Sensibilidad
% sVd = zeros(length(R3),length(R1));
% for i=1:length(R3)
%     for j=1:length(R1)
%         sVd(i,j) = abs(dR1*Z4/(Z1(j)+Z3(i))/(Zx+Z4)*Vg);
%     end
% end
% figure(2);
% surf(R3,R1,sVd);
% xlabel('R3');
% ylabel('R1');
% zlabel('dV');
% title('Sensibilidad');

A = Z4/Zx;
F = A/(1+A)^2;

%Sensibilidad a R3
dVdR3 = zeros(length(R3),length(R1));
for i=1:length(R3)
    for j=1:length(R1)
        dVdR3(i,j) = abs(1/((1 + Z1(j)/Z3(i))*(Z4/Zx + 1))*dR3/Z3(i)*Vg);
    end
end

figure(2);
surf(R3,R1,dVdR3);
xlabel('R3');
ylabel('R1');
zlabel('dVd');
title('Sensibilidad respecto a R3');

%Sensibilidad a R1
dVdR1 = zeros(length(R3),length(R1));
for i=1:length(R3)
    for j=1:length(R1)
        dVdR1(i,j) = abs(-1/((1 + Z3(i)/Z1(j))*(Zx/Z4 + 1))*dR1/Z1(j)*Vg);
    end
end

%figure(3);
hold on;
surf(R3,R1,dVdR1);
xlabel('R3');
ylabel('R1');
zlabel('dVd');
title('Sensibilidad respecto a R1');

hold off;
