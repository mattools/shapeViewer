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
    function this = OpenPolygonInTableAction(varargin)
    % Constructor for OpenPolygonInTableAction class

        % calls the parent constructor
        this = this@sv.gui.ShapeViewerAction('openPolygonInTable');
    end

end % end constructors


%% Methods
methods
    function run(this, viewer) %#ok<INUSL>
        disp('Open a polygon in table');
        
        % get handle to parent figure, and current doc
        doc = viewer.doc;
        
        [fileName, pathName] = uigetfile( ...
            {
            '*.txt',                    'Text files (*.txt)'; ...
            '*.*',                      'All Files (*.*)'}, ...
            'Choose data table containing polygon vertices:', ...
            viewer.gui.lastOpenPath, ...
            'MultiSelect', 'on');
        
        if isequal(fileName,0) || isequal(pathName,0)
            return;
        end

        % save load path
        viewer.gui.lastOpenPath = pathName;
        
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
            shape   = Shape(poly);
            
            [path, name] = fileparts(fileName); %#ok<ASGLU>
            shape.name = name;
            
            addShape(doc.scene, shape);
        end
        
    end
end % end methods

end % end classdef

