function new_data = interpolate(data, timesteps_lv, Ts_lv, Ts_kin)
    % kinovea.interpolate Interpolates kinovea data. 
    %
    %   new_data = kinovea.interpolate(data, timesteps_lv) Interpolate 
    %       kinovea data.
    %
    %   _ = kinovea.interpolate(_, Ts_lv, Ts_kin) Specifies sampling period
    %       of labview and kinovea. Default to 10 and 40 respectively (ms).
    
    % labview sampling frequency [ms]
    if ~exist("Ts_lv", "var")
        Ts_lv = 10;
    end
    
    % kinovea sampling frequency [ms]
    if ~exist("Ts_kin", "var")
        Ts_kin = 40;
    end
    
    % perform interpolation
    fields = string(fieldnames(data));
    timesteps_kin =  length(data.(fields{1}).time);
    old_time = 0:Ts_kin:(timesteps_kin - 1) * Ts_kin;
    new_time = 0:Ts_lv:(timesteps_lv - 1) * Ts_lv;
    for i = 1:length(fields)
        new_data.(fields(i)).x = interp1(old_time, data.(fields(i)).x, new_time);
        new_data.(fields(i)).y = interp1(old_time, data.(fields(i)).y, new_time);
    end
end
