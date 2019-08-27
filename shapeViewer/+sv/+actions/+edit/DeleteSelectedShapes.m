classdef DeleteSelectedShapes < sv.gui.ShapeViewerAction
%DELETESELECTEDSHAPES Delete selected shapes from current doc 
%
%   Class DeleteSelectedShapesAction
%
%   Example
%   DeleteSelectedShapesAction
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2012-01-29,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.


%% Properties
properties
end % end properties


%% Constructor
methods
    function obj = DeleteSelectedShapes(varargin)
    % Constructor for DeleteSelectedShapesAction class

        % calls the parent constructor
        obj = obj@sv.gui.ShapeViewerAction('delete');
    end

end % end constructors


%% Methods
methods
    function run(obj, viewer) %#ok<INUSL>
        disp('delete selected shapes');
        
        % get handle to parent figure, and current doc
        scene = viewer.Doc.Scene;
       
        nodeList = viewer.SelectedNodeList;
        % iterate over nodes to remove the selected shape
        
        for i = 1:length(nodeList)
            node = nodeList(i);
            removeNodeFromGroupNode(node, scene.RootNode);
        end

        updateDisplay(viewer);
        
        function res = removeNodeFromGroupNode(node, group)
            
            res = false;
            
            % iterates over children
            for iChild = 1:length(group.Children)
                child = group.Children{iChild};
                if ~isLeaf(child)
                    % process groups recursively
                    res = removeNodeFromGroupNode(node, child);
                    if res
                        return;
                    end
                else
                    % process leaf node: compare with node
                    if child == node
                        res = true;
                        group.Children(iChild) = [];
                        return;
                    end
                end
            end
        end
    
    end
    
end % end methods

end % end classdef

