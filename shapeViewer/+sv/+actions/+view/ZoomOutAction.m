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
    function this = ZoomOutAction(varargin)
    % Constructor for ZoomOutAction class

        % calls the parent constructor
        this = this@sv.gui.ShapeViewerAction('zoomIn');
    end

end % end constructors


%% Methods
methods
    function run(this, viewer) %#ok<INUSL>
        
        % get handle to parent figure, and current doc
        ax = viewer.handles.mainAxis;
        axes(ax);
        zoom(.5);

        % update scene limits
        viewer.doc.scene.xAxis.limits = get(ax, 'xlim');
        viewer.doc.scene.yAxis.limits = get(ax, 'ylim');
        viewer.doc.scene.zAxis.limits = get(ax, 'zlim');
%         updateDisplay(viewer);        
    end
end % end methods

end % end classdef

