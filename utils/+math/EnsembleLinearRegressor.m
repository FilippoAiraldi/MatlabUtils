classdef EnsembleLinearRegressor
    % ENSEMBLELINEARREGRESSOR Ensemble of linear regressors.
    
    properties (SetAccess = protected, GetAccess = public)
        % matrix of input features for training.
        X (:, :) double 
        % vector of output variable for training.
        y (:, 1) double {mustBeVector}
        % matrix telling which law to use for each measurement
        indexer (:, 1) uint8 {mustBeVector, mustBeNumeric}
        % collection of linear estimators
        regressors cell
        % coefficient of determination for training data.
        R2 (1, 1) double
        % root mean squaread error for training data.
        RMSE (1, 1) double 
    end
    
    methods
        function obj = EnsembleLinearRegressor(X, y, indexer, method)
            % LINEARREGRESSOR Constructs and fits a LinearRegressor on the
            % input variables X and output variable y.
            % 
            %   - X {matrix}: matrix of input features for training.
            %   - y {col vector}: vector of the output feature for training.
            %   - indexer {vector}: a vector that, for each measurement row
            %       of the features X, reports the index of the linear 
            %       law that that sample should obey to.
            %   - method {string}: method for computing optimal values.
            
            arguments 
                X (:, :) double
                y (:, 1) double {mustBeVector, mustHaveSameDims(X, y, 1)} 
                indexer (:, 1) uint8 {mustBeVector, mustBeNumeric, mustHaveSameDims(y, indexer, 1), mustBeGreaterThanOrEqual(indexer, 1)}
                method string {mustBeText} = "inv"
            end
            
            obj.X = X;
            obj.y = y;   
            obj.indexer = indexer;
            
            n_regressors = max(obj.indexer);
            if n_regressors == 1
                warning('only one regressor requested in the indexer. Use a single math.LinearRegressor instead.')
            end
            obj.regressors = cell(n_regressors, 1);
            
            % train each regressor
            for i = 1:n_regressors
                ii = obj.indexer == i;
                assert(any(ii), 'invalid indexer and training data: no data to train some estimators.')
                xi = obj.X(ii, :);
                yi = obj.y(ii);
                obj.regressors{i} = math.LinearRegressor(xi, yi, method);
            end
            
            % compute global R2 and RMSE
            y_pred = obj.predict(obj.X, obj.indexer);
            obj.R2 = math.rSquared(obj.y, y_pred);
            obj.RMSE = math.RMSE(obj.y, y_pred);
        end
        
        function y = predict(mdl, X, indexer)
            % PREDICT Performs prediction via linear regression.
            %
            %   y = predict(mdl, X) Computes the predictions based on the
            %       input variables X through the linear regressor mdl.
            %
            %   - mdl {LinearRegressor}: predictor.
            %   - X {matrix}: matrix of input features.
            %   - indexer {vector}: a vector that, for each measurement row
            %       of the features X, reports the index of the linear 
            %       law that that sample should obey to.
            
            arguments
                mdl (1, 1) {mustBeA(mdl, 'math.EnsembleLinearRegressor')}
                X (:, :) double
                indexer (:, 1) uint8 {mustBeVector, mustBeNumeric, mustHaveSameDims(X, indexer, 1), mustBeGreaterThanOrEqual(indexer, 1)}
            end
            assert(length(mdl.regressors) >= max(indexer), 'invalid indexer; refers to an ensemble larger than the current.')
            
            y = zeros(length(indexer), 1);
            for i = 1:length(mdl.regressors)
                ii = indexer == i;
                xi = X(ii, :);
                y(ii) = mdl.regressors{i}.predict(xi);
            end
        end
    end
end

