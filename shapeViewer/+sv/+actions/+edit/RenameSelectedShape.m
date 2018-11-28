classdef RenameSelectedShape < sv.gui.ShapeViewerAction
% Rename the selected shape
%
%   Class RenameSelectedShape
%
%   Example
%   RenameSelectedShape
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2012-04-13,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.


%% Properties
properties
end % end properties


%% Constructor
methods
    function this = RenameSelectedShape(varargin)
    % Constructor for RenameSelectedShape class

        % calls the parent constructor
        this = this@sv.gui.ShapeViewerAction('renameSelection');
    end

end % end constructors


%% Methods
methods
    function run(this, viewer)  %#ok<*INUSL>
        disp('rename');
        
        % get handle to parent viewer, and selected shapes
        shapes = viewer.selectedShapes;
        
        % basic input checks
        if isempty(shapes)
            return;
        end
        if length(shapes) > 1
            errordlg('Can not rename multiple shapes', 'Selection Error', 'modal');
            return;
        end
            
        % extract shape name, or create one if necessary
        shape = shapes(1);
        name = shape.name;
        if isempty(name)
            name = ['(' class(shape.geometry) ')'];
        end
        
        % input the new shape name
        answer = inputdlg('Input new name:', ...
            'Rename selection', 1, ...
            {name});
        if isempty(answer) 
            return;
        end
        
        shape.name = answer{1};
        updateDisplay(viewer);
    end
end % end methods

end % end classdef

