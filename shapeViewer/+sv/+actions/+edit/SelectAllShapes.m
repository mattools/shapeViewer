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
    function this = SelectAllShapes(varargin)
    % Constructor for SelectAllShapesAction class

        % calls the parent constructor
        this = this@sv.gui.ShapeViewerAction('selectAllShapes');
    end

end % end constructors


%% Methods
methods
    function run(this, viewer)  %#ok<*INUSL>
        disp('select all shapes');
        
        clearSelection(viewer);
        
        shapes = viewer.doc.scene.shapes;
        for i = 1:length(shapes)
            addToSelection(viewer, shapes(i));
        end
        
        updateDisplay(viewer);
        
    end
end % end methods

end % end classdef

