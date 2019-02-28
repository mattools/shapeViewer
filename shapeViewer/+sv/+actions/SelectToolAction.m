classdef SelectToolAction < sv.gui.ShapeViewerAction
%SELECTTOOLACTION  One-line description here, please.
%
%   output = SelectToolAction(input)
%
%   Example
%   SelectToolAction
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2011-11-13,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

properties
    % the Tool to select
    Tool;
end

methods
    function obj = SelectToolAction(Tool)
        % calls the parent constructor
        name = ['selectTool-' Tool.Name];
        obj = obj@sv.gui.ShapeViewerAction(name);
        obj.Tool = Tool;
    end
end

methods
    function run(obj, viewer) 
        disp(['select another Tool: ' obj.Tool.Name]);
        
        % remove previous Tool
        currentTool = viewer.currentTool;
        if ~isempty(currentTool)
            deselect(currentTool);
            removeMouseListener(viewer, currentTool);
        end
        
        % choose the new Tool
        viewer.currentTool = obj.Tool;
        
        % initialize new Tool if not empty
        if ~isempty(obj.Tool)
            select(obj.Tool);
            addMouseListener(viewer, obj.Tool);
            updateDisplay(viewer);
        end
    end
end
% 
% methods
%     function b = isActivable(obj)
%         b = isActivable(obj.Tool);
%     end
% end

end