function labels(varargin)
    % LABELS Array of zeros with same size.
    %
    % labels(xlbl, ylbl, zlbl) Adds x, y and even z labels to the axis of
    %   the current figure.
	
    L = length(varargin);
	assert(L == 2 || L == 3, 'inputs must be 2 or 3 axes labels.'),
    
    xlabel(varargin{1}), ylabel(varargin{2});
    if L == 3
        zlabel(varargin{3});
    end
end
