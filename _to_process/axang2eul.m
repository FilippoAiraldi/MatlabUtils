function eul = axang2eul(seq, a)
  if (~isvector(a))
    error("Input must be vectorial"),
  endif
  if (length(a) ~= 4)
    error("Input vector must have 4 elements"),
  endif
  
  if (norm(a(1:3)) == 0 || a(4) == 0)
    eul = zeros(3, 1);
    return
  endif
  
  eul = quat2eul(seq, axang2quat(normalizeAxangToRot(a)));
endfunction
