function a = zeros_like(b)
    % ZEROS_LIKE Array of zeros with same size.
    %
    %   a = ZEROS_LIKE(b) Creates a matrix/array of zeros
	%		with the same shape and type as b.
	
	a = zeros(size(b), 'like', b);
end
