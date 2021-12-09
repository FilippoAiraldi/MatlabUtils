function p = cartesianProd(varargin)
    % CARTESIANPROD Cartesian product of multiple vectors.
    %
    % p = CARTESIANPROD(v1, ..., vn) Computes the cartesian product between
    %   the elements of v1, v2, ..., vn.

    arguments (Repeating)
        varargin (:, 1) double
    end

    grids = cell(1, length(varargin));
    [grids{:}] = ndgrid(varargin{:});

    N = numel(grids{1});
    p = zeros(N, length(grids));
    for i = 1:size(p, 2)
        p(:, i) = grids{i}(:);
    end
end