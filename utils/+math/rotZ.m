function M = rotZ(a)
    % ROTZ Rotation matrix around the x-axis.
    %
    %   M = rotZ(a) Returns the matrix describing a rotation around 
    %       the z-axis of 'a' radians.
    
    arguments
        a (:, 1) {mustBeVector, mustBeA(a, ["double", "sym"])} % can be double or symbolic
    end
    
    n = length(a);
    M = cell(n, 1);
    for i = 1:n
        ca = cos(a(i));
        sa = sin(a(i));
        M{i} = [ca -sa 0; sa ca 0; 0 0 1];
    end
    
    if n == 1
        % squeeze it if it's just one matrix
        M = M{1};
    end
end
