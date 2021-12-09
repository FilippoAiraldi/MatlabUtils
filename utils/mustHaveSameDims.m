function mustHaveSameDims(A, B, n, m)
    % MUSTHAVESAMEDIMS Validates that A and B have the same size
    %   along the specified dimensions n and m, respectively.
    %
    %   MUSTHAVESAMEDIMS(A, B, n, m) Compares the size along the 
    %       n-th dimension of A with that along the m-th dimension of B, 
    %       and if they do not equal, throws an error.
    %   
    %   MUSTHAVESAMEDIMS(A, B, n) Compares sizes of A and B along
    %       the same dimension n.
    
    if nargin < 4
       m = n; 
    end
    
    sA = size(A, n);
    sB = size(B, m);
    assert(sA == sB, ...
        sprintf("Size of A along the %i-th dim is different from the size of B along the %i-th dim (%i vs %i).", ...
        n, m, sA, sB))
end
