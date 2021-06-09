function mustHaveSameSize(A, B)
    % MUSTHAVESAMESIZE Validates that A and B share the same size.
    
    assert(all(size(A) == size(B), 'all'), 'input A and B must have same size.')
end
