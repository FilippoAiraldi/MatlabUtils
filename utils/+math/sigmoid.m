function y = sigmoid(x) 
    % SIGMOID Sigmoid function.
    % y = sigmoid(x) Computes the sigmoid of the input as 1 / (1 + e^-x).
   
    y = 1 ./ (1 + exp(-x));
end
