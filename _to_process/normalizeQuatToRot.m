function p = normalizeQuatToRot(q)
	p = q / norm(q);
endfunction