classdef DeleteSelectedShapes < sv.gui.ShapeViewerAction
%DELETESELECTEDSHAPES Delete selected shapes from current doc 
%
%   Class DeleteSelectedShapesAction
%
%   Example
%   DeleteSelectedShapesAction
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
    function this = DeleteSelectedShapes(varargin)
    % Constructor for DeleteSelectedShapesAction class

        % calls the parent constructor
        this = this@sv.gui.ShapeViewerAction('delete');
    end

end % end constructors


%% Methods
methods
    function run(this, viewer) %#ok<INUSL>
        disp('delete selected shapes');
        
        % get handle to parent figure, and current doc
        scene = viewer.doc.scene;
       
        shapes = viewer.selectedShapes;
        for i = 1:length(shapes)
            shape = shapes(i);
            removeShape(scene, shape);
        end

        updateDisplay(viewer);
        
    end
end % end methods

end % end classdef

