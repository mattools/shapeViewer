classdef SelectionTool < sv.gui.ShapeViewerTool
%SELECTIONTOOL Select shapes
%
%   output = SelectionTool(input)
%
%   Example
%   SelectionTool
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2011-11-21,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

properties
    SelectedHandles = [];
end

%% Constructor
methods
    function obj = SelectionTool(viewer, varargin)
        % Creates a new tool using parent gui and a name
         obj = obj@sv.gui.ShapeViewerTool(viewer, 'select');
    end % constructor 

end % construction function

%% General methods
methods
    function onMouseButtonPressed(obj, hObject, eventdata) %#ok<INUSD>
        % called when mouse button was pressed on empty area of current axis 
        
%         disp('button pressed');
        clearSelection(obj);
%         onSelectionUpdated(obj.viewer);
    end
    
    function onMouseClicked(obj, hObject, eventdata) %#ok<INUSD>
        % called when mouse button was pressed on a shape
        
%         disp('click');

        % toggles the selection state of current object
        sel = get(hObject, 'Selected');
        if strcmp(sel, 'On')
            removeFromSelection(obj, hObject);
        else
            clearSelection(obj);
            addToSelection(obj, hObject)
        end
        
        onSelectionUpdated(obj.Viewer);
    end
        
    function clearSelection(obj)
        % clear selected state of all displayed shapes
        
        children = get(obj.Viewer.Handles.MainAxis, 'Children');
        for i = 1:length(children)
            set(children(i), 'Selected', 'Off');
        end
        
        clearSelection(obj.Viewer);
    end
    
    function addToSelection(obj, hObj)
        obj.SelectedHandles = [obj.SelectedHandles hObj];
        set(hObj, 'Selected', 'On');
        
        node = get(hObj, 'UserData');
        addToSelection(obj.Viewer, node);
    end
    
    function removeFromSelection(obj, hObj)
        obj.SelectedHandles(obj.SelectedHandles == hObj) = [];
        set(hObj, 'Selected', 'Off');
        
        node = get(hObj, 'UserData');
        removeFromSelection(obj.Viewer, node);
    end
    
end % general methods

end