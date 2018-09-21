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
    viewer;
    
    % the name of this tool, that should be unique for all actions
    name;
end % end properties


%% Constructor
methods
    function this = ShapeViewerTool(viewer, name)
        % Creates a new tool using parent gui and a name
        this.viewer = viewer;
        this.name = name;
    end % constructor 

end % end constructors


%% General methods
methods
    function select(this) %#ok<*MANU>
    end
    
    function deselect(this)
    end
    
    function onMouseClicked(this, hObject, eventdata) %#ok<INUSD>
    end
    
    function onMouseButtonPressed(this, hObject, eventdata) %#ok<INUSD>
    end
    
    function onMouseButtonReleased(this, hObject, eventdata) %#ok<INUSD>
    end
    
    function onMouseMoved(this, hObject, eventdata) %#ok<INUSD>
    end
    
end % general methods


methods
    function b = isActivable(this)
        b = true;
    end
end

end % end classdef

