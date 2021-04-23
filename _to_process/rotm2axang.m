function a = rotm2axang(M)	
  a = quat2axang(rotm2quat(normalizeMatrixToRot(M)));
endfunction