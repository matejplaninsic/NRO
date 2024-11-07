%1
% Uvozimo podatke v tabelo
data = readtable('naloga1_1.txt', 'ReadVariableNames', false);
%}
% Prvi stolpec izluščimo kot vektor
t = data{:, 1};  % Izluščimo prvi stolpec brez tabelarne strukture
disp(t);

%2
fid = fopen('naloga1_2.txt', 'r');

st_vrstic = fscanf(fid, 'stevilo_podatkov_P: %d', 1);
%fprintf('Število vrstic: %d\n', st_vrstic);

P = zeros(st_vrstic, 1); %vektor prave velikosti

for i = 1:st_vrstic  %od:do-kolko krat se ponovi
    P(i) = fscanf(fid, '%f', 1); % Preberi eno število v vsaki vrstici in shrani v vektor P
end

fclose(fid);

disp(P);


plot(t, P);  % Izrišemo graf P glede na t
xlabel('t [s]');  % Oznaka za x-os ->t
ylabel('P [W]');  
title('Graf P(t)');  

%3
%trapezna funkcija računanje
n = length(t);
int = 0;%spremenljivka
% Trapezno pravilo - računanje integrala
for i = 2:n
    dt = t(i) - t(i-1);  % Širina intervala
    int = int + (P(i) + P(i-1))/2 * dt;  % Trapezna formula
end
disp('izračuna integrala z trapezno metodo:');
disp(int);

%Primerjava z matlab trapz
int_trapz = trapz(t, P);  % trapz matlab
disp('integrala z matlab trapz:');
disp(int_trapz);

disp('rezultata se ujemata, verjetno enaka koda');

%4
