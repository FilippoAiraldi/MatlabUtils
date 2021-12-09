function mustBeScalarOrHaveSameDims(A, B, n, m)
    % MUSTBESCALARORHAVESAMEDIMS Validates that A is scalar or A and B have
    %   the same size along the specified dimensions n and m, respectively.
	%
    %   MUSTBESCALARORHAVESAMEDIMS(A, B, n, m) A must be a scalar; 
    %       otherwise, compares the size along the n-th dimension of A with
    %       that along the m-th dimension of B, and if they do not equal, 
    %       throws an error.
    %   
    %   MUSTBESCALARORHAVESAMEDIMS(A, B, n) A must be a scalar; otherwise, 
    %       compares sizes of A and B along the same dimension n.
    
    if ~isscalar(A)
        mustHaveSameDims(A, B, n, m)
    end
end
