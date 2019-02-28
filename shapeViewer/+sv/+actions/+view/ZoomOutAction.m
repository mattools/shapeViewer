classdef ZoomOutAction < sv.gui.ShapeViewerAction
%ZoomOutAction add a set of random points to current doc
%
%   Class ZoomOutAction
%
%   Example
%   ZoomOutAction
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2012-01-29,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.


%% Properties
properties
end % end properties


%% Constructor
methods
    function obj = ZoomOutAction(varargin)
    % Constructor for ZoomOutAction class

        % calls the parent constructor
        obj = obj@sv.gui.ShapeViewerAction('zoomIn');
    end

end % end constructors


%% Methods
methods
    function run(obj, viewer) %#ok<INUSL>
        
        % get handle to parent figure, and current doc
        ax = viewer.Handles.MainAxis;
        axes(ax);
        zoom(.5);

        % update scene limits
        viewer.Doc.Scene.XAxis.Limits = get(ax, 'xlim');
        viewer.Doc.Scene.YAxis.Limits = get(ax, 'ylim');
        viewer.Doc.Scene.ZAxis.Limits = get(ax, 'zlim');
%         updateDisplay(viewer);        
    end
end % end methods

end % end classdef

