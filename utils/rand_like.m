function a = rand_like(b)
    % RAND_LIKE Array of ones with same size.
    %
    %   a = rand_like(b) Creates a matrix/array of random numbers
	%		with the same shape and type as b.
	
	a = rand(size(b), 'like', b);
end
