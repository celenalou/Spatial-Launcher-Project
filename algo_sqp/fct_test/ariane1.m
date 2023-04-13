function [M_0] = ariane1(m)
mu = 1700; % pour algo SQP
%mu = 1500; % pour le simulateur
M_0 = mu + 1.2154 * m(3) + 1.1532 * m(2) + 1.1101 * m(1);
end

