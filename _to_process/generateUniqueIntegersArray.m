function v = generateUniqueIntegersArray(MIN, MAX, N)   # N <= MAX - MIN + 1    -->    N + MIN - 1 <= MAX
  if (N <= 0)
    error("--- ERROR --- Input N must be a positive integer."),
  endif
  if (MAX < N + MIN - 1)
    error("--- ERROR --- Input MAX must be larger than or equal to (MIN + N - 1)"),
  endif
  
  if (MAX == N + MIN - 1)
    v = MIN:MAX;
    return
  endif
  
  cnt = 0;
  v = [];
  while (cnt < N)
    r = randi(MAX - MIN + 1) + MIN - 1;
    notAlreadyFound = true;
    for i = 1:length(v)
      if (v(i) == r)
        notAlreadyFound = false;
        break
      endif
    endfor
    if (notAlreadyFound)
      v = [v, r];
      cnt = cnt + 1;
    endif
  endwhile
  v = sort(v);
  
endfunction