function M = rot2d(a)
    % ROT2D 2D Rotation matrix around the z-axis.
    %
    %   M = ROT2D(a) Returns the matrix describing a 2D rotation around 
    %       the z-axis of 'a' radians.
    
    arguments
        a (:, 1) {mustBeVector, mustBeA(a, ["double", "sym"])} % can be double or symbolic
    end
    
    n = length(a);
    M = cell(n, 1);
    for i = 1:n
        ca = cos(a(i));
        sa = sin(a(i));
        M{i} = [ca -sa; sa ca];
    end
    
    if n == 1
        % squeeze it if it's just one matrix
        M = M{1};
    end
end
