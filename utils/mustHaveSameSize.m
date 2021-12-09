function mustHaveSameSize(A, B)
    % MUSTHAVESAMESIZE Validates that A and B share the same size.
    
    assert(isequal(size(A), size(B)), 'input A and B must have same size.')
end
