% Celena LOUIS & Dany UY
% M2 IMPE Projet Optimisation
function [d_x, rho, glob_ind, nfonc, new_x] = globalisation(x, fct_pb, grad_f, d_QP, rho, f_x, c_x, glob_ind, nfonc)
F = f_x + rho * norm(c_x, 1);
nfonc = nfonc + 1;

% recherche lineaire : Regle d'Armijo
derivee_F = grad_f' * d_QP - rho * norm(c_x, 1);
% Echec
if derivee_F >= 0
    if glob_ind == 0
        glob_ind = 1; % on reinitialise la hessienne dans algo_SQP
    else    
        glob_ind = 2; % on augmente rho
        rho = rho * 2; 
    end
    d_x= 0;
    new_x = x;

% Reussite  
else
    iter = 0;
    iter_max = 10;
    s = 1;
    x_armijo = x + d_QP;
    F_Armijo = f_merite(x_armijo, fct_pb, rho);
    
    % Test du critère de la règle d'Armijo + test d'appartenance au domaine
    % (basé sur la projection)
    while (F_Armijo > F + 0.1 * s * derivee_F || any(x_armijo~=fct_pb{3}(x_armijo))) && (iter < iter_max)
        s = s / 2;
        d_x = s * d_QP;
        x_armijo = x + d_x;
        F_Armijo = f_merite(x_armijo, fct_pb, rho);
        nfonc = nfonc + 1;
        iter = iter + 1;
    end
    % mise a jour des variables
    glob_ind = 0;
    d_x = x_armijo - x;
    new_x = fct_pb{3}(x_armijo); % projection en sortie si la boucle while ne suffit pas
end
end