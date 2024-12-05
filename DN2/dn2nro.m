v_t = readmatrix('vozlisca_temperature_dn2.txt', 'NumHeaderLines', 4); % Preskoči 4 vrstice glave
x = v_t(:, 1); % x-koordinate
y = v_t(:, 2); % y-koordinate
temp = v_t(:, 3); % temperatura

celice = readmatrix('celice_dn2.txt', 'NumHeaderLines', 2); % Preskoči 2 vrstici glave

%koordinati točke:
tocka_x = 0.403;
tocka_y = 0.503;

tic;
% Interpolacija z "scatteredInterpolant":
int_scatt = scatteredInterpolant(x, y, temp, 'linear', 'none'); %def interpolacijske fun
%T v podani točki
T_tocke_S = int_scatt(tocka_x,tocka_y);
cas1 = toc;
fprintf('Interpolacija z scatteredInterpolant: %.6f °C (čas: %.6f s)\n', T_tocke_S, cas1);


% Interpolacija z "griddedInterpolant"
x_un = unique(x); %mreža unikatnih koordinat (da ni podvojenosti)
y_un = unique(y);
[X_matrika,Y_matrika] = ndgrid(x_un, y_un);
temp_matrika = reshape(temp, length(x_un), length(y_un));% Preoblikovanje temp vrednosti v 2D matriko
tic;
int_gridded = griddedInterpolant(X_matrika,Y_matrika, temp_matrika, "linear");
T_tocke_G = int_gridded(tocka_x, tocka_y);
cas2 = toc;
fprintf('Interpolacija z griddedInterpolant: %.6f °C (čas: %.6f s)\n', T_tocke_G, cas2);


% Bilinearna interpolacija (lastna implementacija)
tic; 

for i = 1:size(celice, 1)

    % Pridobimo indeksne vrednosti celice
    ind1 = celice(i, 1);
    ind2 = celice(i, 2);
    ind3 = celice(i, 3);
    ind4 = celice(i, 4);

    % Koordinate in temperature vogalov celic
    x1 = x(ind1);
    y1 = y(ind1);
    T11 = temp(ind1);

    x2 = x(ind2);
    y2 = y(ind2);
    T21 = temp(ind2);

    x3 = x(ind3);
    y3 = y(ind3);
    T22 = temp(ind3);

    x4 = x(ind4);
    y4 = y(ind4);
    T12 = temp(ind4);

    % Preverimo ali je točka znotraj trenutne celice
    if tocka_x >= x1 && tocka_x <= x2 && tocka_y >= y1 && tocka_y <= y3

        % Interpolacija po x-os
        interpolacija_x1 = (x2 - tocka_x) / (x2 - x1) * T11 + (tocka_x - x1) / (x2 - x1) * T21;
        interpolacija_x2 = (x2 - tocka_x) / (x2 - x1) * T12 + (tocka_x - x1) / (x2 - x1) * T22;

        % Interpolacija po y-os
        T_tocke_B = (y3 - tocka_y) / (y3 - y1) * interpolacija_x1 + (tocka_y - y1) / (y3 - y1) * interpolacija_x2;
        break;
    end
end
cas3 = toc;
fprintf('Bilinearna interpolacija: %.6f °C (čas: %.6f s)\n', T_tocke_B, cas3);



%Max temp
[najvisja_temperatura, vrstica] = max(temp);
x_max = x(vrstica); 
y_max = y(vrstica);

fprintf('Najvisja temperatura: %.3f °C.\n', najvisja_temperatura);
fprintf('Na koordinatah: x = %.3f, y = %.3f.\n', x_max, y_max);

