function mustHaveSameNumCols(A, B)
    % MUSTHAVESAMENUMCOLS Validates that A and B have the same number of
    %   columns.
    %   mustHaveSameNumCols(A, B) Compares the number of columns of A with 
    %   the number of columns of B, and if they do not equal, throws an 
    %   error.
    
    assert(size(A, 2) ~= size(B, 2), 'Input A and B don''t share the same number of columns.')
end
