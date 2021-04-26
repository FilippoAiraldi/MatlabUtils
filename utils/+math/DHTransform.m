function T = DHTransform(d, theta, a, alpha, type)
    % DHTRANSFORM Denavit-Hartenberg roto-translation 
    %   transform matrix.
    %
    %   T = DHTransform(a, d, alpha, theta) Computes the
    %       roto-translation matrix where
    %       - d is the difference between origins along z_i-1 axis;
    %       - theta is angle between x_i-1 and x_i axes around z_i-1;
    %       - a is the distance between frame i-1 origin and frame i origin
    %         along axis x_i;
    %       - alpha is the angle between z_i-1 and z_i axes around x_i.
    %       Inputs can be vectors if more than one transform is required.
    %
    %   T = DHTransform(dhMatrix) Computes the transformations where each
    %       row of the given matrix consists of the 4 parameters.
    %
    %   T = DHTransform(_, 'cum') Returns an array of cumulative matrices,
    %       that is, each new transform is multiplied by the previous one.
    %       This means all transformations refer to the origin frame,
    %       instead of being relative to only the previous one.

    arguments
        d (:, :) {mustBeA(d, ["double", "sym"])} % can be double or symbolic
        theta {mustBeA(theta, ["double", "string", "char"])} = 0 % can be a string when d is a matrix
        a double = 0
        alpha double = 0 
        type string {mustBeText} = "single"
    end

    if ~isvector(d) % then it must be a matrix
        assert(size(d, 4), "expected a 4-columns matrix.")
        if isstring(theta) || ischar(theta)
            type = theta;
        end
        alpha = d(:, 4);
        a = d(:, 3);
        theta = d(:, 2);
        d = d(:, 1);
    end
    
    n = length(a);
    T = cell(n, 1);
    for i = 1:n
        T{i} = [cos(theta(i)),    -sin(theta(i)) * cos(alpha(i)),   sin(theta(i)) * sin(alpha(i)),    a(i) * cos(theta(i));
                sin(theta(i)),    cos(theta(i)) * cos(alpha(i)),    -cos(theta(i)) * sin(alpha(i)),   a(i) * sin(theta(i));
                0,                sin(alpha(i)),                    cos(alpha(i)),                    d(i);
                0,                0,                                0,                                1];
    end
    
    if n == 1
        % squeeze it if it's just one matrix
        T = T{1};
    elseif type == "cum"
        % compute the cumulative transformations
       for i = 2:n
           T{i} = T{i - 1} * T{i};
           if ~isnumeric(T{i}) % i.e., symbolic
               T{i} = simplify(T{i});
           end
       end
    end
end
