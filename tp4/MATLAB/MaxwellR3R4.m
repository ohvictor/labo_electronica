clear
% Constantes
R1 = 1e3; % Ohm. Afecta Unicamente a R1
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
spanR4 = spanL/(C3*R1); % Ohm
ranR4 = max(spanR4) - min(spanR4); % Rango de R1
DR4 = ranR4/NR1; % Delta R1
R4 = (min(spanR4):DR4:max(spanR4));

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
Vd = zeros(length(R4),length(R3));
for i=1:length(R4)
    for j=1:length(R3)
        Vd(i,j) = abs(Z3(j)/(Z1+Z3(j)) - Z4(i)/(Z2+Z4(i)))*Vg;
    end
end

figure(1);
surf(R4,R3,Vd);
xlabel('R4');
ylabel('R3');
zlabel('Vd');
title ('Voltajes');

% Sensibilidades
% Sensibilidad a R3
dVdR3 = zeros(length(R4),length(R3));
for i=1:length(R4)
    for j=1:length(R3)
        dVdR3(i,j) = abs(1/((1 + Z1/Z3(j))*(Z4(i)/Z2 + 1))*DR3/Z3(j)*Vg);
    end
end

figure(2);
surf(R4,R3,dVdR3);
xlabel('R4');
ylabel('R3');
zlabel('dVd');
title('Sensibilidad respecto a R3');

% Sensibilidad a R1
dVdR4 = zeros(length(R4),length(R3));
for i=1:length(R4)
    for j=1:length(R3)
        dVdR4(i,j) = abs(1/((1 + Z1/Z3(j))*(Z4(i)/Z2 + 1))*DR4/Z4(i)*Vg);
    end
end

figure(3);
surf(R4,R3,dVdR4);
xlabel('R4');
ylabel('R3');
zlabel('dVd');
title('Sensibilidad respecto a R4');