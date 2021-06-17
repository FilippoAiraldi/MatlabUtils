function new_data = removeLedOff(data, led)
    % labview.removeLedOff Filters data with the LED signal.
    %
    %   new_data = labview.removeLedOff(data, led) Filters the given 
    %       labview data according to the specified led signal, only 
    %       keeping the portions where the led was on.

    mask = led == 1;
    
    if isstruct(data)
        fields = string(fieldnames(data));
        for i = 1:length(fields)
            new_data.(fields(i)) = data.(fields(i))(mask);
        end
    else % should be a matrix
        new_data = data(:, mask);
    end
end
