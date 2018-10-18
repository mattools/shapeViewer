classdef CreateMultiPointTool < sv.gui.ShapeViewerTool
%CREATEPOLYGONTOOL Crate a new polygonal shape
%
%   output = CreateMultiPointTool(input)
%
%   Example
%   CreateMultiPointTool
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2011-11-21,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

properties
    vertices;
    
    hPoly;
    
%     selectedHandles = [];
end

%% Constructor
methods
    function this = CreateMultiPointTool(viewer, varargin)
        % Creates a new tool using parent gui and a name
         this = this@sv.gui.ShapeViewerTool(viewer, 'createMultiPoint');
    end % constructor 

end % construction function

%% General methods
methods
    
    function onMouseButtonPressed(this, hObject, eventdata) %#ok<INUSD>
        
        % check if right-clicked or double-clicked
        type = get(this.viewer.handles.figure, 'SelectionType');
        if ~strcmp(type, 'normal')
            % update viewer's current selection
            shape = Shape(MultiPoint2D(this.vertices));
            this.viewer.doc.scene.addShape(shape);
            
            updateDisplay(this.viewer);
            
            this.vertices = zeros(0, 2);
            return;
        end
        
        % add new vertex to the list
        pos = get(this.viewer.handles.mainAxis, 'CurrentPoint');
        this.vertices = [this.vertices ; pos(1,1:2)];

        if size(this.vertices, 1) == 1
            % if clicked first point, creates a new graphical object
            removeSelectionHandle(this);
            this.hPoly = line(...
                'XData', pos(1,1), 'YData', pos(1,2), ...
                'Marker', '*', 'MarkerSize', 6, ...
                'Color', 'k', 'LineStyle', 'none');
            
        else
            % update graphical object
            set(this.hPoly, 'xdata', this.vertices([1:end 1], 1));
            set(this.hPoly, 'ydata', this.vertices([1:end 1], 2));
            
        end

    end
            
    function removeSelectionHandle(this)
        if ~ishandle(this.hPoly)
            return;
        end
        
        ax = this.viewer.handles.mainAxis;
        if isempty(ax)
            return;
        end
       
        delete(this.hPoly);
        
    end

end % general methods

end