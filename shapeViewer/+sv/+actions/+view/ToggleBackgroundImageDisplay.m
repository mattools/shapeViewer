classdef ToggleBackgroundImageDisplay < sv.gui.ShapeViewerAction
%ZoomInAction add a set of random points to current doc
%
%   Class ZoomInAction
%
%   Example
%   ZoomInAction
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
    function obj = ToggleBackgroundImageDisplay(varargin)
    % Constructor for ToggleBackgroundImageDisplay class

        % calls the parent constructor
        obj = obj@sv.gui.ShapeViewerAction('ToggleBackgroundImageDisplay');
    end

end % end constructors


%% Methods
methods
    function run(obj, viewer) %#ok<INUSL>
        
        % get handle to parent figure, and current doc
        viewer.Doc.DisplayBackgroundImage = ~viewer.Doc.DisplayBackgroundImage;
        viewer.Doc.Modified = true;
        
        updateDisplay(viewer); 
    end
    
    function b = isActivable(obj, viewer) %#ok<INUSL>
        b = ~isempty(viewer.Doc.Scene.BackgroundImage);
    end
    
end % end methods

end % end classdef

