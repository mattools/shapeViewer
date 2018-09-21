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
    % the name of this action, that should be unique for all actions
    name;
end % end properties


%% Constructor
methods
    function this = ShapeViewerAction(name)
        this.name = name;
    end

end % end constructors


%% Methods

methods (Abstract)
    run(this, viewer)
end

methods
    function b = isActivable(this, viewer) %#ok<INUSD>
        b = true;
    end
end


end % end classdef

