function q = rotm2quat(M)
	q = zeros(4, 1);
	# q(1) = sqrt(1 + M(1, 1) + M(2, 2) + M(3, 3)) / 2;
	# q(2) = (M(3, 2) - M(2, 3)) / (4 * q(1));
	# q(3) = (M(1, 3) - M(3, 1)) / (4 * q(1));
	# q(4) = (M(2, 1) - M(1, 2)) / (4 * q(1));
	
  M = normalizeMatrixToRot(M);
	r = sqrt(1 + trace(M));
	q(1) = 0.5 * r;
	q(2) = copySign(0.5 * sqrt(1 + M(1, 1) - M(2, 2) - M(3, 3)), M(3, 2) - M(2, 3));
	q(3) = copySign(0.5 * sqrt(1 - M(1, 1) + M(2, 2) - M(3, 3)), M(1, 3) - M(3, 1));
	q(4) = copySign(0.5 * sqrt(1 - M(1, 1) - M(2, 2) + M(3, 3)), M(2, 1) - M(1, 2));
endfunction