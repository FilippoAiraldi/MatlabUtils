function q = eul2quat(seq, eul)
	seq = toupper(seq);
	q = [1 0 0 0]';
	for i = 1:3
	  if (seq(i) == 1 || seq(i) == 'X')
      q = quatProd(q, [cos(eul(i)/2) sin(eul(i)/2) 0 0]');  
    elseif (seq(i) == 2 || seq(i) == 'Y')
      q = quatProd(q, [cos(eul(i)/2) 0 sin(eul(i)/2) 0]');
    elseif (seq(i) == 3 || seq(i) == 'Z')
      q = quatProd(q, [cos(eul(i)/2) 0 0 sin(eul(i)/2)]');
    else
	    error("input sequence is impossible"),
    endif
	endfor 
endfunction