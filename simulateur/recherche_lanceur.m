addpath("../algo_sqp");
addpath("../fct_Ariane");
clear
close all
% Recherche de notre lanceur avec SQP en testant plusieurs valeurs
% Cette fonction est aussi utile pour ajuster les paramètres de SQP.

%% Données cf p.1
R_c = 6378137 + 250e3;      % Rayon cible
mu = 3.986e+14;             % Constante gravitationnelle terrestre
V_c = sqrt(mu / R_c);       % Vitesse cible
global Vp
Vp = V_c;                   % Vitesse propulsive

%% Génération de n points
n = 9*4*3; % n = 108
M1 = linspace(20000,200000,9);
M2 = linspace(15000,75000,4);
M3 = linspace(5000,50000,3);
[X,Y,Z] = meshgrid(M1,M2,M3);

% Stockage dans un tableau
X = reshape(X,1,n);
Y = reshape(Y,1,n);
Z = reshape(Z,1,n);
RES = NaN(n,9);

%% Calculs des sorties SQP pour chaque point
for i = 1:n
    RES(i,1:3) = [X(i),Y(i),Z(i)]; % point d'initialisation
    
    [grad_L_norm,etagement] = recherche([X(i),Y(i),Z(i)]'); % lancement de SQP avec les paramètres fixés plus bas
    RES(i,4) = grad_L_norm;     % on stocke la norme du gradient du lagrangien pour trier les résultats ensuite
    RES(i,5) = (RES(i,4)<5);    % on vérifie sur grad_L_norm est faible
    RES(i,6:8) = etagement;     % étagement proposé pour le point de cette ligne
    RES(i,9) = ariane1(etagement); % poids total du lanceur
    
end    

SEL = RES(find(RES(:,5)),:); % Sélection des points intéressants selon la colonne 5


%% Fonction locale qui lance SQP
function[grad_L_norm,etagement] = recherche(m0)
% Choix entre la methode BFGS (choix = 1) ou la methode SR1 (choix = 2) 
choix = 1;

% Initialisation des donnees
fct_pb = {@ariane1, @ariane1_con, @ariane1_proj}; %fct de R^3 dans R, contrainte de R^3 dans R

epsilon = 0.01;
iter_max = 200;
nfonc_max = 600;
eps_x = 1e-6; %tol sur chaque composante de d_x

n = length(m0);
h = 1e-12 * m0;
tau = 0.1;

%nécesssaires pour calcul H_Lagrange
lambda = 0;
rho_0 = 1;
taille_tab = 10;

% SQP
tab = algo_SQP(fct_pb, m0, epsilon, iter_max, nfonc_max, h, tau, choix, lambda, eps_x, rho_0, taille_tab);
grad_L_norm = tab(end,9);
etagement = tab(end,3:5);

end
