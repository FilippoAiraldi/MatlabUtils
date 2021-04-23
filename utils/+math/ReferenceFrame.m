classdef ReferenceFrame
    % REFERNCEFRAME Convenience class for handling and plotting reference
    %   frames.
    properties (SetAccess = protected, GetAccess = public)
        % Origin of the reference frame.
        O (3, 1) double {mustBeVector, mustBeNumeric, mustBeFinite}
        % X-axis of the reference frame
        x (3, 1) double {mustBeVector, mustBeNumeric, mustBeFinite}
        % Y-axis of the reference frame
        y (3, 1) double {mustBeVector, mustBeNumeric, mustBeFinite}
        % Z-axis of the reference frame
        z (3, 1) double {mustBeVector, mustBeNumeric, mustBeFinite}
    end
    properties (SetAccess = public, GetAccess = public)
        % color of x-axis 
        x_color char {mustBeText} = 'r'
        % color of y-axis 
        y_color char {mustBeText} = 'g'
        % color of y-axis 
        z_color char {mustBeText} = 'b'
    end
    properties (SetAccess = public, GetAccess = public)
        % handles to the reference frame's plot lines
        h (3, 1)
        % handle to the reference frame's plot text
        T (1, 1)
    end
   
    methods
        function obj = ReferenceFrame(O, x, y)
            % REFERNCEFRAME Constructs a reference frame with the given
            %   axes. The z-axis is inferred automatically

            arguments 
                O (3, 1) double {mustBeVector, mustBeNumeric, mustBeFinite} = [0; 0; 0]
                x (3, 1) double {mustBeVector, mustBeNumeric, mustBeFinite} = [1; 0; 0]
                y (3, 1) double {mustBeVector, mustBeNumeric, mustBeFinite} = [0; 1; 0]
            end

            obj.O = O; obj.x = x; obj.y = y;
            obj.z = O + cross((x - O), (y - O));
        end
        
%         function delete(obj)
%             H = [obj.h; obj.T];
%             for i = 1:4
%                 if H(i) ~= 0
%                     delete(H(i));
%                 end
%             end
%         end
        
        function obj = update(obj, Onew, xnew, ynew)
            % UPDATE Updates the pose of this reference frame.
            arguments 
                obj {mustBeA(obj, "math.ReferenceFrame")}
                Onew (3, 1) double {mustBeVector, mustBeNumeric, mustBeFinite}
                xnew (3, 1) double {mustBeVector, mustBeNumeric, mustBeFinite}
                ynew (3, 1) double {mustBeVector, mustBeNumeric, mustBeFinite}
            end

            obj.O = Onew; obj.x = xnew; obj.y = ynew;
            obj.z = Onew + cross((xnew - Onew), (ynew - Onew));
            
            % update line plot if existing
            if obj.h(1) ~= 0
                xl = obj.h(1); yl = obj.h(2); zl = obj.h(3);
                
                scale = norm([xl.XData(2), xl.YData(2), xl.ZData(2)] - [xl.XData(1), xl.YData(1), xl.ZData(1)]);
                
                scaledX = (obj.x - obj.O) / norm(obj.x - obj.O) * scale + obj.O;
                scaledY = (obj.y - obj.O) / norm(obj.y - obj.O) * scale + obj.O;
                scaledZ = (obj.z - obj.O) / norm(obj.z - obj.O) * scale + obj.O;
                
                % first point of each line into new origin
                xl.XData(1) = obj.O(1); xl.YData(1) = obj.O(2); xl.ZData(1) = obj.O(3); 
                yl.XData(1) = obj.O(1); yl.YData(1) = obj.O(2); yl.ZData(1) = obj.O(3); 
                zl.XData(1) = obj.O(1); zl.YData(1) = obj.O(2); zl.ZData(1) = obj.O(3); 
                
                % second point of each line into new destination
                xl.XData(2) = scaledX(1); xl.YData(2) = scaledX(2); xl.ZData(2) = scaledX(3); 
                yl.XData(2) = scaledY(1); yl.YData(2) = scaledY(2); yl.ZData(2) = scaledY(3); 
                zl.XData(2) = scaledZ(1); zl.YData(2) = scaledZ(2); zl.ZData(2) = scaledZ(3); 
            end
            
            % update text plot if existing
            if obj.T ~= 0
                pos = (obj.x + obj.y + obj.z + rand(3, 1) / 2) / 3;
                obj.T.Position = pos';
            end
        end
        
        function obj = plot(obj, scale, str)
            % PLOT Plots this reference frame.           
            
            arguments
                obj {mustBeA(obj, "math.ReferenceFrame")}
                scale (1, 1) {mustBeNumeric, mustBeFinite, mustBePositive} = 1
                str string {mustBeText} = ""
            end
            
            scaledX = (obj.x - obj.O) / norm(obj.x - obj.O) * scale + obj.O;
            scaledY = (obj.y - obj.O) / norm(obj.y - obj.O) * scale + obj.O;
            scaledZ = (obj.z - obj.O) / norm(obj.z - obj.O) * scale + obj.O;
            
            hold on,
%             plot3([obj.O(1) scaledX(1)], [obj.O(2) scaledX(2)], [obj.O(3) scaledX(3)], [obj.x_color, '-'], ...
%                   [obj.O(1) scaledY(1)], [obj.O(2) scaledY(2)], [obj.O(3) scaledY(3)], [obj.y_color, '-'], ...
%                   [obj.O(1) scaledZ(1)], [obj.O(2) scaledZ(2)], [obj.O(3) scaledZ(3)], [obj.z_color, '-'])

            H(1) = line([obj.O(1) scaledX(1)], [obj.O(2) scaledX(2)], [obj.O(3) scaledX(3)], 'color', obj.x_color);
            H(2) = line([obj.O(1) scaledY(1)], [obj.O(2) scaledY(2)], [obj.O(3) scaledY(3)], 'color', obj.y_color);
            H(3) = line([obj.O(1) scaledZ(1)], [obj.O(2) scaledZ(2)], [obj.O(3) scaledZ(3)], 'color', obj.z_color);
            obj.h = H;
            
            if ~isempty(str)
                pos = (obj.x + obj.y + obj.z + rand(3, 1) / 2) / 3;
                obj.T = text(pos(1), pos(2), pos(3), str, 'interpreter', 'tex');
            end
            hold off,
        end
    end
end
