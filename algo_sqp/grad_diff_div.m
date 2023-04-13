% LOUIS Celena & UY Dany
% M2 IMPE
% Projet Optimisation

function [grad_f, jac_c, f_x, c_x, nfonc] = grad_diff_div(x, h, fct_pb, nfonc)
% x = (x1, ..., xn)
% h = (h1, ..., hn)
% fc = {@fonction, @contraintes}

% grad_f = gradient de la fonction a minimiser
% jac_c = Jacobienne des contraintes

f = fct_pb{1}; % Récupération de la fonction a minimiser
n = length(x); % Dimension de x

% Initialisation pour le gradient de f
grad_f = zeros(n, 1);
step = zeros(n, 1);
f_x = f(x);
nfonc = nfonc + 1;

% Initialisation pour la jacobienne des contraintes s'il y en a
if length(fct_pb) >= 2
    c = fct_pb{2}; % Recuperation des contraintes
    m = length(c(x)); % Nombre de contraintes
    jac_c = zeros(m, n); % initialisation de la Jacobienne
    c_x = c(x);
end

% Calcul du gradient de f et de la jacobienne des contraintes s'il y en a
for i=1:n
    step(i) = h(i);
    xh = x + step;
    grad_f(i) = (f(xh) - f_x) / step(i);
    nfonc = nfonc + 1;
    if length(fct_pb) >= 2
        jac_c(:, i) = (c(xh) - c_x) / step(i);
    end
    step(i) = 0;
end

end

