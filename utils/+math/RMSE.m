function rmse = RMSE(y_act, y_pred)
    % RMSE Root mean square error.
    %
    %   e = RMSE(y_act, y_pred) Computes the root mean square error
    %       between y_act and y_pred.
    %
    %   - y_act {vector}: vector of actual values.
    %   - y_pred {vector}: vector of predicted values.
    
    arguments 
        y_act (:, 1) double {mustBeVector}
        y_pred (:, 1) double {mustBeVector, mustHaveSameDims(y_act, y_pred, 1)}
    end
    
    ss_tot = sum((y_act - y_pred).^2, 'omitnan');
    rmse = sqrt(ss_tot / length(y_act));
end
