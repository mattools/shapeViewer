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
    function obj = ShowCursorPositionTool(viewer, varargin)
        % Creates a new tool using parent gui and a name
         obj = obj@sv.gui.ShapeViewerTool(viewer, 'showCursorPosition');
    end % constructor 

end % construction function

%% General methods
methods
    function onMouseMoved(obj, hObject, eventdata) %#ok<INUSD>

        point = get(obj.Viewer.Handles.MainAxis, 'CurrentPoint');
        coord = point(1, 1:2);
        
        % Display only pixel position
%         unit = obj.viewer.doc.userUnit;
        unit = '';
        locString = sprintf('(x,y) = (%g,%g) %s', coord(1), coord(2), unit);
        
        set(obj.Viewer.Handles.StatusBar, ...
            'string', locString);
    end
        
end % general methods

end