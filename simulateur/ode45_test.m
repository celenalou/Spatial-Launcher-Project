% Tests de ODE45 avant programmation du simulateur

%% Cas où j= 1
% Donnees
theta_0 = 10;
theta_1 = 0;
m_e = [145349; 31215; 7933]; % masse d'ergols de la solution de ariane 1

R_0 = [6378137; 0]; % pg 11 : R_0 = [R_t; 0], R_t donnee a la pg 8
V_0 = 100 * [cosd(theta_0); sind(theta_0)]; % angles en degree
M_0 = ariane1(m_e);
alpha = [15; 10; 10]; % acceleration initiale
v_e = [2600, 3000, 4400]; % vitesse d'ejection

% Initialisation
T_norm = alpha(1) * M_0;
q(1) = T_norm/v_e(1);
t_e(1) = m_e(1)/q(1); % duree de combustion

%integration equations p.7
tspan = [0 t_e(1)];
val_init = [R_0(1) R_0(2) V_0(1) V_0(2) M_0];
    
[t, y] = ode45(@(t,y) ode_fun(t, y, T_norm, v_e(1),theta_1) , tspan, val_init);

plot(y(:,1), y(:,2))
hold on
plot(y(1,1), y(1,2),'ro')



%% Tracé du cercle
r = R_0(1);
xc = 0;
yc = 0;

theta = linspace(0, 2*pi);
cercle(1,:) = r*cos(theta) + xc;
cercle(2,:) = r*sin(theta) + yc;
plot(cercle(1,:), cercle(2,:))
axis equal