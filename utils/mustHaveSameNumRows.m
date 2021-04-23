function mustHaveSameNumRows(A, B)
    % MUSTHAVESAMENUMROWS Validates that A and B have the same number of
    %   rows.
    %   mustHaveSameNumRows(A, B) Compares the number of rows of A with
    %   the number of rows of B, and if they do not equal, throws an error.
    
    assert(size(A, 1) == size(B, 1), 'Input A and B don''t share the same number of rows.')
end
