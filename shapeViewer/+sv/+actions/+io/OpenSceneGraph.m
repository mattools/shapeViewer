classdef OpenSceneGraph < sv.gui.ShapeViewerAction
%OPENSCENEACTION Open a scene file
%
%   Class OpenSceneGraph
%
%   Example
%   OpenSceneGraph
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
    function obj = OpenSceneGraph(varargin)
        % Constructor for OpenSceneGraph class

        % calls the parent constructor
        obj = obj@sv.gui.ShapeViewerAction('openSceneGraph');
    end

end % end constructors


%% Methods
methods
    function run(obj, viewer) %#ok<INUSL>
        disp('Open a scene graph file');
        
        [fileName, pathName] = uigetfile( ...
            {
            '*.sceneGraph',             'SceneGraph files (*.sceneGraph)'; ...
            '*.*',                      'All Files (*.*)'}, ...
            'Choose file containing scene graph:', ...
            viewer.GUI.LastOpenPath, ...
            'MultiSelect', 'off');
        
        if isequal(fileName,0) || isequal(pathName,0)
            return;
        end

        % save load path
        viewer.GUI.LastOpenPath = pathName;
        
        % read the scene graph from the file
        scene = SceneGraph.read(fullfile(pathName, fileName));
        
        % create a new viewer
        viewer = createSceneViewer(viewer.GUI, scene);
        [tmp, baseName] = fileparts(fileName); %#ok<ASGLU>
        viewer.Doc.Name = baseName;
        
        updateTitle(viewer);
        updateDisplay(viewer);
        
    end
end % end methods

end % end classdef

