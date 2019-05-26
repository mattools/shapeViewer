classdef PrintSceneInfo < sv.gui.ShapeViewerAction
%OPENSCENEACTION  One-line description here, please.
%
%   Class PrintSceneInfo
%
%   Example
%   PrintSceneInfo
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
end % end properties


%% Constructor
methods
    function obj = PrintSceneInfo(varargin)
        % Constructor for PrintSceneInfo class

        % calls the parent constructor
        obj = obj@sv.gui.ShapeViewerAction('printInfo');
    end

end % end constructors


%% Methods
methods
    function run(obj, viewer)  %#ok<*INUSL>
        disp('Open a scene file');
        
        % get handle to parent figure, and current doc
        scene = viewer.Doc.Scene;
        
        disp('Scene Info: ');
        fprintf('  xlim: [ %f ; %f ]\n', scene.XAxis.Limits);  
        fprintf('  ylim: [ %f ; %f ]\n', scene.YAxis.Limits);  
        fprintf('  zlim: [ %f ; %f ]\n', scene.ZAxis.Limits);

        printTree(scene.RootNode, 1);
%         if ~isempty(scene.BackgroundImage)
%             fprintf('  backgroundImage: %s\n', scene.BackgroundImage.FilePath);  
%         end
        
%         fprintf('  shapes:\n');  
%         for iShape = 1:length(scene.Shapes)
%             shape = scene.Shapes(iShape);
%             id = sprintf('(%d)', iShape);
%             if ~isempty(shape.Name)
%                 id = sprintf('%s "%s"', id, shape.Name);
%             end
%             fprintf('    %s: %s\n', id, class(shape.Geometry));  
%         end
    end
end % end methods

end % end classdef

