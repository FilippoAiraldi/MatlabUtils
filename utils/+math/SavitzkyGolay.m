classdef SavitzkyGolay
    % Savitzy-Golay filtering and derivative.
    
    methods(Static) 
        function dx = derivate(x, order, framelen, dt)
            % DERIVATE Derivates via a Savitzy-Golay filter.
            % 
            %   dx = derivate(x, order, framelen, dt) Derivates x with a SG
            %       filter with the specific order and framelen, with
            %       sampling time dt.
            %
            %   - x {vector}: input signal.
            %   - order {int}: order of filter (linear, cubic, etc.)
            %   - framelen {int}: window size of the filter.
            %   - dt {double}: sampling time of the input signal.
            
            arguments
                x (1, :) double {mustBeVector}
                order (1, 1) uint8 {mustBeInteger, mustBePositive}
                framelen (1, 1) uint32 {mustBeInteger, mustBePositive}
                dt (1, 1) double {mustBePositive}
            end
         
            [~, g] = sgolay(order, framelen);
            coeffs = 1 / dt * g(:, 2);       
            dx = zeros(size(x));
            for i = framelen:length(x)
                dx(i) = x(i - framelen + 1:i) * coeffs;
            end
            dx(1:framelen - 1) = dx(framelen); % avoid sudden changes
        end
        
        function dx = filter(x, order, framelen)
            % FILTER Filters via a Savitzy-Golay filter.
            %
            %   dx = filter(x, order, framelen) Filters x with a SG filter
            %       filter with the specific order and framelen.
            %
            %   - x {vector}: input signal.
            %   - order {int}: order of filter (linear, cubic, etc.)
            %   - framelen {int}: window size of the filter.
            
            arguments
                x (1, :) double {mustBeVector}
                order (1, 1) uint8 {mustBeInteger, mustBePositive}
                framelen (1, 1) uint32 {mustBeInteger, mustBePositive}
            end
            
            [~, g] = sgolay(order, framelen);
            coeffs = g(:, 1);           
            dx = zeros(size(x));
            for i = framelen:length(x)
                dx(i) = x(i - framelen + 1:i) * coeffs;
            end
            dx(1:framelen - 1) = dx(framelen); % avoid sudden changes
        end
    end
end