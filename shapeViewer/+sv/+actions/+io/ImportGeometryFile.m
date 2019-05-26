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
    function obj = ImportGeometryFile(varargin)
    % Constructor for ImportGeometryFile class

        % calls the parent constructor
        obj = obj@sv.gui.ShapeViewerAction('importGeometryFile');
    end

end % end constructors


%% Methods
methods
    function run(obj, viewer) %#ok<INUSL>
        disp('import a geometry file');
        
        % get handle to parent figure, and current doc
        doc = viewer.Doc;
        
        [fileName, pathName] = uigetfile( ...
            {
            '*.geometry',               'Geometry files (*.geometry)'; ...
            '*.*',                      'All Files (*.*)'}, ...
            'Choose geometry file:', ...
            viewer.GUI.LastOpenPath, ...
            'MultiSelect', 'on');
        
        if isequal(fileName,0) || isequal(pathName,0)
            return;
        end

        % save load path
        viewer.GUI.LastOpenPath = pathName;
        
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
            shape   = ShapeNode(geom);
            
            [path, name] = fileparts(fileName); %#ok<ASGLU>
            shape.Name = name;
            
%             addShape(doc.Scene, shape);
            % add the new shape to the root node
            add(doc.Scene.RootNode, shape);
            
            if ismethod(geom, 'boundingBox')
                box = viewBox(viewer.Doc.Scene);
                bbox = boundingBox(geom);
                box(1) = min(box(1), bbox.XMin);
                box(2) = max(box(2), bbox.XMax);
                box(3) = min(box(3), bbox.YMin);
                box(4) = max(box(4), bbox.YMax);
                doc.Scene.XAxis.Limits = box(1:2);
                doc.Scene.YAxis.Limits = box(3:4);
                doc.Scene.ZAxis.Limits = box(5:6);
            else
                warning('class %s does not implement boundingBox', class(geom));
            end
        end
        
    end
end % end methods

end % end classdef

