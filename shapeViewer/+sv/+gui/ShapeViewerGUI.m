classdef ShapeViewerGUI < handle
%Manages the different frames of the ShapeViewer application
%
%   Class ShapeViewerGUI
%
%   Example
%   ShapeViewerGUI
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
    % the list of open frames
    frameList;
    
    % remember where files were loaded and saved
    lastOpenPath = '.';
    lastSavePath = '.';

end % end properties


%% Constructor
methods
    function this = ShapeViewerGUI(varargin)
        % ShapeViewerGUI constructor
        %

    end

end % end constructors



%% General methods
methods
    function frame = createNewEmptyDocument(this)
        % Create a new empty scene, add to app, display it, and return it
        
        % creates new Scene instance
        scene = sv.app.Scene();
        doc = sv.app.ShapeViewerDoc(scene);
        
        % creates a display for the new image
        frame = sv.gui.ShapeViewerMainFrame(this, doc);
        addFrame(this, frame);
        
    end
    
    function exit(this) %#ok<MANU>
        % EXIT 
        disp('exit');
    end
    
end % general methods

%% Frame management
methods
    function addFrame(this, frame)
        this.frameList = [this.frameList frame];
    end
end

end % end classdef

