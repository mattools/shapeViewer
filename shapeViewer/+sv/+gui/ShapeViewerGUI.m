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
    FrameList;
    
    % remember where files were loaded and saved
    LastOpenPath = '.';
    LastSavePath = '.';

end % end properties


%% Constructor
methods
    function obj = ShapeViewerGUI(varargin)
        % ShapeViewerGUI constructor
        %

    end

end % end constructors



%% General methods
methods
    function frame = createNewEmptyDocument(obj)
        % Create a new empty scene, add to app, display it, and return it
        
        % creates new Scene instance
        scene = Scene();
        frame = createSceneViewer(obj, scene);
    end
    
    function frame = createSceneViewer(obj, scene)
        % Create a new empty scene, add to app, display it, and return it
        
        % creates new Scene instance
        doc = sv.app.ShapeViewerDoc(scene);
        
        % creates a display for the new image
        frame = sv.gui.ShapeViewerMainFrame(obj, doc);
        addFrame(obj, frame);
        
    end
    

    function exit(obj) %#ok<MANU>
        % EXIT 
        disp('exit');
    end
    
end % general methods

%% Frame management
methods
    function addFrame(obj, frame)
        obj.FrameList = [obj.FrameList frame];
    end
end

end % end classdef

