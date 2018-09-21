classdef OpenSceneAction < sv.gui.ShapeViewerAction
%OPENSCENEACTION  One-line description here, please.
%
%   Class OpenSceneAction
%
%   Example
%   OpenSceneAction
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
    function this = OpenSceneAction(varargin)
        % Constructor for OpenSceneAction class

        % calls the parent constructor
        this = this@sv.gui.ShapeViewerAction('openScene');
    end

end % end constructors


%% Methods
methods
    function run(this, viewer) %#ok<INUSL>
        disp('Open a scene file');
        
        [fileName, pathName] = uigetfile( ...
            {
            '*.scene',                    'Scene files (*.scene)'; ...
            '*.*',                      'All Files (*.*)'}, ...
            'Choose data table containing polygon vertices:', ...
            viewer.gui.lastOpenPath, ...
            'MultiSelect', 'on');
        
        if isequal(fileName,0) || isequal(pathName,0)
            return;
        end

        % save load path
        viewer.gui.lastOpenPath = pathName;
        
        % read the scene frmthe file
        scene = Scene.read(fullfile(pathName, fileName));
        
        % create a new viewer
        viewer = createSceneViewer(viewer.gui, scene);
                    
        updateDisplay(viewer);
        
    end
end % end methods

end % end classdef

