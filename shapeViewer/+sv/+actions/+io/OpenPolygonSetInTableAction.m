classdef OpenPolygonSetInTableAction < sv.gui.ShapeViewerAction
%OpenPolygonSetInTableAction  Open a set of polygons whose coords are stored in a table file 
%
%   Class OpenPolygonInTableAction
%
%   Example
%   OpenPolygonInTableAction
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2012-01-29,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.


%% Properties
properties
end % end properties


%% Constructor
methods
    function obj = OpenPolygonSetInTableAction(varargin)
    % Constructor for OpenPolygonInTableAction class

        % calls the parent constructor
        obj = obj@sv.gui.ShapeViewerAction('openPolygonSetInTable');
    end

end % end constructors


%% Methods
methods
    function run(obj, viewer) %#ok<INUSL>
        disp('Open a set of polygons in a table');
        
        % get handle to parent figure, and current doc
        doc = viewer.Doc;
        
        [fileName, pathName] = uigetfile( ...
            {
            '*.txt',                    'Text files (*.txt)'; ...
            '*.*',                      'All Files (*.*)'}, ...
            'Choose data table containing polygon vertices:', ...
            viewer.gui.LastOpenPath, ...
            'MultiSelect', 'off');
        
        if isequal(fileName,0) || isequal(pathName,0)
            return;
        end

        % save load path
        viewer.GUI.LastOpenPath = pathName;
        
        importPolygonSet(fileName, pathName);
        
        updateDisplay(viewer);
        
        function importPolygonSet(fileName, pathName)
            % Inner function to read a polygon and add it the the document
            tab = Table.read(fullfile(pathName, fileName));
            
            box = viewBox(viewer.Doc.Scene);
            
            % create polygon set
            for i = 1:size(tab, 1)
                coords  = rowToPolygon(tab.data(i,:), 'packed');
                shape   = Shape(Polygon2D(coords));
                shape.Name = tab.rowNames{i};
            
                addShape(doc.scene, shape);
                
                bbox = boundingBox(tab.data);
                box(1) = min(box(1), bbox(1));
                box(2) = max(box(2), bbox(2));
                box(3) = min(box(3), bbox(3));
                box(4) = max(box(4), bbox(4));
            end
            
            doc.Scene.XAxis.Limits = box(1:2);
            doc.Scene.YAxis.Limits = box(3:4);
            doc.Scene.ZAxis.Limits = box(5:6);
           
        end
        
    end
end % end methods

end % end classdef

