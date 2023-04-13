function [y] = f_merite(x, fc, rho)
% fc est un cell_array (vecteur contenant des objects quelconques)
% fc contient ici nos fonctions f et c
con = fc{2}(x);
f = fc{1}(x);
y = f + rho * norm(con, 1);
end

