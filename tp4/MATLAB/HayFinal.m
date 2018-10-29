clear
% Constantes
R4 = 1e2; % Ohm. Afecta Unicamente a R1
C3 = 2.2e-9; % F. Afecta a ambos

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
Qx = (max(spanQ)-min(spanQ))*rand()+min(spanQ);

% Lx = max(spanL); % MAX
% Qx = max(spanQ);

% Lx = min(spanL); % min
% Qx = min(spanQ);

% Lx = (max(spanL)+min(spanL))/2; % Mid
% Qx = (max(spanQ)+min(spanQ))/2;

Lx = 0.9713e-3; % Patrón
Qx = 53;

Rx = w*Lx*Qx;

% Parametro Resistencia 1 (Afecta con Lx)
spanR1 = [1.8e3 11.8e3]; % Ohm
ranR1 = max(spanR1) - min(spanR1); % Rango de R1
DR1 = ranR1/NR1; % Delta R1
R1 = (min(spanR1):DR1:max(spanR1));
DR1 = 4; % Trato de bajar la sensibilidad

% Parametro Reistencia 3 (Afecta con Qx)
spanR3 = [100 600]; % Ohm
ranR3 = max(spanR3) - min(spanR3); % Rango de R3
DR3 = ranR3/NR3; % Delta R3
R3 = (min(spanR3):DR3:max(spanR3));
DR3 = DR3/1;

[Vd,dVdR3,dVdR1] = p_HayR1R3 ( Lx,Qx,R1,DR1,R3,DR3,R4,C3,w,Vg);

surf(R3,R1,Vd);
xlabel('R3');
ylabel('R1');
zlabel('Vd');
title ('Voltajes');
print -depsc ej3Vd

surf(R3,R1,dVdR3);
xlabel('R3');
ylabel('R1');
zlabel('dVd');
title('Sensibilidad respecto a R3');
print -depsc ej3dVd3

surf(R3,R1,dVdR1);
xlabel('R3');
ylabel('R1');
zlabel('dVd');
title('Sensibilidad respecto a R1');
print -depsc ej3dVd1

Lx = max(spanL); % MAX
Qx = max(spanQ);

[Vd,dVdR3,dVdR1] = p_HayR1R3 ( Lx,Qx,R1,DR1,R3,DR3,R4,C3,w,Vg);

surf(R3,R1,Vd);
xlabel('R3');
ylabel('R1');
zlabel('Vd');
title ('Voltajes');
print -depsc ej3Vdmax

surf(R3,R1,dVdR3);
xlabel('R3');
ylabel('R1');
zlabel('dVd');
title('Sensibilidad respecto a R3');
print -depsc ej3dVd3max

surf(R3,R1,dVdR1);
xlabel('R3');
ylabel('R1');
zlabel('dVd');
title('Sensibilidad respecto a R1');
print -depsc ej3dVd1max

Lx = min(spanL); % min
Qx = min(spanQ);

[Vd,dVdR3,dVdR1] = p_HayR1R3 ( Lx,Qx,R1,DR1,R3,DR3,R4,C3,w,Vg);

surf(R3,R1,Vd);
xlabel('R3');
ylabel('R1');
zlabel('Vd');
title ('Voltajes');
print -depsc ej3Vdmin

surf(R3,R1,dVdR3);
xlabel('R3');
ylabel('R1');
zlabel('dVd');
title('Sensibilidad respecto a R3');
print -depsc ej3dVd3min

surf(R3,R1,dVdR1);
xlabel('R3');
ylabel('R1');
zlabel('dVd');
title('Sensibilidad respecto a R1');
print -depsc ej3dVd1min