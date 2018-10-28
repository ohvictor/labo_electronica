clear
% Constantes de Control
R4 = 1e3; %Ohm
C3 = 100e-9; %F

f = 10e3; %Hz
w = 2*pi*f;
Vg = 5; %V

% Control en la Reistencia 3
QN = 10;
Qm = 0.25*QN;
QM = QN;
M = 25; %Vueltas al Potenciometro

% Control en la Resistencia 1
N = 25; %Vueltas al Potenciometro
LM = 2.1e-3; %H
Lm = 0.4e-3; %H

% Resistencia 3
R3M = QM/(w*C3);
R3m = Qm/(w*C3);
rR3 = R3M-R3m;
dR3 = (R3M-R3m)/M;
R3 = (R3m:dR3:R3M)';

%Resistencia 1

R1M = LM/(C3*R4);
R1m = Lm/(C3*R4);
rR1 = R1M-R1m;
dR1 = (R1M-R1m)/N;
R1 = (R1m:dR1:R1M)';

% Componentes de prueba

Rx = 1e12; %Ohm. No la se, pero no va a afectar mucho los calculos
% Lx = (LM-Lm)*rand()+Lm;
% Lx = LM; % Test MAX
% Lx = Lm; % Test min
Lx = (LM-Lm)/2; % Test Mid

% Qx = (QM-Qm)*rand()+Qm;
% Qx = QM; % Test MAX
% Qx = Qm; % Test min
Qx = (QM-Qm)/2; % Test Mid

%Impedancias en Puente de Hay
Z1 = R1;
Zx = 1/(1/Rx + 1/(1i*w*Lx));
Z3 = R3 + 1/(1i*w*C3);
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
Lyy = R4*C3.*R1;

figure(1);

% Coordenadas R
surf(R3,R1,Vd);
xlabel('R3'); %Qx
ylabel('R1'); %Lx
zlabel('Vd');
title('Voltajes');

% Coordenadas Q,L
% surf(Qxx,Lyy,Vd);
% xlabel('Qx');
% ylabel('Lx');
% zlabel('Vd');
% title('Voltajes');

minVd = min(min(Vd));

%view(90,0);
%90,0 veo el plano YZ
%180,0 veo el plano XZ

%Sensibilidad a R3
dVdR3 = zeros(length(R3),length(R1));
for i=1:length(R3)
    for j=1:length(R1)
        dVdR3(i,j) = abs(1/((1 + Z1(j)/Z3(i))*(Z4/Zx + 1))*dR3/Z3(i)*Vg);
    end
end

figure(2);

% % Coordenadas R
surf(R3,R1,dVdR3);
xlabel('R3');
ylabel('R1');
zlabel('dVd');
title('Sensibilidad respecto a R3');

% % Coordenadas Q,L
% surf(Qxx,Lyy,dVdR3);
% xlabel('Qx');
% ylabel('Lx');
% zlabel('Vd');
% title('Voltajes');

%Sensibilidad a R1
dVdR1 = zeros(length(R3),length(R1));
for i=1:length(R3)
    for j=1:length(R1)
        dVdR1(i,j) = abs(-1/((1 + Z3(i)/Z1(j))*(Zx/Z4 + 1))*dR1/Z1(j)*Vg);
    end
end

figure(3);
surf(R3,R1,dVdR1);
xlabel('R3');
ylabel('R1');
zlabel('dVd');
title('Sensibilidad respecto a R1');

% % Coordenadas Q,L
% surf(Qxx,Lyy,dVdR1);
% xlabel('Qx');
% ylabel('Lx');
% zlabel('Vd');
% title('Voltajes');

% figure(4);
% surf(R3,R1,abs(dVdR3-dVdR1)./dVdR3*100);
% xlabel('R3');
% ylabel('R1');
% zlabel('ddVd');
% title('Diferencia Porcentual de Sensibilidad entre R1 y R3');

%data = [R1m R1M rR1 dR1; R3m R3M rR3 dR3; Lx Qx minVd Vg];