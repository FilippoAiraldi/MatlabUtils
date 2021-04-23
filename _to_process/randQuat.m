function q = randQuat()
  z = 2;
  while (z > 1)
    x = rand * 2 - 1;
    y = rand * 2 - 1;
    z = x^2 + y^2;
  endwhile
  w = 2;
  while (w > 1)
    u = rand * 2 - 1;
    v = rand * 2 - 1;
    w = u^2 + v^2;
  endwhile
  s = sqrt((1 - z) / w);
  q = [x, y, s*u, s*v]';
endfunction