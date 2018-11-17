function [ Vd,dVdR3,dVdR1 ] = p_Wien ( R1,DR1,R3,DR3,R2,R4,C1,C3,w,Vg)
%p_Wien Simula el puente de Hay con las características dadas
%   Detailed explanation goes here

% Impedancias
Z1 = R1 + 1/(1i*w*C1);
Z2 = R2;
Z3 = 1./(1./R3 + 1i*w*C3);
Z4 = R4;

% Calculo
Vd = zeros(length(R1),length(R3));
for i=1:length(R1)
    for j=1:length(R3)
        Vd(i,j) = abs(Z3(j)/(Z1(i)+Z3(j)) - Z4/(Z2+Z4))*Vg;
    end
end

% Sensibilidades
% Sensibilidad a R3
dVdR3 = zeros(length(R1),length(R3));
for i=1:length(R1)
    for j=1:length(R3)
        dVdR3(i,j) = abs(1/((1 + Z1(i)/Z3(j))*(Z4/Z2 + 1))*DR3/Z3(j)*Vg);
    end
end

% Sensibilidad a R1
dVdR1 = zeros(length(R1),length(R3));
for i=1:length(R1)
    for j=1:length(R3)
        dVdR1(i,j) = abs(1/((1 + Z1(i)/Z3(j))*(Z4/Z2 + 1))*DR1/Z1(i)*Vg);
    end
end

end

