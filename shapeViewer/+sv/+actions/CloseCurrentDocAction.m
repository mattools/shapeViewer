classdef CloseCurrentDocAction < sv.gui.ShapeViewerAction
%EXITACTION Close the current viewer
%
%   output = CloseCurrentDocAction(input)
%
%   Example
%   CloseCurrentDocAction
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2011-12-02,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

methods
    function this = CloseCurrentDocAction(viewer, varargin)
        % calls the parent constructor
        this = this@sv.gui.ShapeViewerAction(viewer, 'closeCurrentDoc');
    end
end

methods
    function actionPerformed(this, varargin)        
        viewer = this.viewer;
        
        viewer.close();
    end
end

end