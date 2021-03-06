function a = ones_like(b)
    % ONES_LIKE Array of ones with same size.
    %
    %   a = ONES_LIKE(b) Creates a matrix/array of ones
	%		with the same shape and type as b.
	
	a = ones(size(b), 'like', b);
end
