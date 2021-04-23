function M = rotm(seq, ang)
  seq = toupper(seq);
  M = eye(3);
  for i = 1:3
    if (seq(i) == 1 || seq(i) == 'X')
      M = M * rotX(ang(i));
    elseif (seq(i) == 2 || seq(i) == 'Y')
      M = M * rotY(ang(i));
    elseif (seq(i) == 3 || seq(i) == 'Z')
      M = M * rotZ(ang(i));
	  else
	    error("input sequence is impossible"),
    endif
  endfor
endfunction
