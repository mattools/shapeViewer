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
    function this = OpenPolygonSetInTableAction(viewer, varargin)
    % Constructor for OpenPolygonInTableAction class

        % calls the parent constructor
        this = this@sv.gui.ShapeViewerAction(viewer, 'openPolygonSetInTable');
    end

end % end constructors


%% Methods
methods
    function actionPerformed(this, src, event) %#ok<INUSD>
        disp('Open a set of polygons in a table');
        
        % get handle to parent figure, and current doc
        viewer = this.viewer;
        doc = viewer.doc;
        
        [fileName, pathName] = uigetfile( ...
            {
            '*.txt',                    'Text files (*.txt)'; ...
            '*.*',                      'All Files (*.*)'}, ...
            'Choose data table containing polygon vertices:', ...
            viewer.gui.lastOpenPath, ...
            'MultiSelect', 'off');
        
        if isequal(fileName,0) || isequal(pathName,0)
            return;
        end

        % save load path
        viewer.gui.lastOpenPath = pathName;
        
        importPolygonSet(fileName, pathName);
        
        updateDisplay(viewer);
        
        function importPolygonSet(fileName, pathName)
            % Inner function to read a polygon and add it the the document
            tab = Table.read(fullfile(pathName, fileName));
            
            % create polygon set
            for i = 1:size(tab, 1)
                coords  = rowToPolygon(tab.data(i,:), 'packed');
                shape   = Shape(Polygon2D(coords));
                shape.name = tab.rowNames{i};
            
                addShape(doc.scene, shape);
            end
        end
        
    end
end % end methods

end % end classdef

