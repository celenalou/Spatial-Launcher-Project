function [M_0] = ariane1(m)
global m_s; % nécessaire pour le simulateur et PT
%mu = 1700; % pour algo SQP

mu = 1500; % pour le simulateur
k = [0.10; 0.15; 0.20];
m_s = k .* m;
M_0 = mu + (1+k(3)) * m(3) + (1+k(2)) * m(2) + (1+k(1)) * m(1);

end