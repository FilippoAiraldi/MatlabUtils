function M = rotX(a)
    % ROTX Rotation matrix around the x-axis.
    %
    %   M = ROTX(a) Returns the matrix describing a rotation around 
    %       the x-axis of 'a' radians.
    
    arguments
        a (:, 1) {mustBeVector, mustBeA(a, ["double", "sym"])} % can be double or symbolic
    end
    
    n = length(a);
    M = cell(n, 1);
    for i = 1:n
        ca = cos(a(i));
        sa = sin(a(i));
        M{i} = [1 0 0; 0 ca -sa; 0 sa ca];
    end
    
    if n == 1
        % squeeze it if it's just one matrix
        M = M{1};
    end
end
