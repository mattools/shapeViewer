classdef SetSelectedShapesLineWidth < sv.gui.ShapeViewerAction
% Changes line width of selected shape(s)
%
%   Class SetSelectedShapesLineWidth
%
%   Example
%   SetSelectedShapesLineWidth
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


%% Constructor
methods
    function this = SetSelectedShapesLineWidth(varargin)
    % Constructor for DeleteSelectedShapesAction class

        % calls the parent constructor
        this = this@sv.gui.ShapeViewerAction('setSelectedShapesLineWidth');
    end

end % end constructors


%% Methods
methods
    function run(this, viewer) %#ok<INUSL>
        disp('set selected shapes line width');
        
        prompt = {'Enter new Line Width:'};
        title = 'Set Line Width';
        dims = [1 35];
        definput = {'2'};
        answer = inputdlg(prompt, title, dims, definput);
        if isempty(answer)
            return;
        end

        % parse new line width
        newWidth = str2double(answer{1});
        if isnan(newWidth)
            errordlg('Could not parse width from string: %s', answer{1});
            return;
        end
        
        % iterate over selected shapes
        shapes = viewer.selectedShapes;
        for i = 1:length(shapes)
            shape = shapes(i);
            shape.style.lineWidth = newWidth;
        end

        updateDisplay(viewer);
    end
    
end % end methods

end % end classdef

