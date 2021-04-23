function b = normalizeAxangToRot(a)
	b(1:3) = a(1:3) / norm(a(1:3));
	b(4) = rem(a(4), 2 * pi);
endfunction