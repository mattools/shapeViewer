classdef ShapeViewerDoc < handle
% Encapsulates a scene and associated information
%
%   Class ShapeViewerDoc
%
%   Example
%   ShapeViewerDoc
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
    % the name of the doc, used as ID
    Name;

    % the scene displayed by this document, as a SceneGraph instance
    Scene;
    
    % a flag of modification
    Modified = false;

    % flag for display of background image
    % (obsolete?)
    DisplayBackgroundImage = true;
    
end % end properties


%% Constructor
methods
    function this = ShapeViewerDoc(varargin)
        % Constructor for ShapeViewerDoc class
        
        if isempty(varargin)
            error('Requires one input argument');
        end
        var1 = varargin{1};
        if ~isa(var1, 'SceneGraph')
            error('Requires a SceneGraph instance as input argument');
        end
        
        this.Scene = var1;
        this.Name = '[No Name]';
        
    end

end % end constructors

%% Shape management
methods
    function shapeNode = addShape(obj, shapeNode)
        % Add the shape to the root node, and returns the new shape node
        
        % get scene root node, or create it if empty
        root = obj.Scene.RootNode;
        if isempty(root)
            root = GroupNode();
            obj.Scene.RootNode = root;
        end
        
        % create shape node
        if isa(shapeNode, 'Geometry')
            shapeNode = ShapeNode(shapeNode);
        end
        shapeNode = ShapeNode(shapeNode);
        
        add(root, shapeNode);
        
        obj.Modified = true;
    end

end

end % end classdef

