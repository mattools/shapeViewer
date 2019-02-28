classdef RecenterSelectedShapes < sv.gui.ShapeViewerAction
%RECENTERSHAPEACTION  Scale the selected shape by a given factor
%
%   Class RecenterShapeAction
%
%   Example
%   RecenterShapeAction
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2015-09-08,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.


%% Properties
properties
end % end properties


%% Constructor
methods
    function obj = RecenterSelectedShapes(varargin)
    % Constructor for ScaleShapeAction class

        % calls the parent constructor
        obj = obj@sv.gui.ShapeViewerAction('recenterShape');
    end

end % end constructors


%% Methods
methods
    function run(obj, viewer)  %#ok<*INUSL>
        disp('recenter selected shape(s)');
        
        % get handle to parent viewer, and selected shapes
        shapes = viewer.SelectedShapes;
        
        % basic input checks
        if isempty(shapes)
            return;
        end
        
        % transform each selected shape
        for i = 1:length(shapes)
            shape = shapes(i);
            geometry = shape.Geometry;
            
            switch class(geometry)
                case 'Polygon2D'
                    center = centroid(geometry);
                case 'LineString2D'
                    center = centroid(geometry);
                case 'MultiPoint2D'
                    center = centroid(geometry);
                otherwise
                    warning('Can not compute centroid of shapes with geometry %s', ... 
                        class(geometry));
                    continue;
            end
            
            shape.Geometry = translate(geometry, -[center.X center.Y]);
        end

        % recompute bounds
        fitBoundsToShape(viewer.Doc.Scene);
        
        updateDisplay(viewer);
    end
    
end % end methods

end % end classdef

