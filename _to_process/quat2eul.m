function a = quat2eul(seq, q)
  a = rotm2eul(seq, quat2rotm(normalizeQuatToRot(q)));
endfunction