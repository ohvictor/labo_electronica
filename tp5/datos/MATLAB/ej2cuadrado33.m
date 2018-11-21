clear vars;

% Parámetros dados sobre la onda
Ac = 250e-3/2; % Vpp
f = 0.7e6; % Hz
w = 2*pi*f;

% Cálculos para generarla
n = (1:1000)';

An = zeros(length(n),1);
Bn = zeros(length(n),1);

for i=1:length(n)
    if (rem(n(i),3) == 0)
        An(i) = 0;
    elseif (rem(n(i),6) == 1 || rem(n(i),6) == 2)
        An(i) = 0.5*sqrt(3)*4*Ac/pi/n(i);
    else
        An(i) = -0.5*sqrt(3)*4*Ac/pi/n(i);
    end
end

wn = w*n;

Pn = (An + Bn).^2/50;
Pdbm = 10*log10(Pn/1e-3);

% Generación de las ondas
t = (-2/f:1/f/1000:2/f)';
Sf = zeros(length(t),1);
sn = zeros(length(t), length(n));
for i=1:length(n)
    Sf = Sf+sin(wn(i)*t)*Bn(i) + cos(wn(i)*t)*An(i);
    sn(:,i) = Sf;
end

% Dibujo de la onda resultante
figure(1);
stem(n(1:10)*f ,Pdbm(1:10));
grid on;
xlabel('Frecuencia(Hz)')
ylabel('Potencia(dBm)');
title('Espectro Simulado');

figure(2);
plot(t,Sf);
% plot(t,Sf,t,sn(:,:));
% axis([-3e-6 3e-6 -0.15 0.15]);
grid on;
xlabel('Tiempo(s)');
ylabel('Voltaje(V)');