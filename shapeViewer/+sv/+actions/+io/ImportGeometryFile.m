classdef ImportGeometryFile < sv.gui.ShapeViewerAction
% Open a polygon whose coords are stored in a table file 
%
%   Class ImportGeometryFile
%
%   Example
%   ImportGeometryFile
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2018-11-19,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.


%% Properties
properties
end % end properties


%% Constructor
methods
    function this = ImportGeometryFile(varargin)
    % Constructor for ImportGeometryFile class

        % calls the parent constructor
        this = this@sv.gui.ShapeViewerAction('importGeometryFile');
    end

end % end constructors


%% Methods
methods
    function run(this, viewer) %#ok<INUSL>
        disp('import a geometry file');
        
        % get handle to parent figure, and current doc
        doc = viewer.doc;
        
        [fileName, pathName] = uigetfile( ...
            {
            '*.geometry',               'Geometry files (*.geometry)'; ...
            '*.*',                      'All Files (*.*)'}, ...
            'Choose geometry file:', ...
            viewer.gui.lastOpenPath, ...
            'MultiSelect', 'on');
        
        if isequal(fileName,0) || isequal(pathName,0)
            return;
        end

        % save load path
        viewer.gui.lastOpenPath = pathName;
        
        if ischar(fileName)
            importGeometry(fileName, pathName);
        elseif iscell(fileName)
            for i = 1:length(fileName)
                importGeometry(fileName{i}, pathName);
            end
        end
        
        updateDisplay(viewer);
        
        function importGeometry(fileName, pathName)
            % Inner function to read a geometry and add it the the document
            
            geom = Geometry.read(fullfile(pathName, fileName));
            
            % create shape
            shape   = Shape(geom);
            
            [path, name] = fileparts(fileName); %#ok<ASGLU>
            shape.name = name;
            
            addShape(doc.scene, shape);
            
            if ismethod(geom, 'boundingBox')
                box = viewBox(viewer.doc.scene);
                bbox = boundingBox(geom);
                box(1) = min(box(1), bbox.xmin);
                box(2) = max(box(2), bbox.xmax);
                box(3) = min(box(3), bbox.ymin);
                box(4) = max(box(4), bbox.ymax);
                doc.scene.xAxis.limits = box(1:2);
                doc.scene.yAxis.limits = box(3:4);
                doc.scene.zAxis.limits = box(5:6);
            end
        end
        
    end
end % end methods

end % end classdef

