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
% e-mail: david.legland@nantes.inra.fr
% Created: 2011-11-13,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

properties
    % the tool to select
    tool;
end

methods
    function this = SelectToolAction(tool)
        % calls the parent constructor
        name = ['selectTool-' tool.name];
        this = this@sv.gui.ShapeViewerAction(name);
        this.tool = tool;
    end
end

methods
    function run(this, viewer) 
        disp(['select another tool: ' this.tool.name]);
        
        % remove previous tool
        currentTool = viewer.currentTool;
        if ~isempty(currentTool)
            deselect(currentTool);
            removeMouseListener(viewer, currentTool);
        end
        
        % choose the new tool
        viewer.currentTool = this.tool;
        
        % initialize new tool if not empty
        if ~isempty(this.tool)
            select(this.tool);
            addMouseListener(viewer, this.tool);
            updateDisplay(viewer);
        end
    end
end
% 
% methods
%     function b = isActivable(this)
%         b = isActivable(this.tool);
%     end
% end

end