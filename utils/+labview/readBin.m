function data = readBin(path, nrows)
    % labview.readBin Reads double data from a bin file.
    %
    %   data = labview.readBin(path) Reads the given bin file.
    %
    %   _ = labview.readBin(_, nrows) Number of rows of data to read. If
    %       not provided, the method assumes that the file has a header
    %       containing the variable names.


    arguments
        path string {mustBeFile}
        nrows (1, 1) {mustBeInteger} = -1
    end   
    
    % open file
    fid = fopen(path, 'r', 's'); 
    
    if nrows == -1
        % read length of names in the first 4 bytes of the file
        names_bytes = fread(fid, 1, 'uint16');

        % variable names 
        names = fread(fid, names_bytes, '*char'); % alredy offset by previous fread - do not impose a manual offset for reading variable names
        data.names = splitlines(convertCharsToStrings(names));

        % read doubles
        data.values = fread(fid, [length(names) Inf], 'double'); % again, do not offset manually
    else
        data.values = fread(fid, [nrows Inf], 'double');
    end
    
    % close file
    fclose(fid);
end
