clc
clear;
close all;
addpath("./fct_test");

% Choix entre la methode BFGS (choix = 1) ou la methode SR1 (choix = 2) 
choix = 2;

%-------------------------------------------------------------------%
% Cas test du cours p.25
%-------------------------------------------------------------------%
% Initialisation des donnees
fct_pb = {@MHW4D, @MHW4D_con, @proj}; %Attention la position des arguments est importante
x0 = [-1; 2; 1; -2; -2];% - ones(5,1) * 0.5; %test de robustesse
epsilon = 0.001;
iter_max = 100;
nfonc_max = 600;
eps_x = 1e-4; %tol sur chaque composante de d_x
h = ones(5,1)*1e-8;
tau = 0.001;
rho = 1;
lambda = [0;0;0];
taille_tab = 16;
sol = [-1.2366; 2.4616; 1.1911; -0.2144; -1.6165];
tab = algo_SQP(fct_pb, x0, epsilon, iter_max, nfonc_max, h, tau, choix, lambda, eps_x, rho, taille_tab);

% Construction du tableau
tab_resu = array2table(tab);
% Changement des noms des variables pour affichage
tab_resu.Properties.VariableNames = {'iteration' 'nfonc' 'x_k(1)' 'x_k(2)' 'x_k(3)' 'x_k(4)' 'x_k(5)' 'f(x_k)' 'c(x_k)(1)' 'c(x_k)(2)' 'c(x_k)(3)' 'lambda_k(1)' 'lambda_k(2)' 'lambda_k(3)' '||grad_Lagrange||' 'rho'};
tab_resu = mergevars(tab_resu, [3,4,5,6,7], 'NewVariableName', 'x_k', 'MergeAsTable', false);
tab_resu = mergevars(tab_resu, [5,6,7], 'NewVariableName', 'c(x_k)', 'MergeAsTable', false);
tab_resu = mergevars(tab_resu, [6,7,8], 'NewVariableName', 'lambda_k', 'MergeAsTable', false);
debut_algo = head(tab_resu);
fin_algo = tail(tab_resu);

% Comparaison de la solution m
tab(end,3:7)' - sol
% Comparaison de la solution f(m)
tab(end,8) - 28.4974;