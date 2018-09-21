classdef ShapeViewerAction < handle
%SHAPEVIEWERACTION  One-line description here, please.
%
%   Class ShapeViewerAction
%
%   Example
%   ShapeViewerAction
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
    % the parent GUI, that should be an instance of ShapeViewerMainFrame
    viewer;
    
    % the name of this action, that should be unique for all actions
    name;
end % end properties


%% Constructor
methods
    function this = ShapeViewerAction(viewer, name)
        this.viewer = viewer;
        this.name = name;
    end

end % end constructors


%% Methods

methods (Abstract)
    actionPerformed(this, src, event)
end

methods
    function b = isActivable(this) %#ok<MANU>
        b = true;
    end
end


end % end classdef

