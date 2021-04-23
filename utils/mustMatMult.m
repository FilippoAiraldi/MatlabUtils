function mustMatMult(A, B)
    % MUSTMATMULT Validates that A and B can be multiplied as matrices.
    %   mustMatMult(A, B) Compares the number of columns of A with
    %   the number of rows of B, and if they do not equal, throws an error.
    
    assert(size(A, 2) == size(B, 1), 'input A and B cannot be matrix-multiplied.')
end
