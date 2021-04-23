function eul = rotm2eul(seq, M)
  if (~isvector(seq) || length(seq) != 3)
    error('rotation sequence must be a 3-element vector.'),
  endif
  
  M = normalizeMatrixToRot(M);
  eul = zeros(3, 1);
  r00 = M(1, 1);
  r01 = M(1, 2);
  r02 = M(1, 3);
  r10 = M(2, 1);
  r11 = M(2, 2);
  r12 = M(2, 3);
  r20 = M(3, 1);
  r21 = M(3, 2);
  r22 = M(3, 3);
  
  seq = toupper(seq);
  for i = 1:length(seq)
    if (seq(i) == 1 || seq(i) == 'X')
      seq(i) = 'X';
    elseif (seq(i) == 2 || seq(i) == 'Y')
      seq(i) = 'Y';
    elseif (seq(i) == 3 || seq(i) == 'Z')
      seq(i) = 'Z';
    else
	    error("input sequence is impossible"),
    endif
  endfor
  
  switch (seq)
    case 'XYZ'   
      eul(1) = atan2(-r12, r22);
	    eul(2) = atan2(r02, sqrt(r12^2 + r22^2));
      eul(3) = atan2(-r01, r00);
      
    case 'XZY'
      eul(1) = atan2(r21, r11);
	    eul(2) = atan2(-r01, sqrt(r00^2 + r02^2));
      eul(3) = atan2(r02, r00);
      
    case 'YXZ'
      eul(1) = atan2(r02, r22);
	    eul(2) = atan2(-r12, sqrt(r02^2 + r22^2));
      eul(3) = atan2(r10, r11);
      
    case 'YZX'
      eul(1) = atan2(-r20, r00);
	    eul(2) = atan2(r10, sqrt(r00^2 + r20^2));
      eul(3) = atan2(-r12, r11);
      
    case 'ZXY'
      eul(1) = atan2(-r01, r11);
	    eul(2) = atan2(r21, sqrt(r20^2 + r22^2));
      eul(3) = atan2(-r20, r22);
      
    case 'ZYX'
      eul(1) = atan2(r10, r00);
	    eul(2) = atan2(-r20, sqrt(r21^2 + r22^2));
      eul(3) = atan2(r21, r22);
      
    case 'XYX'
      if (r00 < 1)
        eul(1) = atan2(r10, -r20);
		    eul(2) = atan2(sqrt(r01^2 + r02^2), r00);
        eul(3) = atan2(r01, r02);
      else
        eul(1) = atan2(-r12, r11);
		    eul(2) = 0;
        eul(3) = 0;
      endif   
   
    case 'XZX'
      if (r00 < 1)
        eul(1) = atan2(r20, r10);
		    eul(2) = atan2(sqrt(r10^2 + r20^2), r00);
        eul(3) = atan2(r02, -r01);
      else
        eul(1) = atan2(r21, r22);
		    eul(2) = 0;
        eul(3) = 0;
      endif  
      
    case 'YXY'
      if (r11 < 1)
        eul(1) = atan2(r01, r21);
		    eul(2) = atan2(sqrt(r10^2 + r12^2), r11);
        eul(3) = atan2(r10, -r12);
      else
        eul(1) = atan2(r02, r00);
		    eul(2) = 0;
        eul(3) = 0;
      endif  
      
    case 'YZY'
      if (r11 < 1)
        eul(1) = atan2(r21, -r01);
		    eul(2) = atan2(sqrt(r10^2 + r12^2), r11);
        eul(3) = atan2(r12, r10);
      else
        eul(1) = atan2(-r20, r22);
		    eul(2) = 0;
        eul(3) = 0;
      endif  
      
    case 'ZXZ'
      if (r22 < 1)
        eul(1) = atan2(r02, -r12);
		    eul(2) = atan2(sqrt(r02^2 + r12^2), r22);
        eul(3) = atan2(r20, r21);
      else
        eul(1) = atan2(-r01, r00);
		    eul(2) = 0;
        eul(3) = 0;
      endif 
      
    case 'ZYZ'
      if (r22 < 1)
          eul(1) = atan2(r12, r02);
          eul(2) = atan2(sqrt(r20^2 + r21^2), r22)  ;
          eul(3) = atan2(r21, -r20);
        else
          eul(1) = atan2(r10, r11);
          eul(2) = 0;
          eul(3) = 0;
        endif 
    otherwise
      error("input sequence is impossible."),
  endswitch
endfunction