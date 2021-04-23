function [X_train, y_train, X_valid, y_valid] = trainValidSplit(X, y, valid_pc) 
    % TRAINVALIDSPLIT Training-validation dataset split.
    % [X_train, y_train, X_valid, y_valid] = trainValidSplit(X, y, valid_pc)
    %   Randomly splits the items into a training and validation set, with 
    %   a given percentage of proportions between the two.
    
    arguments 
       X (:, :)
       y (:, :) = []
       valid_pc (1, 1) double {mustBeInRange(valid_pc, 0, 1)} = 0.2
    end
    
    N = size(X, 1);
    k = floor(valid_pc * N);
    train_idx = randperm(N, N - k);
    valid_idx = setdiff(1:N, train_idx);
    
    X_train = X(train_idx, :);
    X_valid = X(valid_idx, :);
    
    if isempty(y)
        y_train = [];
        y_valid = [];
    else
        y_train = y(train_idx, :);
        y_valid = y(valid_idx, :);
    end
    
%     N = length(items);
%     k = floor(valid_pc * N);
%     train_idx = randperm(N, N - k);
%     train = items(train_idx);
%     valid = setdiff(items, train);   
end
