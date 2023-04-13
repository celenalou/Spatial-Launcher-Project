function [lambda_QP, d_QP] = sol_pb_q(A, Q, g, b)
    inv_Q = inv(Q);
    lambda_QP = - inv(A * inv_Q * A') * (A * inv_Q * g + b);
    d_QP = - inv_Q * (A' * lambda_QP + g);
end

