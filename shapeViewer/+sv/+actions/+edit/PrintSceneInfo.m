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
    function this = PrintSceneInfo(varargin)
        % Constructor for PrintSceneInfo class

        % calls the parent constructor
        this = this@sv.gui.ShapeViewerAction('printInfo');
    end

end % end constructors


%% Methods
methods
    function run(this, viewer)  %#ok<*INUSL>
        disp('Open a scene file');
        
        % get handle to parent figure, and current doc
        scene = viewer.doc.scene;
        
        disp('Scene Info: ');
        fprintf('  xlim: [ %f ; %f ]\n', scene.xAxis.limits);  
        fprintf('  ylim: [ %f ; %f ]\n', scene.yAxis.limits);  
        fprintf('  zlim: [ %f ; %f ]\n', scene.zAxis.limits);
        if ~isempty(scene.backgroundImage)
            fprintf('  backgroundImage: %s\n', scene.backgroundImage.filePath);  
        end
        fprintf('  shapes:\n');  
        for iShape = 1:length(scene.shapes)
            shape = scene.shapes(iShape);
            id = sprintf('(%d)', iShape);
            if ~isempty(shape.name)
                id = sprintf('%s "%s"', id, shape.name);
            end
            fprintf('    %s: %s\n', id, class(shape.geometry));  
        end
    end
end % end methods

end % end classdef

