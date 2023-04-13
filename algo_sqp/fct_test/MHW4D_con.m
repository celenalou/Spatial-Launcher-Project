% D.UY
%Cas test 1 MHW4D : diapo p.25
function [c] = MHW4D_con(x)
c = zeros(3,1);
c(1) = x(1) + x(2)^2 + x(3)^2 - 3*sqrt(2) -2;
c(2) = x(2) - x(3)^2 + x(4) - 2*sqrt(2) +2;
c(3) = x(1)*x(5) -2;
end