function [H_Lagrange, rho] = hessien_QN(d, grad_L_prec, grad_Lagrange, H_Lagrange, choix, ind, rho)

% d = variation entre x_k et x_(k-1)
% y = difference des gradients Lagrangien
% H_Lagrange = Hessienne du Lagrangien
% choix = Methode BFGS ou Methode SR1 ?
% ind -> reinitialisation de H_Lagrange ou non

y = grad_Lagrange - grad_L_prec;

% Calcul de H
if ind == 0 %|| ind == 2
    % Methode BFGS
    if choix==1 
        if (y'*d) > 0
            H_Lagrange = H_Lagrange + ((y*y') / (y'*d)) - ((H_Lagrange * (d * d') * H_Lagrange) / (d' * H_Lagrange * d));
        end
    % Methode SR1
    else
        if abs(d' * (y - H_Lagrange*d)) > 0
            H_Lagrange = H_Lagrange + ((y - H_Lagrange * d) * (y - H_Lagrange * d)') / (d' * (y - H_Lagrange * d));
        end
    end
% Reinitialisation de la Hessienne
if ind == 1
    H_Lagrange = eye(length(y));
    rho = rho / 2;
end
end

