function markers = read(kinovea_xlsx)
    % kinovea.read Reads markers data from a Kinovea .xlsx. 
    %
    %   markers = kinovea.read(kinovea_xlsx) Reads the given xlsx file.

    % FIND REFERENCE POINTS (read table in char mode)
    opts = spreadsheetImportOptions(...
            'NumVariables', 3, ...
            'VariableNames', {'row1', 'row2', 'row3'}, ...
            'VariableTypes', {'char', 'char', 'char'}, ...
            'DataRange', 'A1');
    T = readtable(kinovea_xlsx, opts);

    % FIND REFERENCE POINTS COORDINATES
    findPointLabel = find(ismember(T{:, 1}, 'Points'));
    if ~isempty(findPointLabel)
        for i = 1:length(findPointLabel)
            pointName = char(T{findPointLabel(i) + 2, 1});
            coorValue = [str2double(cell2mat(T{findPointLabel + 2, 2})), str2double(cell2mat(T{findPointLabel + 2, 3}))];
            markers.(pointName) = coorValue;
        end
    end

    % FIND MARKERS POINTS TRAJECTORY (read table in double mode)
    headerRow = 4;
    findTrackLabel = find(ismember(T{:, 1}, 'Track'));
    markerName = T{(find(ismember(T{:, 1}, 'Label :'))), 2};
    markerTableStarts = findTrackLabel + headerRow;
    markerTableEnds = [findTrackLabel(2:end) - 2; height(T)];
    numMarker = length(markerTableStarts);
    if ~isempty(findTrackLabel)
        for i = 1:numMarker
            dataStartLoc = [markerTableStarts(i), markerTableEnds(i)];
            opts = spreadsheetImportOptions(...
                'NumVariables', 3,...
                'VariableNames', {'x', 'y', 'time'},...
                'VariableTypes', {'double', 'double', 'double'},...
                'DataRange', dataStartLoc);
            tempT = readtable(kinovea_xlsx, opts);
            markers.(markerName{i}) = table2struct(tempT, 'ToScalar', true);
        end
    elseif isempty(findTrackLabel)
        warning('No markers found')
    end
end
