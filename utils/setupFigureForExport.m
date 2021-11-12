function setupFigureForExport(fig)
    % SETUPFIGUREFOREXPORT Better looking figures for export.
    %
    %   setupFigureForExport(fig) For the given figure or current figure, 
    %       moves legend location, removes grids and removes boxes around 
    %       axes and legends.
	
    if ~exist('NAME','var')
        fig = gcf();
    end

    % get legends and axes
    hLegends = findobj(fig, 'Type', 'Legend');
    hAxes = findobj(fig, 'Type', 'Axes');

    % set legend location to northeastoutside and switch boxes off
    locations = repmat({'northeastoutside'}, 1, numel(hLegends));
    switch_off = repmat({'off'}, 1, numel(hLegends));
    [hLegends.Location] = deal(locations{:});
    [hLegends.Box] = deal(switch_off{:});

    % switch axis box off and grid
    [hAxes.Box]   = deal(switch_off{:});
    [hAxes.XGrid] = deal(switch_off{:});
    [hAxes.YGrid] = deal(switch_off{:});
    [hAxes.ZGrid] = deal(switch_off{:});
end