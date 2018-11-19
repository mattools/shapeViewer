function varargout = ShapeViewer(varargin) 
%SHAPEVIEWER GUI for geometrical shapes display and manipulation
%
%   Usage:
%   ShapeViewer
%   Opens a new shape viewer instance with an empty scene.
%
%   ShapeViewer(SHAPE)
%   Opens a new shape viewer instance initialized with the give shape.
%
%   ShapeViewer(SHAPEDATA)
%   
%
%   Example
%   ShapeViewer
%
%   See also
%   sv.app.ShapeViewerDoc, sv.gui.ShapeViewerGUI, Shape, Scene

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2011-11-27,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

import sv.gui.ShapeViewerGUI;

% create the application, and a GUI
gui = ShapeViewerGUI();

% initialize a new document from the GUI
viewer = createNewEmptyDocument(gui);

% % if arguments are given, assume this is a shape
% if ~isempty(varargin)
%     % assumes shape is given as DATA + eventually type
%     data = varargin{1};
%     if length(varargin) > 1
%         type = varargin{2};
%     else
%         type = 'polygon';
%     end
%     addShape(viewer, data, type, varargin{3:end});
% end

if nargout > 0
    varargout = {viewer};
end
