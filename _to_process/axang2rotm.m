function M = axang2rotm(a)	
  if (~isvector(a))
    error("Input must be vectorial"),
  endif
  if (length(a) ~= 4)
    error("Input vector must have 4 elements"),
  endif
  
  if (norm(a(1:3)) == 0 || a(4) == 0)
    M = eye(3);
    return
  endif
  
	M = quat2rotm(axang2quat(normalizeAxangToRot(a)));
endfunction