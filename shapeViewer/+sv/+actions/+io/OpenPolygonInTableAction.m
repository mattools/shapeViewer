classdef OpenPolygonInTableAction < sv.gui.ShapeViewerAction
%OpenPolygonInTableAction  Open a polygon whose coords are stored in a table file 
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
% e-mail: david.legland@inra.fr
% Created: 2012-01-29,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.


%% Properties
properties
end % end properties


%% Constructor
methods
    function obj = OpenPolygonInTableAction(varargin)
    % Constructor for OpenPolygonInTableAction class

        % calls the parent constructor
        obj = obj@sv.gui.ShapeViewerAction('openPolygonInTable');
    end

end % end constructors


%% Methods
methods
    function run(obj, viewer) %#ok<INUSL>
        disp('Open a polygon in table');
        
        % get handle to parent figure, and current doc
        doc = viewer.Doc;
        
        [fileName, pathName] = uigetfile( ...
            {
            '*.txt',                    'Text files (*.txt)'; ...
            '*.*',                      'All Files (*.*)'}, ...
            'Choose data table containing polygon vertices:', ...
            viewer.GUI.LastOpenPath, ...
            'MultiSelect', 'on');
        
        if isequal(fileName,0) || isequal(pathName,0)
            return;
        end

        % save load path
        viewer.GUI.LastOpenPath = pathName;
        
        if ischar(fileName)
            importPolygon(fileName, pathName);
        elseif iscell(fileName)
            for i = 1:length(fileName)
                importPolygon(fileName{i}, pathName);
            end
        end
        
        updateDisplay(viewer);
        
        function importPolygon(fileName, pathName)
            % Inner function to read a polygon and add it the the document
            tab = Table.read(fullfile(pathName, fileName));
            
            % create polygon
            poly    = Polygon2D(tab.data);
            shape   = ShapeNode(poly);
            
            [path, name] = fileparts(fileName); %#ok<ASGLU>
            shape.Name = name;
            
%             addShape(doc.Scene, shape);
            % add the new shape to the root node
            add(doc.Scene.RootNode, shape);

            box = viewBox(viewer.Doc.Scene);
            bbox = boundingBox(tab.Data);
            box(1) = min(box(1), bbox(1));
            box(2) = max(box(2), bbox(2));
            box(3) = min(box(3), bbox(3));
            box(4) = max(box(4), bbox(4));
            doc.Scene.XAxis.Limits = box(1:2);
            doc.Scene.YAxis.Limits = box(3:4);
            doc.Scene.ZAxis.Limits = box(5:6);
            
        end
        
    end
end % end methods

end % end classdef

