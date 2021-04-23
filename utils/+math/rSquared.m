function r2 = rSquared(y_act, y_pred)
    % RSQUARED Coefficient of determination.
    %
    %   rmse = rSquared(y_act, y_pred) Computes the coefficient of
    %       determination between y_act and y_pred.
    %
    %   - y_act {vector}: vector of actual values.
    %   - y_pred {vector}: vector of predicted values.    

    arguments 
        y_act (:, 1) double {mustBeVector}
        y_pred (:, 1) double {mustBeVector, mustHaveSameNumRows(y_act, y_pred)}
    end
    
    ss_tot = sum((y_act - y_pred).^2);
    r2 = 1 - ss_tot / sum((y_act - mean(y_act)).^2);
end
