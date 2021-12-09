function a = nan_like(b)
    % NAN_LIKE Array of zeros with same size.
    %
    %   a = NAN_LIKE(b) Creates a matrix/array of NaNs
	%		with the same shape and type as b.
	
	a = nan(size(b), 'like', b);
end
