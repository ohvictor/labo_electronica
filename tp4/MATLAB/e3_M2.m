clear
%Constantes
R1 = 1e1; %Ohm
C3 = 100e-9; %F

f = 10e3; %Hz
w = 2*pi*f;
Vg = 10; %V

%Resistencia 3
M = 20; %Vueltas al Potenciometro
QN = 20;
Qm = 0.25*QN;
QM = QN;
R3M = QM/(w*C3);
R3m = Qm/(w*C3);
dR3 = (R3M-R3m)/M;
R3 = (R3m:dR3:R3M)';

%Resistencia 4
N = 20; %Vueltas al Potenciometro
LM = 2.1e-3; %H
Lm = 0.4e-3; %H
R4M = LM/(C3*R1);
R4m = Lm/(C3*R1);
dR4 = (R4M-R4m)/N;
R4 = (R4m:dR4:R4M)';

%Componentes(Random)

Rx = 1e1; %Ohm. No la se, pero no va a afectar mucho los calculos
Lx = (LM-Lm)*rand()+Lm;
%Lx = L; %Alternatively

Qx = (QM-Qm)*rand()+Qm;
%Qx = Q; %Alternatively

%Impedancias en Puente de Maxwell
Z1 = R1;
Zx = Rx + 1i*w*Lx;
Z3 = 1./(1./R3 + 1i*w*C3);
Z4 = R4;

%Calculos
Vd = zeros(length(R3),length(R4));
for i=1:length(R3)
    for j=1:length(R4)
        Vd(i,j) = abs(Vg*(Z3(i)*Zx - Z1*Z4(j))/((Z1 + Z3(i))*(Zx + Z4(j))));
    end
end

%Coordenadas
Qxx = w *C3.*R3;
Lyy = R1*C3.*R4;

% %Coordenadas R
surf(R3,R4,Vd);
xlabel('R3'); %Qx
ylabel('R4'); %Lx
zlabel('Vd');

%Coordenadas Q,L

% surf(Qxx,Lyy,Vd);
% xlabel('Qx');
% ylabel('Lx');
% zlabel('Vd');

min(min(Vd))

view(90,0);
%90,0 veo el plano YZ
%180,0 veo el plano XZ
