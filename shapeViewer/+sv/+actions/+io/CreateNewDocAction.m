classdef CreateNewDocAction < sv.gui.ShapeViewerAction
%EXITACTION Create a new empty document
%
%   output = CreateNewDocAction(input)
%
%   Example
%   CreateNewDocAction
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2011-12-02,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

methods
    function obj = CreateNewDocAction(varargin)
        % calls the parent constructor
        obj = obj@sv.gui.ShapeViewerAction('createNewDoc');
    end
end

methods
    function run(obj, viewer)         %#ok<INUSL>
        createNewEmptyDocument(viewer.GUI);
    end
end

end