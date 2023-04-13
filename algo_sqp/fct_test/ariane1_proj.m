function x_arrivee = ariane1_proj(x_depart)
borne_inf = [100000; 10000; 1000];
borne_sup = [300000; 100000; 30000];
x_temp = max(x_depart, borne_inf);
x_temp = min(x_temp, borne_sup);
x_arrivee = x_temp;
end

