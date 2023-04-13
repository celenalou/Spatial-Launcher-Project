function [c] = PT_con(theta)
global M;
global m_s;
global m_e;
global theta_0

%theta = [theta_0(1:2); theta]; % version pour theta0 et theta1_fixés
R_0 = 6378137;
R_cible = R_0 + 250e3;
c = zeros(2,1);

[RES] = simulateur(theta, M, m_s, m_e);
Vf = RES(end,4:5);
Rf = RES(end,2:3);

% Avec facteurs d'échelles
c(1) = norm(Rf)/R_cible -1;
c(2) = dot(Rf/norm(Rf),Vf/norm(Vf));

% Version sans facteurs d'échelles
%c(1) = norm(Rf)-R_cible;
%c(2) = dot(Rf,Vf);
end