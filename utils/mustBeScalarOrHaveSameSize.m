function mustBeScalarOrHaveSameSize(A, B)
    % MUSTBESCALARORHAVESAMESIZE Validates that A is scalar or that shares 
    %   size with B.
    
    assert(isscalar(A) || isequal(size(A), size(B)), ...
        'input A must be scalar or have same size as B.')
end
