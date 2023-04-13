function [] = tracer(RES, sep ,T_norm, theta)
% Fonction pour tracer les courbes du simulateur et du problème de
% trajectoire

%% Tracé de la trajectoire
figure(1);
plot(RES(:,2),RES(:,3))
hold on

% Terre
R_0 = 6378137;
xc = 0;
yc = 0;
tmp_theta = linspace(0,2*pi);
cercle(1,:) = R_0*cos(tmp_theta) + xc;
cercle(2,:) = R_0*sin(tmp_theta) + yc;
plot(cercle(1,:),cercle(2,:))

% Orbite cible
R_cible = R_0 + 250e3;
xc = 0;
yc = 0;
tmp_theta = linspace(0,2*pi);
cercle(1,:) = R_cible*cos(tmp_theta) + xc;
cercle(2,:) = R_cible*sin(tmp_theta) + yc;
plot(cercle(1,:),cercle(2,:),':k')

axis equal
xlabel('x (m)');
ylabel('y (m)');
title('Trajectoire du lanceur');

%% Tracé des courbes (t,norm(v)) (t,m)
% Norme de V
V = RES(:,4:5);
V_norm = vecnorm(V,2,2);
figure(2);
plot(RES(:,1),V_norm);
xlabel('t (s)');
ylabel('Norme de v (m/s)');
title('Norme de la vitesse en fonction du temps')

% Masse
M = RES(:,6);
figure(3);
plot(RES(:,1),M);
xlabel('t (s)');
ylabel('m (kg)');
title('Masse en fonction du temps')

% Altitude
R = RES(:,2:3);
R_norm = vecnorm(R,2,2);
R_norm = R_norm - R_0;
figure(4);
plot(RES(:,1),R_norm(:,1));
hold on;
plot(RES(:,1),250e3*ones(length(RES),1)); % Altitude cible
ylim([0 260e3]);
xlabel('t (s)');
ylabel('Altitude (m)');
title('Altitude en fonction du temps')

%% Tracé des vecteurs vitesses lors separations
figure(1)
vecteurs(0, RES, sep, T_norm, theta)
vecteurs(1, RES, sep, T_norm, theta)
vecteurs(2, RES, sep, T_norm, theta)
vecteurs(3, RES, sep, T_norm, theta)
legend('Trajectoire','Terre','Orbite cible','Poussée 1','Poussée 2','Poussée 3', 'Vecteur Vr')

%% Fonction locale
function [] = vecteurs(etage, RES, sep, T_norm, theta)
% etage : numéro de l'étage à tracer
% RES : résultat de ODE45
% sep : temps des séparations
% T_norm : normes des poussées

% on extrait les indices correspondant aux séparations
tmp = [find(RES(:,1)==sep(2));find(RES(:,1)==sep(3));find(RES(:,1)==sep(4))];
tmp = [tmp(1);tmp(3);tmp(5)]; % retrait des doublons dus à l'integration par morceaux

if etage == 1
    R_tmp = [RES(1,2);RES(1,3)]; V_tmp = [RES(1,4);RES(1,5)]; 
    u = T_norm(1)*fct_u(R_tmp,V_tmp,theta(2)); % poussée au début de l'étage
    plot([R_tmp(1); R_tmp(1) + u(1)], [R_tmp(2); R_tmp(2) + u(2)],'-x')
end

% Vecteur vitesse
if etage == 3
    R_tmp = [RES(tmp(etage-1),2);RES(tmp(etage-1),3)]; V_tmp = [RES(tmp(etage-1),4);RES(tmp(etage-1),5)];
    u = T_norm(etage)*fct_u(R_tmp,V_tmp,theta(etage +1)); % poussée au début de l'étage
    plot([R_tmp(1); R_tmp(1) + u(1)], [R_tmp(2); R_tmp(2) + u(2)],'-x')
    
    R_tmp = [RES(tmp(etage),2);RES(tmp(etage),3)]; V_tmp = [RES(tmp(etage),4);RES(tmp(etage),5)];
    plot([R_tmp(1); R_tmp(1) + V_tmp(1)], [R_tmp(2); R_tmp(2) + V_tmp(2)],'-o')
    
end    

if etage == 2
    R_tmp = [RES(tmp(etage-1),2);RES(tmp(etage-1),3)]; V_tmp = [RES(tmp(etage-1),4);RES(tmp(etage-1),5)]; 
    u = T_norm(etage)*fct_u(R_tmp,V_tmp,theta(etage +1)); % poussée au début de l'étage
    plot([R_tmp(1); R_tmp(1) + u(1)], [R_tmp(2); R_tmp(2) + u(2)],'-x')
end

hold on

end
end