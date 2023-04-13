function [RES, sep, T_norm] = simulateur(theta, M_0, m_s, m_e)
% theta : variable a optimiser (en degré), vecteur de R^4
% M_0 : masse total du lanceur au temps t_0
% m_s : masses sèches du lanceur
% m_e : masses d'ergol du lanceur

% RES : résultats de ODE45
% sep : temps des séparations
% T_norm : normes des vecteurs poussée lors des séparations 

%% Donnees (cf p.8 et 11)
R_0 = [6378137; 0]; % R_0 = [R_t; 0], R_t rayon terrestre
V_0 = 100 * [cosd(theta(1)); sind(theta(1))]; % vitesse initiale
alpha = [15; 10; 10]; % acceleration initiale
v_e = [2600, 3000, 4400]; % vitesse d'ejection

%% Initialisation
q = [0; 0; 0];
t_e = [0; 0; 0]; % durées de combustion
t = [0; 0; 0; 0]; % temps initial + temps des separations
M = [M_0; 0; 0; 0]; % masse du lanceur initiale + séparations
R = zeros(4,2);
V = zeros(4,2);
R(1,:) = R_0';
V(1,:) = V_0';
T_norm = zeros(3);

%Sortie : résultats de ODE45
RES = zeros(1,6);
RES(1,2) = R_0(1);
RES(1,3) = R_0(2);
RES(1,4) = V_0(1);
RES(1,5) = V_0(2);
RES(1,6) = M_0;

%% Boucle sur les étages
for j=[1,2,3]
    % Calcul des donnees a l'allumage (cf p.8)
    T_norm(j) = alpha(j) * M(j);
    q(j) = T_norm(j) / v_e(j);
    t_e(j) = m_e(j)/q(j);
    t(j+1)= t(j) + t_e(j); % attention t(1) correspond au temps t0 = 0
    
    % integration equations p.7
    tspan = [t(j) t(j+1)];
    val_init = [R(j,1) R(j,2) V(j,1) V(j,2) M(j)];
    [tmp, y] = ode45(@(t,y) ode_fun(t, y, T_norm(j), v_e(j), theta(j+1)), tspan, val_init);
    
    % maj des résultats
    RES = [RES ; [tmp,y]];
    
    % maj R, V, M après intégration
    R(j+1,1) = y(end, 1);
    R(j+1,2) = y(end, 2);
    V(j+1,1) = y(end, 3);
    V(j+1,2) = y(end, 4);
    M(j+1) = y(end, 5);
    
    % maj de M due a la separation
    M(j+1) = M(j+1) - m_s(j);
    
end

%% Sortie
sep = t;
RES(end,6) = RES(end,6) - m_s(3); % séparation du dernier étage
end
