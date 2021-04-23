function M = invRotoTransl(T) 
    % INVROTOTRANS Invert roto-translation matrixes.
    % 
    %   M = invRotoTransl(T) Inverts roto-translation transform matrix T.
    
    arguments 
        T (4, 4) {mustBeA(T, ["double", "sym"])} % can be double or symbolic
    end
    
    M = [T(1:3, 1:3)', -T(1:3, 1:3)' * T(1:3, 4); 0 0 0 1];
end
