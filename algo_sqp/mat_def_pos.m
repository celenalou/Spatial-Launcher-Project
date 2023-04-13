%Matrice definie positive
function [M]= mat_def_pos(H, tau)
n = size(H);
vp = eig(H);
% si valeur propre negative, mise a jour de la hessienne
if vp(1) < tau
    M = H + (abs(vp(1))+tau) * eye(n(1));
else
    M = H;
end
end