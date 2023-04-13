function [u] = fct_u(R, V, theta)
% fonction poussée
% R : vecteur position de R^2
% V : vecteur vitesse de R^2
% theta : incidence (angle vitess-pousse) variable selon l'etage et v, angles en degree

e_r = R/norm(R);
e_h = [-R(2); R(1)]/norm(R);
gamma = asind( (R'* V)/ (norm(R)*norm(V)) ); % gamma inclu dans [-90 deg, 90 deg]
u = e_h * cosd(gamma + theta) + e_r * sind(gamma + theta);

end