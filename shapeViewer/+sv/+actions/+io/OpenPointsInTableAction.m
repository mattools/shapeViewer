classdef OpenPointsInTableAction < sv.gui.ShapeViewerAction
%OpenPointsInTableAction  Open a point set whose coords are stored in a table file 
%
%   Class OpenPointsInTableAction
%
%   Example
%   OpenPointsInTableAction
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
    function this = OpenPointsInTableAction(varargin)
    % Constructor for OpenPointsInTableAction class

        % calls the parent constructor
        this = this@sv.gui.ShapeViewerAction('openPointsInTable');
    end

end % end constructors


%% Methods
methods
    function run(this, viewer) %#ok<INUSL>
        disp('Open a point set in a table');
        
        % get handle to parent figure, and current doc
        doc = viewer.doc;
        
        [fileName, pathName] = uigetfile( ...
            {
            '*.txt',                    'Text files (*.txt)'; ...
            '*.*',                      'All Files (*.*)'}, ...
            'Choose data table containing coordinates:', ...
            viewer.gui.lastOpenPath, ...
            'MultiSelect', 'on');
        
        if isequal(fileName,0) || isequal(pathName,0)
            return;
        end

        % save load path
        viewer.gui.lastOpenPath = pathName;

        if ischar(fileName)
            importPoints(fileName, pathName);
        elseif iscell(fileName)
            for i = 1:length(fileName)
                importPoints(fileName{i}, pathName);
            end
        end
        
        updateDisplay(viewer);
        
        function importPoints(fileName, pathName)
            % Inner function to read a point set and add it the the document
            tab = Table.read(fullfile(pathName, fileName));
            
            % create point set
            pts     = MultiPoint2D(tab.data);
            shape   = Shape(pts);
            
            [path, name] = fileparts(fileName); %#ok<ASGLU>
            shape.name = name;
            
           addShape(doc.scene, shape);
        end
        
    end
end % end methods

end % end classdef

