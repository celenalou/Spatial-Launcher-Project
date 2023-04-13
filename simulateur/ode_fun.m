function dy = ode_fun(t, y, T_norm, v_e, theta)
% fonction pour ODE45 pour résoudre le sytème p.7

R = [y(1); y(2)];   % vecteur position
V = [y(3); y(4)];   % vecteur vitesse
M = y(5);           % masse

mu = 3.986e14;
c_x = 0.1;
rho = 1.225 * exp( -(norm(R) -6378137) / 7000); % attention au moins
dy = zeros(5, 1);

W = - mu* R * M / (norm(R)^3);  % poids
D = - c_x * rho * norm(V) * V;  % trainée
T = T_norm * fct_u(R, V, theta);% poussée
q = T_norm / v_e; %             % débit massique de l'étage

dy(1) = V(1); %y(3);           % dx
dy(2) = V(2); %y(4);           % dy
dy(3) = (T(1)+W(1)+D(1)) / M;  % dv_x
dy(4) = (T(2)+W(2)+D(2)) / M;  % dv_y
dy(5) = - q;                   % dM

end