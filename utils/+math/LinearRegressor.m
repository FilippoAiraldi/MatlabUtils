classdef LinearRegressor
    % LINEARREGRESSOR Linear regression model.
    
    properties (SetAccess = protected, GetAccess = public)
        % matrix of input features for training.
        X (:, :) double 
        % vector of output variable for training.
        y (:, 1) double {mustBeVector}
        % optimal linear coefficients.
        theta (:, 1) double {mustBeVector}
        % optimization method ("inv", "pinv", "rls").
        method string {mustBeText}
        % coefficient of determination for training data.
        R2 (1, 1) double
        % root mean squaread error for training data.
        rmse (1, 1) double 
    end
    
    methods
        function obj = LinearRegressor(X, y, method)
            % LINEARREGRESSOR(X, y, method) Constructs and fits a LinearRegressor on the input variables X and output variable y.
            % 
            %   - X {matrix}: matrix of input features for training.
            %   - y {col vector}: vector of the output feature for training.
            %   - method {string}: method for computing optimal values.

            arguments 
                X (:, :) double
                y (:, 1) double {mustBeVector,  mustHaveSameDims(X, y, 1)} 
                method string {mustBeText} = "inv"
            end

            obj.y = y;
            obj.X = [ones(length(y), 1), X];              
            
            method = lower(method);
            if method == "inv" && abs(det(obj.X' * obj.X)) < 0.00001
                obj.method = "pinv";
                warning("switching method to pinv due to matrix singularity.")
            else
                obj.method = method;
            end
            
            % compute linear coefficients
            obj.theta = obj.computeOptVals(obj.X, obj.y, obj.method);
            
            % compute fitting scores
            obj.R2 = math.rSquared(obj.y, obj.X * obj.theta);
            obj.rmse = math.rmse(obj.y, obj.X * obj.theta);
        end
        
        function y = predict(mdl, X)
            % PREDICT Performs prediction via linear regression.
            %
            %   y = predict(mdl, X) Computes the predictions based on the
            %       input variables X through the linear regressor mdl.
            %
            %   - mdl {LinearRegressor}: predictor.
            %   - X {matrix}: matrix of input features.
            
            arguments
                mdl (1, 1) {mustBeA(mdl, 'math.LinearRegressor')}
                X (:, :) double
            end
            
            X = [ones(size(X, 1), 1), X];
            mustMatMult(X, mdl.theta);
            
            y = X * mdl.theta;
        end
    end
    
    methods (Static = true, Access = protected)
        function theta = computeOptVals(X, y, method)
            switch method
                case "inv"
                    theta = X \ y;
                case "pinv"
                    theta = pinv(X' * X) * X' * y;
                case "rls"
                    theta = math.recursiveLeastSquares(X, y);
                otherwise
                    error("invalid linear regressor optimization method.")
            end
        end
    end
end
