clear
% Constantes
R4 = 1e6; % Ohm. Afecta Unicamente a R1
C3 = 100e-9; % F. Afecta a ambos

f = 10e3; % Hz
w = 2*pi*f; % Rad*s-1
Vg = 10; % V

% Control
spanL = [0.4e-3 2.1e-3];
NR1 = 25; % Vueltas del R1

QN = 53; % Placeholder
spanQ = [0.25*QN QN];
NR3 = 25; % Vueltas del R3

spanR = w*[max(spanL)/min(spanQ) min(spanL)/max(spanQ)];

% Elemento de "Prueba"
Lx = (max(spanL)-min(spanL))*rand()+min(spanL); % Random
Rx = w*Lx*QN;

% Parametro Resistencia 1 (Afecta con Lx)
spanR1 = spanL/(C3*R4); % Ohm
ranR1 = max(spanR1) - min(spanR1); % Rango de R1
DR1 = ranR1/NR1; % Delta R1
R1 = (min(spanR1):DR1:max(spanR1));

% Parametro Reistencia 3 (Afecta con Qx)
spanR3 = 1./( w .* spanQ * C3); % Ohm
ranR3 = max(spanR3) - min(spanR3); % Rango de R3
DR3 = ranR3/NR3; % Delta R3
R3 = (min(spanR3):DR3:max(spanR3));

% Impedancias
Z1 = R1;
Z2 = 1./(1/Rx + 1/(1i*w*Lx));
Z3 = R3 + 1/(1i*w*C3);
Z4 = R4;

% Calculo
Vd = zeros(length(R1),length(R3));
for i=1:length(R1)
    for j=1:length(R3)
        Vd(i,j) = abs(Z3(j)/(Z1(i)+Z3(j)) - Z4/(Z2+Z4))*Vg;
    end
end

figure(1);
surf(R1,R3,Vd);
xlabel('R1');
ylabel('R3');
zlabel('Vd');
title ('Voltajes');

% Sensibilidades
% Sensibilidad a R3
dVdR3 = zeros(length(R1),length(R3));
for i=1:length(R1)
    for j=1:length(R3)
        dVdR3(i,j) = abs(1/((1 + Z1(i)/Z3(j))*(Z4/Z2 + 1))*DR3/Z3(j)*Vg);
    end
end

figure(2);
surf(R1,R3,dVdR3);
xlabel('R1');
ylabel('R3');
zlabel('dVd');
title('Sensibilidad respecto a R3');

% Sensibilidad a R1
dVdR1 = zeros(length(R1),length(R3));
for i=1:length(R1)
    for j=1:length(R3)
        dVdR1(i,j) = abs(1/((1 + Z1(i)/Z3(j))*(Z4/Z2 + 1))*DR1/Z1(i)*Vg);
    end
end

figure(3);
surf(R1,R3,dVdR1);
xlabel('R1');
ylabel('R3');
zlabel('dVd');
title('Sensibilidad respecto a R1');