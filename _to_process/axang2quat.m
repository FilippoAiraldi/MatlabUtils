function q = axang2quat(a)
  if (~isvector(a))
    error("Input must be vectorial"),
  endif
  if (length(a) ~= 4)
    error("Input vector must have 4 elements"),
  endif
  
  if (norm(a(1:3)) == 0 || a(4) == 0)
    q = [1 0 0 0]';
    return
  endif
  
  a = normalizeAxangToRot(a);
  
  c = cos(a(4) / 2);
  s = sin(a(4) / 2);
  q = [c; a(1) * s; a(2) * s; a(3) * s];
endfunction
