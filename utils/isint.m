function flag = isint(x)
    % ISINT Check input is a double but with no floating points.
       
    % flag = all(rem(x, 1) == 0, 'all');
    flag = all(floor(x) == x, 'all'); % a tad bit faster
end
