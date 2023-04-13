function x_arrivee = PT_proj(x_depart)
borne_inf = ones(4, 1) * -90; 
borne_sup = ones(4, 1) * 90;

%version pour theta0 et theta1_fixés
%borne_inf = ones(2, 1) * -90; 
%borne_sup = ones(2, 1) * 90;

x_temp = max(x_depart, borne_inf);
x_temp = min(x_temp, borne_sup);
x_arrivee = x_temp;

end

