% Dany Uy et Celena Louis
% test de l'algo SQP
%clc
clear;
close all;
addpath("./fct_test");

% Choix entre la methode BFGS (choix = 1) ou la methode SR1 (choix = 2) 
choix = 1;

% Cas test du cours p.25
%-------------------------------------------------------------------%
% Initialisation des donnees
fct_pb = {@ariane1, @ariane1_con, @ariane1_proj}; %fct de R^3 dans R, contrainte de R^3 dans R
m0 = [250000; 50000; 10000];
epsilon = 0.01;
iter_max = 200;
nfonc_max = 600;
eps_x = 1e-6; %tol sur chaque composante de d_x

n = length(m0);
h = 1e-8 * m0; % calcul grad_f
tau = 0.001;

%nécesssaires pour calcul H_Lagrange
lambda = 0;
rho_0 = 1;
taille_tab = 10;

tab = algo_SQP(fct_pb, m0, epsilon, iter_max, nfonc_max, h, tau, choix, lambda, eps_x, rho_0, taille_tab);
sol = [145349; 31215; 7933];

% Construction du tableau
tab_resu = array2table(tab);
% Changement des noms des variables pour affichage
tab_resu.Properties.VariableNames = {'iteration' 'nfonc' 'm_k(1)' 'm_k(2)' 'm_k(3)' 'f(m_k)' 'c(m_k)' 'lambda_k' '||grad_Lagrange||' 'rho'};
tab_resu = mergevars(tab_resu, [3,4,5], 'NewVariableName', 'm_k', 'MergeAsTable', false);

debut_algo = head(tab_resu);
fin_algo = tail(tab_resu);
% Comparaison de la solution m
tab(end,3:5)' - sol
% Comparaison de la solution f(m)
tab(end,6) - 208611;