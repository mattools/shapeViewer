classdef SaveScene < sv.gui.ShapeViewerAction
%OPENSCENEACTION  save the scene contained in the current doc
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
    function obj = SaveScene(varargin)
        % Constructor for OpenSceneAction class

        % calls the parent constructor
        obj = obj@sv.gui.ShapeViewerAction('saveScene');
    end

end % end constructors


%% Methods
methods
    function run(obj, viewer) %#ok<INUSL>
        disp('save current scene');
        
        [fileName, pathName] = uiputfile( ...
            {
            '*.sceneGraph',              'Scene files (*.sceneGraph)'; ...
            '*.*',                      'All Files (*.*)'}, ...
            'Choose scene file:', ...
            viewer.GUI.LastSavePath);
        
        if isequal(fileName,0) || isequal(pathName,0)
            return;
        end

        % save load path
        viewer.GUI.LastSavePath = pathName;
        
        % read the scene frmthe file
        write(viewer.Doc.Scene, fullfile(pathName, fileName));
        
    end
end % end methods

end % end classdef

