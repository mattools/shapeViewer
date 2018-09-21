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
% e-mail: david.legland@nantes.inra.fr
% Created: 2011-12-02,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

methods
    function this = CreateNewDocAction(viewer, varargin)
        % calls the parent constructor
        this = this@sv.gui.ShapeViewerAction(viewer, 'createNewDoc');
    end
end

methods
    function actionPerformed(this, varargin)        
        gui = this.viewer.gui;
        
        createNewEmptyDocument(gui);
        
    end
end

end