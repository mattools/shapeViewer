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
    % the name of obj action, that should be unique for all actions
    Name;
end % end properties


%% Constructor
methods
    function obj = ShapeViewerAction(name)
        obj.Name = name;
    end

end % end constructors


%% Methods

methods (Abstract)
    run(obj, viewer)
end

methods
    function b = isActivable(obj, viewer) %#ok<INUSD>
        b = true;
    end
end


end % end classdef

