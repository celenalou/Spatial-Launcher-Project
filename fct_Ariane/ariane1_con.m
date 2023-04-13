function [nabla_V] = ariane1_con(m)
global Vp; % nécessaire pour le simulateur et PT
%Vp = 11527; % exemple des slides 
%mu = 1700; % pour algo SQP

mu = 1500; % pour le simulateur
k = [0.10; 0.15; 0.20];
v_e = [2600; 3000; 4400];

M_f = [mu + (1 + k(3))*m(3) + (1 + k(2))*m(2) + k(1)*m(1) ; 
        mu + (1 + k(3))*m(3) + k(2)*m(2) ; 
        mu + k(3)*m(3)]; 
M_i = M_f + m;
nabla_V = v_e(1) * log(M_i(1)/M_f(1)) + v_e(2) * log(M_i(2)/M_f(2)) + v_e(3) * log(M_i(3)/M_f(3)) - Vp; 
end

