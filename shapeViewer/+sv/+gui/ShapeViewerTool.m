classdef ShapeViewerTool < handle
%SHAPEVIEWERTOOL  Interface for mouse controls
%
%   Class ShapeViewerTool
%
%   Example
%   ShapeViewerTool
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2018-09-21,    using Matlab 8.6.0.267246 (R2015b)
% Copyright 2018 INRA - BIA-BIBS.


%% Properties
properties
    % the parent GUI, that can be ShapeViewerMainFrame
    Viewer;
    
    % the name of this tool, that should be unique for all actions
    Name;
    
end % end properties


%% Constructor
methods
    function obj = ShapeViewerTool(viewer, name)
        % Creates a new tool using parent gui and a name
        obj.Viewer = viewer;
        obj.Name = name;
    end % constructor 

end % end constructors


%% General methods
methods
    function select(obj) %#ok<*MANU>
    end
    
    function deselect(obj)
    end
    
    function onMouseClicked(obj, hObject, eventdata) %#ok<INUSD>
    end
    
    function onMouseButtonPressed(obj, hObject, eventdata) %#ok<INUSD>
    end
    
    function onMouseButtonReleased(obj, hObject, eventdata) %#ok<INUSD>
    end
    
    function onMouseMoved(obj, hObject, eventdata) %#ok<INUSD>
    end
    
end % general methods


methods
    function b = isActivable(obj)
        % By default, new tools are activable
        b = true;
    end
end

end % end classdef

