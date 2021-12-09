function M = rotY(a)
    % ROTY Rotation matrix around the y-axis.
    %
    %   M = ROTY(a) Returns the matrix describing a rotation around 
    %       the y-axis of 'a' radians.
    
    arguments
        a (:, 1) {mustBeVector, mustBeA(a, ["double", "sym"])} % can be double or symbolic
    end
    
    n = length(a);
    M = cell(n, 1);
    for i = 1:n
        ca = cos(a(i));
        sa = sin(a(i));
        M{i} = [ca 0 sa; 0 1 0; -sa 0 ca];
    end
    
    if n == 1
        % squeeze it if it's just one matrix
        M = M{1};
    end
end
