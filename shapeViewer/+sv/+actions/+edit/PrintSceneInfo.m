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
        disp(sprintf('  xlim: [ %f ; %f ]', scene.xAxis.limits));  
        disp(sprintf('  ylim: [ %f ; %f ]', scene.yAxis.limits));  
        disp(sprintf('  zlim: [ %f ; %f ]', scene.zAxis.limits));  
        disp(sprintf('  shape number: %d', length(scene.shapes)));  
    end
end % end methods

end % end classdef

