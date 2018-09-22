classdef ZoomInAction < sv.gui.ShapeViewerAction
%ZoomInAction add a set of random points to current doc
%
%   Class ZoomInAction
%
%   Example
%   ZoomInAction
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
    function this = ZoomInAction(varargin)
    % Constructor for ZoomInAction class

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
        zoom(2);

        % update scene limits
        viewer.doc.scene.xAxis.limits = get(ax, 'xlim');
        viewer.doc.scene.yAxis.limits = get(ax, 'ylim');
        viewer.doc.scene.zAxis.limits = get(ax, 'zlim');
%         updateDisplay(viewer); 
    end
end % end methods

end % end classdef

