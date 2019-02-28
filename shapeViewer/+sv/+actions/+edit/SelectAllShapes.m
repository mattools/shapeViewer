classdef SelectAllShapes  < sv.gui.ShapeViewerAction
%ADDRANDOMPOINTSACTION add all shapes in document to current selection 
%
%   Class SelectAllShapesAction
%
%   Example
%   SelectAllShapesAction
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
    function obj = SelectAllShapes(varargin)
    % Constructor for SelectAllShapesAction class

        % calls the parent constructor
        obj = obj@sv.gui.ShapeViewerAction('selectAllShapes');
    end

end % end constructors


%% Methods
methods
    function run(obj, viewer)  %#ok<*INUSL>
        disp('select all shapes');
        
        clearSelection(viewer);
        
        shapes = viewer.Doc.Scene.Shapes;
        for i = 1:length(shapes)
            addToSelection(viewer, shapes(i));
        end
        
        updateDisplay(viewer);
        
    end
end % end methods

end % end classdef

