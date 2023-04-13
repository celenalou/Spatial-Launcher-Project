% Dany Uy et Celena Louis
% test de l'algo SQP
clear;
close all;
addpath("./fct_test");

%-------------------------------------------------------------------%
% Cas test du cours p.24
% -------------------------------------------------------------------%
% Choix entre la methode BFGS (choix = 1) ou la methode SR1 (choix = 2) 
choix = 1;

% Initialisation des donnees
id = @(x) x;
fct_pb = {@f, @contrainte, id}; %fct de R² dans R, contrainte de R² dans R
x0 = [10;5];
epsilon = 0.001;
iter_max = 10000;
nfonc_max = 30;
eps_x = 1e-3;

h = 1e-8 * x0; % calcul grad_f
tau = 0.1;

%nécesssaires pour calcul H_Lagrange
n = length(x0);
grad_Lagrange = ones(n, 1); % comment l'initialiser ?
H_Lagrange = eye(n);
lambda = 1;
rho_0 = 1;
taille_tab = 9;

tab = algo_SQP(fct_pb, x0, epsilon, iter_max, nfonc_max, h, tau, choix, lambda, eps_x, rho_0, taille_tab);
tab_resu = array2table(tab);
tab_resu.Properties.VariableNames = {'iteration' 'nfonc' 'x_k(1)' 'x_k(2)' 'f(x_k)' 'c(x_k)' 'lambda_k' '||grad_Lagrange||' 'rho'};
tab_resu = mergevars(tab_resu, [3,4], 'NewVariableName', 'x_k', 'MergeAsTable', false);