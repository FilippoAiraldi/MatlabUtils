function theta = recursiveLeastSquares(X, y, theta0, alpha)
    % RECURSIVELEASTSQUARES Least-squares optimization in recursive form.
    %
    %   theta = recursiveLeastSquares(X, y, theta0, alpha) Computes the
    %       optimal linear coefficients theta between X and y.
    %
    %   - X {matrix}: matrix of input features.
    %   - y {vector}: vector of output.
    %   - theta0 {scalar, vector, optional}: initial estimate of theta.
    %   - alpha {int, optional}: learning rate of algorithm.
    
    arguments
        X (:, :) double
        y (:, 1) double {mustBeVector, mustHaveSameNumRows(X, y)}
        theta0 (:, 1) double {mustBeVector, mustMatMult(X, theta0)} = zeros(size(X, 2), 1)
        alpha (1, 1) double {mustBePositive} = 1
    end
    
    % RLS - 3
    theta = theta0;
    V = eye(length(theta)) * alpha;
    for t = 2:size(X, 1)
        psi = X(t, :)';
        V = V - V * (psi * psi') * V ./ (1 + psi' * V * psi);
        e = y(t) - psi' * theta;
        theta = theta + V * psi * e;
    end
end
