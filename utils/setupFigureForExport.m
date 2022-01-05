function setupFigureForExport(fig)
    % SETUPFIGUREFOREXPORT Better looking figures for export.
    %
    %   SETUPFIGUREFOREXPORT(fig) For the given figure or current figure, 
    %       moves legend location, removes grids and removes boxes around 
    %       axes and legends.
	
    if ~exist('fig', 'var')
        fig = gcf();
    end

    % set legend location to northeastoutside and switch boxes off
    hLegends = findobj(fig, 'Type', 'Legend');
    N = numel(hLegends);
    if N > 0
        locations = repmat({'northeastoutside'}, 1, N);
        switch_off = repmat({'off'}, 1, N);
        [hLegends.Location] = deal(locations{:});
        [hLegends.Box] = deal(switch_off{:});
    else
        warning('no legend found.')
    end

    % switch axis box off and grid
    hAxes = findobj(fig, 'Type', 'Axes');
    N = numel(hAxes);
    if N > 0
        switch_off = repmat({'off'}, 1, N);
        [hAxes.Box]   = deal(switch_off{:});
        [hAxes.XGrid] = deal(switch_off{:});
        [hAxes.YGrid] = deal(switch_off{:});
        [hAxes.ZGrid] = deal(switch_off{:});
    else
        warning('no axis found.')
    end
end