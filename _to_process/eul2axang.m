function a = eul2axang(seq, eul)
  a = quat2axang(eul2quat(seq, eul));
endfunction