clear all

% Par�metros dados sobre la onda
Ac = 250e-3/2; % Vpp
f = 0.7e6; % Hz
w = 2*pi*f;

% C�lculos para generarla
k = (1:1000)';
n = 2*k-1;

Bn = Ac*4./(pi.*n);
wn = w*n;

Pn = Bn.^2/50;
Pdbm = 10*log10(Pn/1e-3);

% Generaci�n de las ondas
t = (0:1/f/1000:4/f)';
Sf = zeros(length(t),1);
sn = zeros(length(t));
for i=1:length(n)
    Sf = Sf+sin(w*n(i)*t)*Bn(i);
    sn(:,i) = sin(w*n(i)*t)*Bn(i);
end

% Dibujo de la onda resultante
figure(1);
stem(n(1:10)*w ,Pdbm(1:10));
grid on;
xlabel('Frecuencia')
ylabel('Potencia(dBm)');

figure(2);
plot(t,Sf);
axis([0 6e-6 -0.15 0.15]);
grid on;
xlabel('Tiempo');
ylabel('Voltaje(V)');