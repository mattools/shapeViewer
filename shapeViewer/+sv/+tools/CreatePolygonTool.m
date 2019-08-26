classdef CreatePolygonTool < sv.gui.ShapeViewerTool
% Create a new polygonal shape.
%
%   Example
%   CreatePolygonTool
%
%   See also
%     CreateMultiPointTool

% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2011-11-21,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

properties
    Vertices;
    
    HPoly;
    
%     selectedHandles = [];
end

%% Constructor
methods
    function obj = CreatePolygonTool(viewer, varargin)
        % Creates a new tool using parent gui and a name
         obj = obj@sv.gui.ShapeViewerTool(viewer, 'createPolygon');
    end % constructor 

end % construction function

%% General methods
methods
    
    function onMouseButtonPressed(obj, hObject, eventdata) %#ok<INUSD>
        
        % check if right-clicked or double-clicked
        type = get(obj.Viewer.Handles.Figure, 'SelectionType');
        if ~strcmp(type, 'normal')
            % update viewer's current selection
            shape = ShapeNode(Polygon2D(obj.Vertices));
            
            addShape(obj.Viewer.Doc, shape);
            
            updateDisplay(obj.Viewer);
            
            obj.Vertices = zeros(0, 2);
            return;
        end
        
        % add new vertex to the list
        pos = get(obj.Viewer.Handles.MainAxis, 'CurrentPoint');
        obj.Vertices = [obj.Vertices ; pos(1,1:2)];

        if size(obj.Vertices, 1) == 1
            % if clicked first point, creates a new graphical object
            removePolygonHandle(obj);
            obj.HPoly = line(...
                'XData', pos(1,1), 'YData', pos(1,2), ...
                'Marker', 's', 'MarkerSize', 3, ...
                'Color', 'k', 'LineWidth', 1);
            
        else
            % update graphical object
            set(obj.HPoly, 'xdata', obj.Vertices([1:end 1], 1));
            set(obj.HPoly, 'ydata', obj.Vertices([1:end 1], 2));
            
        end

    end
            
    function removePolygonHandle(obj)
        if ~ishandle(obj.HPoly)
            return;
        end
        
        ax = obj.Viewer.Handles.MainAxis;
        if isempty(ax)
            return;
        end
       
        delete(obj.HPoly);
        
    end

end % general methods

end