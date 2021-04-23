function R = normalizeMatrixToRot(M)
	if (~all(size(M) == [3 3]))
		error('Matrix is not 3x3.')
	endif
  
  X = M(:, 1);
  Y = M(:, 2);
  Z = M(:, 3);
  
  exy = sum(X .* Y);
  exz = sum(X .* Z);
  eyz = sum(Y .* Z);
  
  Xort = X - (exy / 2 * Y) - (exz / 2 * Z);
  Yort = Y - (exy / 2 * X) - (eyz / 2 * Z);
  Zort = Z - (exz / 2 * X) - (eyz / 2 * Y);
  
  R = [Xort / norm(Xort), Yort / norm(Yort), Zort / norm(Zort)];
endfunction