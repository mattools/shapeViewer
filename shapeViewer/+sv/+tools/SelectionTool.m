classdef SelectionTool < svui.gui.ShapeViewerTool
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
% e-mail: david.legland@nantes.inra.fr
% Created: 2011-11-21,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

properties
    selectedHandles = [];
end

%% Constructor
methods
    function this = SelectionTool(viewer, varargin)
        % Creates a new tool using parent gui and a name
         this = this@svui.gui.ShapeViewerTool(viewer, 'select');
    end % constructor 

end % construction function

%% General methods
methods
    function onMouseButtonPressed(this, hObject, eventdata) %#ok<INUSD>
        % called when mouse button was pressed on empty area of current axis 
        
%         disp('button pressed');
        clearSelection(this);
%         onSelectionUpdated(this.viewer);
    end
    
    function onMouseClicked(this, hObject, eventdata) %#ok<INUSD>
        % called when mouse button was pressed on a shape
        
%         disp('click');

        % toggles the selection state of current object
        sel = get(hObject, 'Selected');
        if strcmp(sel, 'on')
            removeFromSelection(this, hObject);
        else
            clearSelection(this);
            addToSelection(this, hObject)
        end
        
        onSelectionUpdated(this.viewer);
    end
        
    function clearSelection(this)
        % clear selected state of all displayed shapes
        
        children = get(this.viewer.handles.mainAxis, 'children');
        for i = 1:length(children)
            set(children(i), 'selected', 'off');
        end
        
        clearSelection(this.viewer);
    end
    
    function addToSelection(this, hObj)
        this.selectedHandles = [this.selectedHandles hObj];
        set(hObj, 'Selected', 'on');
        
        shape = get(hObj, 'UserData');
        addToSelection(this.viewer, shape);
    end
    
    function removeFromSelection(this, hObj)
        this.selectedHandles(this.selectedHandles == hObj) = [];
        set(hObj, 'Selected', 'off');
        
        shape = get(hObj, 'UserData');
        removeFromSelection(this.viewer, shape);
    end
    
end % general methods

end