classdef SetSelectedShapesLineColor < sv.gui.ShapeViewerAction
% Changes line width of selected shape(s)
%
%   Class SetSelectedShapesLineColor
%
%   Example
%   SetSelectedShapesLineColor
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2012-01-29,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.


%% Properties
properties
end % end properties

% Static Utility methods
methods (Static)
    function color = parseRGB(inputColor)
        % convert the input into a triplet of RGB values between 0 and 1
        
        if isnumeric(inputColor) && all(size(inputColor) == [1 3])
            % case of a triplet. Can be between [0 1] or [0 255]
            color = inputColor;
            
            % eventually rescale
            if max(color(:) > 1)
                color = color / 255;
            end
            
        elseif ischar(inputColor)
            % case of a color given a char
            switch lower(inputColor(1))
                case 'r', color = [1 0 0]; 
                case 'g', color = [0 1 0]; 
                case 'b', color = [0 0 1]; 
                case 'c', color = [0 1 1]; 
                case 'm', color = [1 0 1]; 
                case 'y', color = [1 1 0]; 
                case 'k', color = [0 0 0]; 
                case 'w', color = [1 1 1]; 
            end
        else
            error('Can not parse color to RGB');
        end
    end
end

%% Constructor
methods
    function obj = SetSelectedShapesLineColor(varargin)
    % Constructor for SetSelectedShapesLineColor class

        % calls the parent constructor
        obj = obj@sv.gui.ShapeViewerAction('setSelectedShapesLineColor');
    end

end % end constructors


%% Methods
methods
    function run(obj, viewer) %#ok<INUSL>
        disp('set selected shapes line color');

        % check some shapes are selected
        shapes = viewer.SelectedShapes;
        if isempty(shapes)
            return;
        end
 
        % defie default color
        shape1 = shapes(1);
        defaultColor = sv.actions.edit.SetSelectedShapesLineColor.parseRGB(shape1.Style.LineColor);

        % open color chooser dialog
        newColor = uisetcolor(defaultColor, 'Set Line Color');

        % iterate over selected shapes
        for i = 1:length(shapes)
            shape = shapes(i);
            shape.Style.LineColor = newColor;
        end

        updateDisplay(viewer);
    end
    
end % end methods

end % end classdef

