clear
% Constantes
R4 = 15e3; % Ohm.
R2 = 30e3;
C3 = 100e-9; % F
C1 = 100e-9;

f = 1e3; % Hz
w = 2*pi*f; % Rad*s-1
Vg = 10; % V

NR1 = 25; % Vueltas del R1
NR3 = 25; % Vueltas del R3

% Parametro Resistencia 1 (Afecta con Lx)
spanR1 = [796 7,96e3]; % Ohm
ranR1 = max(spanR1) - min(spanR1); % Rango de R1
DR1 = ranR1/NR1; % Delta R1
R1 = (min(spanR1):DR1:max(spanR1));
% DR1 = 500/25; % Trato de bajar la sensibilidad

% Parametro Reistencia 3 (Afecta con Qx)
spanR3 = spanR1; % Ohm
ranR3 = ranR1;% Rango de R3
DR3 = DR1; % Delta R3
R3 = (min(spanR3):DR3:max(spanR3));
% DR3 = DR3/1;
DR1 = 500/25; % Trato de bajar la sensibilidad
DR3 = 500/25; % Trato de bajar la sensibilidad

[Vd,dVdR3,dVdR1] = p_Wien ( R1,DR1,R3,DR3,R2,R4,C1,C3,w,Vg);

figure(1)
surf(R3,R1,Vd);
xlabel('R3');
ylabel('R1');
zlabel('Vd');
title ('Voltajes');
print -depsc ej2Vd

figure(2)
surf(R3,R1,dVdR3);
xlabel('R3');
ylabel('R1');
zlabel('dVd');
title('Sensibilidad respecto a R3');
print -depsc ej2dVd3

figure(3)
% hold on
surf(R3,R1,dVdR1);
xlabel('R3');
ylabel('R1');
zlabel('dVd');
title('Sensibilidad respecto a R1');
print -depsc ej2dVd1
% hold off

% Lx = max(spanL); % MAX
% Qx = max(spanQ);
% 
% [Vd,dVdR3,dVdR1] = p_HayR1R3 ( Lx,Qx,R1,DR1,R3,DR3,R4,C3,w,Vg);
% 
% figure(4)
% surf(R3,R1,Vd);
% xlabel('R3');
% ylabel('R1');
% zlabel('Vd');
% title ('Voltajes');
% print -depsc ej3Vdmax
% 
% figure(5)
% surf(R3,R1,dVdR3);
% xlabel('R3');
% ylabel('R1');
% zlabel('dVd');
% title('Sensibilidad respecto a R3');
% print -depsc ej3dVd3max
% 
% figure(6)
% surf(R3,R1,dVdR1);
% xlabel('R3');
% ylabel('R1');
% zlabel('dVd');
% title('Sensibilidad respecto a R1');
% print -depsc ej3dVd1max
% 
% Lx = min(spanL); % min
% Qx = min(spanQ);
% 
% [Vd,dVdR3,dVdR1] = p_HayR1R3 ( Lx,Qx,R1,DR1,R3,DR3,R4,C3,w,Vg);
% 
% figure(7)
% surf(R3,R1,Vd);
% xlabel('R3');
% ylabel('R1');
% zlabel('Vd');
% title ('Voltajes');
% print -depsc ej3Vdmin
% 
% figure(8)
% surf(R3,R1,dVdR3);
% xlabel('R3');
% ylabel('R1');
% zlabel('dVd');
% title('Sensibilidad respecto a R3');
% print -depsc ej3dVd3min
% 
% figure(9)
% surf(R3,R1,dVdR1);
% xlabel('R3');
% ylabel('R1');
% zlabel('dVd');
% title('Sensibilidad respecto a R1');
% print -depsc ej3dVd1min