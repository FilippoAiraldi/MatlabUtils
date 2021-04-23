function a = quat2axang(q)
  if (~isvector(q))
    error("Input must be vectorial"),
  endif
  if (length(q) ~= 4)
    error("Input vector must have 4 elements"),
  endif
  
  q = normalizeQuatToRot(q);
  
  a = zeros(4, 1);
  
   # a(4) = 2 * acos(q(1));
   a(4) = 2 * atan2(norm(q(2:4)), q(1));
   if (a(4) == 0)
     return  # it returns a = [0 0 0 0]
   endif
   s = sin(a(4) / 2);
   a(1) = q(2) / s;
   a(2) = q(3) / s;
   a(3) = q(4) / s; 
endfunction
