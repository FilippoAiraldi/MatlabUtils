function when(func_name)
    % WHEN(func_name) Check the date when the given function was introduced
    % by MATLAB. The input variable can be either a string or a cell 
    % containing different strings. The information are gathered from web. 
    %
    % Example 1:
    % >> when('rand')
    % ## rand is a built-in function (Introduced before R2006a)
    %
    % Example 2:
    % func_name = {'rand','plot','grid','findstr','weboptions'};
    % when(func_name)
    % ## rand is a built-in function (Introduced before R2006a)
    % ## plot is a built-in function (Introduced before R2006a)
    % ## grid is a Matlab function or an ordinary m-file (Introduced before R2006a)
    % ## findstr is a built-in function (Introduced before R2006a)
    % ## weboptions is a Matlab function or an ordinary m-file (Introduced in R2014b)
    %
    % -------------------------------------------------
    % code by: Reza Ahmadzadeh (reza.ahmadzadeh@iit.it)
    % -------------------------------------------------
    
    if ischar(func_name)
        checkFunctionName(func_name);
    elseif iscell(func_name)
        for ii = 1:size(func_name,2)
            fname = func_name{1, ii};
            checkFunctionName(fname);
        end
    else
        error('input ''%s'' should be either a string or a cell-string.', func_name);
    end
end

function checkFunctionName(fname)
    if isa(fname, 'function_handle')
        fname = func2str(fname);
    end

    fname = lower(fname);
    A = exist(fname);
    switch A
        case 0
            w = ' does not exist';
        case 1
            w = ' is a variable in the workspace';
        case 2
            w = ' is a Matlab function or an ordinary m-file';
        case 3
            w = ' is a MEX-file.';
        case 4
            w = ' is a Simulink model or library';
        case 5
            w = ' is a built-in function';
        case 6
            w = ' is a P-file.';
        case 7
            w = ' is a folder';
        case 8
            w = ' is a class';
        otherwise
            w = ' is nonsense';
    end

    if A == 0
        result = ['## [' fname ']' w '.'];
    else
        url = ['https://mathworks.com/help/matlab/ref/' fname '.html'];
        webdata = webread(url, 'ContentType', 'text');

        if isempty(webdata)
            result = ['## [' fname ']' w ' (No information found).'];
        else
            idx = strfind(webdata, 'Version History</h2></div>');
            str = 'No information found';
            for i = 1:length(idx)
                terminal_idx = find(webdata(idx(i) + 34:end) == '<', 1);
                if ~isempty(terminal_idx)
                    str = webdata(idx(i) + 34:idx(i) + 32 + terminal_idx);
                    break;
                end
            end

            result = ['## [' fname ']' w ' (' str ').'];
        end
    end
    
    disp(result);
end
