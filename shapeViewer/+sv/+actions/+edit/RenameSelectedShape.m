classdef RenameSelectedShape < sv.gui.ShapeViewerAction
% Rename the selected shape
%
%   Class RenameSelectedShape
%
%   Example
%   RenameSelectedShape
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2012-04-13,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.


%% Properties
properties
end % end properties


%% Constructor
methods
    function obj = RenameSelectedShape(varargin)
    % Constructor for RenameSelectedShape class

        % calls the parent constructor
        obj = obj@sv.gui.ShapeViewerAction('renameSelection');
    end

end % end constructors


%% Methods
methods
    function run(obj, viewer)  %#ok<*INUSL>
        disp('rename');
        
        % get handle to parent viewer, and selected shapes
        nodes = viewer.SelectedNodeList;
        
        % basic input checks
        if isempty(nodes)
            return;
        end
        if length(nodes) > 1
            errordlg('Can not rename multiple nodes', 'Selection Error', 'modal');
            return;
        end
            
        % extract shape name, or create one if necessary
        node = nodes(1);
        name = node.Name;
        if isempty(name)
            if isa(node, 'ShapeNode')
                name = ['(' class(node.Geometry) ')'];
            else
                name = ['(' class(node) ')'];
            end
        end
        
        % input the new shape name
        answer = inputdlg('Input new name:', ...
            'Rename selection', 1, ...
            {name});
        if isempty(answer) 
            return;
        end
        
        node.Name = answer{1};
        updateDisplay(viewer);
    end
end % end methods

end % end classdef

