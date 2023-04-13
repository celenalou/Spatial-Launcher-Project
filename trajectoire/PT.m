% Fonction qui lance le simulateur pour le paramètre theta
function Vf_norm = PT(theta)
global M
global m_s
global m_e
global theta_0

%theta = [theta_0(1:2); theta]; % version avec theta0 et theta1_fixés
[RES] = simulateur(theta, M, m_s, m_e);

Vf_norm = - norm(RES(end,4:5));
end