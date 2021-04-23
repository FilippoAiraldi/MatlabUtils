function a = eul2quat(seq, eul, dstseq)
	a = rotm2eul(dstseq, rotm(seq, eul));
endfunction