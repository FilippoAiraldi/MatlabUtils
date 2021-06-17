function data = readBin(path, nrows, ids)
    % labview.readBin Reads double data from a bin file.
    %
    %   data = labview.readBin(path) Reads the given bin file. The method
    %       scans the start of the file for the header containing the names
    %       of each variable saved in the bin. If no header is present,
    %       read below.
    %
    %   _ = labview.readBin(_, nrows, ids) Specifies the number of rows of 
    %       data to read. If not provided, the method seearches how many
    %       variable names are in the header and uses that as rows.
    %       Additionally, it is possible to specify an id/name for each 
    %       signal.
 
    mustBeFile(path);
    
    % open file
    fid = fopen(path, 'r', 's'); 

    if nargin < 2
        % read length of names in the first 2 bytes of the file
        names_bytes = fread(fid, 1, 'uint16');

        % variable names 
        names = fread(fid, names_bytes, '*char'); % alredy offset by previous fread - do not impose a manual offset for reading variable names
        ids = splitlines(convertCharsToStrings(names));

        % read doubles
        values = fread(fid, [length(ids) Inf], 'double'); % again, do not offset manually
    else
        if nargin >= 3
            assert(nrows == length(ids), 'ids must be in the same number of rows')
        end
        values = fread(fid, [nrows Inf], 'double');
    end
    
    % close file
    fclose(fid);
    
    % convert to struct if necessary
    if ~exist("ids", "var")
        data = values;
    else
        ids = matlab.lang.makeValidName(ids);
        for i = 1:length(ids)
            id = ids{i};
            if id(end) == '_'
                id = id(1:end - 1);
            end
            data.(id) = values(i, :);
        end
    end
end
