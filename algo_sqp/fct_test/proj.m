function [x_arrivee] = proj(x_depart)
borne_inf = [-2;1;0;-3;-3];
borne_sup = [0;3;2;0;-1];
x_temp = max(x_depart, borne_inf);
x_arrivee = min(x_temp, borne_sup);
end

