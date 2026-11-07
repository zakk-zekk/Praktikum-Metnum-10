1;
% Soal : dy/dx = (4x^3 - 2x + 1) / (2 + y),  y(0) = 1,  cari y(2)
% Metode: Euler, Heun (RK-2), Runge-Kutta orde-4 dengan N = 15

function r = fxy(x, y)
  r = (4*x^3 - 2*x + 1) / (2 + y);
end

function r = solusi_eksak(x)
  r = -2 + sqrt(2*x.^4 - 2*x.^2 + 2*x + 9);
end

function [tabel, y] = metode_euler(a, y0, b, N)
  h = (b - a) / N;
  x = a; y = y0;
  tabel = zeros(N, 5);
  for i = 0:N-1
    fi = fxy(x, y);
    yn = y + h * fi;
    tabel(i+1, :) = [i, x, y, fi, yn];
    x = x + h;
    y = yn;
  end
end

function [tabel, y] = metode_heun(a, y0, b, N)
  h = (b - a) / N;
  x = a; y = y0;
  tabel = zeros(N, 6);
  for i = 0:N-1
    k1 = fxy(x, y);
    k2 = fxy(x + h, y + k1*h);
    yn = y + (h/2) * (k1 + k2);
    tabel(i+1, :) = [i, x, y, k1, k2, yn];
    x = x + h;
    y = yn;
  end
end

function [tabel, y] = metode_rk4(a, y0, b, N)
  h = (b - a) / N;
  x = a; y = y0;
  tabel = zeros(N, 8);
  for i = 0:N-1
    k1 = fxy(x, y);
    k2 = fxy(x + h/2, y + k1*h/2);
    k3 = fxy(x + h/2, y + k2*h/2);
    k4 = fxy(x + h, y + k3*h);
    yn = y + (h/6) * (k1 + 2*k2 + 2*k3 + k4);
    tabel(i+1, :) = [i, x, y, k1, k2, k3, k4, yn];
    x = x + h;
    y = yn;
  end
end

% ---------------- program utama ----------------
clc; clear;
a = 0; y0 = 1; b = 2; N = 15;

[tE, yE] = metode_euler(a, y0, b, N);
[tH, yH] = metode_heun(a, y0, b, N);
[tR, yR] = metode_rk4(a, y0, b, N);

fprintf('     Tabel Iterasi Metode Euler\n\n');
fprintf('%-3s%-10s%-12s%-14s%-12s\n', 'i', 'xi', 'yi', 'f(xi,yi)', 'yi+1');
fprintf('%s\n', repmat('.', 1, 51));
for r = 1:N
  fprintf('%-3d%-10.4f%-12.4f%-14.4f%-12.4f\n', tE(r, :));
end

fprintf('\n     Tabel Iterasi Metode Heun (RK-2)\n\n');
fprintf('%-3s%-9s%-11s%-11s%-11s%-10s\n', 'i', 'xi', 'yi', 'k1', 'k2', 'yi+1');
fprintf('%s\n', repmat('.', 1, 55));
for r = 1:N
  fprintf('%-3d%-9.4f%-11.4f%-11.4f%-11.4f%-10.4f\n', tH(r, :));
end

fprintf('\n     Tabel Iterasi Metode Runge-Kutta Orde-4\n\n');
fprintf('%-3s%-9s%-10s%-9s%-9s%-9s%-9s%-10s\n', 'i', 'xi', 'yi', 'k1', 'k2', 'k3', 'k4', 'yi+1');
fprintf('%s\n', repmat('.', 1, 68));
for r = 1:N
  fprintf('%-3d%-9.4f%-10.4f%-9.4f%-9.4f%-9.4f%-9.4f%-10.4f\n', tR(r, :));
end

yEks = solusi_eksak(b);
fprintf('\n                 Perbandingan Solusi Eksak\n');
fprintf('Solusi eksak y(%d) = -2 + sqrt(37) = %.6f\n\n', b, yEks);
fprintf('%-10s%-12s%-16s%-18s\n', 'Metode', 'y(2)', 'Galat absolut', 'Galat relatif (%)');
fprintf('%s\n', repmat('.', 1, 56));
nama = {'Euler', 'Heun', 'RK4'};
hasil = [yE, yH, yR];
for k = 1:3
  ga = abs(yEks - hasil(k));
  gr = ga / yEks * 100;
  fprintf('%-10s%-12.6f%-16.6f%-18.4f\n', nama{k}, hasil(k), ga, gr);
end

% ---------------- grafik ----------------
xs = linspace(a, b, 200);
figure;
plot(xs, solusi_eksak(xs), 'k-', 'LineWidth', 2); hold on;
plot([tE(:, 2); b], [tE(:, 3); yE], 'r-o', 'LineWidth', 1);
plot([tH(:, 2); b], [tH(:, 3); yH], 'b-s', 'LineWidth', 1);
plot([tR(:, 2); b], [tR(:, 3); yR], 'g-^', 'LineWidth', 1);
grid on;
xlabel('x'); ylabel('y');
title('Perbandingan Solusi Eksak dan Pendekatan Numerik (N = 15)');
legend('Eksak', 'Euler', 'Heun', 'RK4', 'Location', 'northwest');
hold off;

% ---------------- grafik galat absolut ----------------
hh = (b - a) / N;
xn = tE(:, 2) + hh;
galE = abs(solusi_eksak(xn) - tE(:, 5));
galH = abs(solusi_eksak(xn) - tH(:, 6));
galR = abs(solusi_eksak(xn) - tR(:, 8));
figure;
semilogy(xn, galE, 'r-o', 'LineWidth', 1); hold on;
semilogy(xn, galH, 'g-o', 'LineWidth', 1);
semilogy(xn, galR, 'b-o', 'LineWidth', 1);
grid on;
xlabel('x'); ylabel('Galat absolut (skala log)');
title('Galat absolut tiap metode terhadap x');
legend('Euler', 'Heun', 'RK4', 'Location', 'southeast');
hold off;
