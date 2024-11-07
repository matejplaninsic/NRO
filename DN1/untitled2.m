% Odpre datoteko za branje
fid = fopen('naloga1_2.txt', 'r');

% Prebere prvo vrstico, ki vsebuje število vrednosti
prva_vrstica = fgetl(fid);  % Prebere prvo vrstico kot besedilo
disp(prva_vrstica);          % Izpis prebrane vrstice

% Izloči število vrednosti iz prve vrstice
% Popravljena funkcija sscanf, ki išče število za dvopičjem ':'
stevilo_vrstic = sscanf(prva_vrstica, 'stevilo_podatkov_P: %d');
disp(stevilo_vrstic)        % Izpis števila


% Odpre datoteko za branje
fid = fopen('naloga1_2.txt', 'r');

% Prebere prvo vrstico, ki vsebuje število vrednosti
prva_vrstica = fgetl(fid);  % Prebere prvo vrstico kot besedilo

% Izloči število vrednosti iz prve vrstice
stevilo_vrstic = sscanf(prva_vrstica, 'stevilo_podatkov_P: %d');



% Inicializira prazen vektor za shranjevanje vrednosti
P = zeros(stevilo_vrstic, 1);

% Zanka za branje naslednjih vrstic in shranjevanje v vektor P
for i = 1:stevilo_vrstic
    vrstica = fgetl(fid);       % Prebere naslednjo vrstico
    P(i) = str2double(vrstica); % Pretvori vrstico v število in shrani v vektor P
end

% Zapre datoteko
fclose(fid);

% Prikaz vektorja P
disp('Vektor P:');
disp(P);
