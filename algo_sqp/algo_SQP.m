%Celena LOUIS et Dany UY
function [tab_sol] = algo_SQP(fct_pb, x0, epsilon, iter_max, nfonc_max, h, tau, choix, lambda, eps_x, rho, taille_tab)
%init
n = length(x0);
grad_Lagrange = ones(n, 1);
H_Lagrange = eye(n);
iter = 0;
nfonc = 0;
x = x0;
grad_L_prec = grad_Lagrange;
d_x = zeros(length(x), 1);
d_x(1) = eps_x;
glob_ind = 0; % indicateur pour gérer les échecs de globalisation

% Creation du tableau des resultats
tab = zeros(iter_max, taille_tab);
tab(1, :) = [0; 0; x; fct_pb{1}(x); fct_pb{2}(x); lambda; 0; rho];

% Boucle de l'algo SQP
while (norm(grad_Lagrange) > epsilon && iter < iter_max && norm(d_x,inf) >= eps_x && nfonc < nfonc_max) || (glob_ind ~= 0 && iter < iter_max)
   
    % Calcul des gradients
    if glob_ind == 0 % i.e. reussite de la globalisation
        [grad_f, jac_c, f_x, c_x, nfonc] = grad_diff_div(x, h, fct_pb, nfonc);
        grad_Lagrange = grad_f + jac_c' * lambda;
    end
    
    % Calcul du Hessien
    if iter ~= 0
        [H_Lagrange, rho] = hessien_QN(d_x, grad_L_prec, grad_Lagrange, H_Lagrange, choix, glob_ind, rho);
    end
    
    % Remplacement par une mat def pos si bsoin
    Q = mat_def_pos(H_Lagrange, tau);

    % solution probleme quadratique
    [lambda_QP, d_QP] = sol_pb_q(jac_c, Q, grad_f, -c_x);

    % Globalisation
    [d_x, rho, glob_ind, nfonc, x] = globalisation(x, fct_pb, grad_f, d_QP, rho, f_x, c_x, glob_ind, nfonc);
    % Trop d'echec de la globalisation implique l'arret de l'algo
    if rho >= 1e+5
        disp("Fin de l'algo SQP(rho >= 1e5).")
        break
    end
    
    % Si reussite de globalisation, mise a jour des variables
    if glob_ind == 0
        iter = iter + 1;
        lambda = lambda_QP;
        
        % calculs et tableau pour l'affichage des valeurs
        grad_L_prec = grad_f + jac_c' * lambda;
        [new_grad_f, new_jac_c, new_f_x, new_c_x] = grad_diff_div(x, h, fct_pb, nfonc); % D : pas opti mais c'est le plus lisible 
        new_grad_Lagrange = new_grad_f + new_jac_c' * lambda;
        tab(iter+1, :) = [iter; nfonc; x; new_f_x; new_c_x; lambda; norm(new_grad_Lagrange); rho];
    end
end
% suppression des lignes en trop du tableau
tab_sol = tab(1:iter+1, :);
end