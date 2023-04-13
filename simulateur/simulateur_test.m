clear
close all
addpath("../fct_Ariane");
addpath("../algo_sqp");
global m_s; % nécessaire pour le simulateur

%% Calcul de notre lanceur avec SQP
% Pour info Ariane1 = [145349; 31215; 7933] avec une Vc = 11527, mu = 1700

% Notre problème : mu = 1500, Rc = 250e3
R_c = 6378137 + 250e3; % Rayon cible
mu = 3.986e+14; % Constante gravitationnelle terrestre
V_c = sqrt(mu / R_c); % Vitesse cible
global Vp % nécessaire pour ariane_con
Vp = V_c; % Vitesse propulsive environs 7750

% Choix entre la methode BFGS (choix = 1) ou la methode SR1 (choix = 2) 
choix = 1;

% Initialisation des donnees
fct_pb = {@ariane1, @ariane1_con, @ariane1_proj}; %fct de R^3 dans R, contrainte de R^3 dans R
m0 = [155000; 75000; 5000];
epsilon = 0.01;
iter_max = 200;
nfonc_max = 1000;
eps_x = 1e-6; %tol sur chaque composante de d_x

h = 1e-12 * m0; % calcul grad_f
tau = 0.1;

%nécesssaires pour calcul H_Lagrange
lambda = 0;
rho_0 = 1;
taille_tab = 10;

% Calcul d'un étagement
[tab_etagement] = algo_SQP(fct_pb, m0, epsilon, iter_max, nfonc_max, h, tau, choix, lambda, eps_x, rho_0, taille_tab);
m_e = tab_etagement(end,3:5)'
M_0 = ariane1(m_e);

theta = [0;0;-7.2; 8];

%% Simulation et tracer
[RES,sep,T_norm] = simulateur(theta, M_0, m_s, m_e);
tracer(RES,sep,T_norm, theta);