function f = fullscreenFigure()
    f = get(groot,'CurrentFigure');
    if ~isempty(f)
        f.Units = 'normalized';
        f.OuterPosition = [0 0 1 1];
    else
        f = figure('units', 'normalized', 'outerposition', [0 0 1 1]);
    end
end
