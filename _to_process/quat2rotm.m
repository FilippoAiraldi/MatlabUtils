function R = quat2rotm(q)
  
  q = normalizeQuatToRot(q);
  
  s = norm(q)^(-2);
  qr = q(1);	# a
  qi = q(2);	# b
  qj = q(3);	# c
  qk = q(4);	# d
  R = zeros(3, 3);
  
  R(1, 1) = 1 - 2 * s * (qj^2 + qk^2);
  R(1, 2) = 2 * s * (qi * qj - qk * qr);
  R(1, 3) = 2 * s * (qi * qk + qj * qr);
  
  R(2, 1) = 2 * s * (qi * qj + qk * qr);
  R(2, 2) = 1 - 2 * s * (qi^2 + qk^2);
  R(2, 3) = 2 * s * (qj * qk - qi * qr);
  
  R(3, 1) = 2 * s * (qi * qk - qj * qr);
  R(3, 2) = 2 * s * (qk * qj + qi * qr);
  R(3, 3) = 1 - 2 * s * (qj^2 + qi^2);
endfunction