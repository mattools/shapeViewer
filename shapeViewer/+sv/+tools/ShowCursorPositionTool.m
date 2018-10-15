classdef ShowCursorPositionTool < sv.gui.ShapeViewerTool
%SHOWCURSORPOSITIONTOOL  One-line description here, please.
%
%   output = ShowCursorPositionTool(input)
%
%   Example
%   ShowCursorPositionTool
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2011-11-21,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.


%% Constructor
methods
    function this = ShowCursorPositionTool(viewer, varargin)
        % Creates a new tool using parent gui and a name
         this = this@sv.gui.ShapeViewerTool(viewer, 'showCursorPosition');
    end % constructor 

end % construction function

%% General methods
methods
    function onMouseMoved(this, hObject, eventdata) %#ok<INUSD>

        point = get(this.viewer.handles.mainAxis, 'CurrentPoint');
        coord = point(1, 1:2);
        
        % Display only pixel position
%         unit = this.viewer.doc.userUnit;
        unit = '';
        locString = sprintf('(x,y) = (%g,%g) %s', coord(1), coord(2), unit);
        
        set(this.viewer.handles.statusBar, ...
            'string', locString);
    end
        
end % general methods

end