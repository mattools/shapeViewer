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
        scene = SceneGraph();
        scene.RootNode = GroupNode();
        scene.RootNode.Name = 'Shapes';
        
        % create associated viewer
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
    
    function buildFrameMenu(obj, frame)
        import sv.actions.*;
        import sv.actions.io.*;
        import sv.actions.edit.*;
        import sv.actions.process.*;
        import sv.actions.view.*;
        import sv.tools.*;

        % File Menu Definition 

        hf = frame.Handles.Figure;
        fileMenu = uimenu(hf, 'Label', '&Files');

        addMenuItem(fileMenu, CreateNewDocAction(), '&New Document');

        action = OpenSceneGraph('openSceneGraph');
        addMenuItem(fileMenu, action, 'Open Scene Graph...', true);
        action = OpenSceneAction('openScene');
        addMenuItem(fileMenu, action, 'Open Scene...');
        action = ImportGeometryFile('importGeometryFile');
        addMenuItem(fileMenu, action, 'Import Geometry', true);
        action = OpenPointsInTableAction('openPointSetInTable');
        addMenuItem(fileMenu, action, 'Import Point &Set');
        action = OpenPolygonInTableAction('openPolygonInTable');
        addMenuItem(fileMenu, action, 'Import Polygon');
        action = OpenPolygonSetInTableAction('openPolygonSetInTable');
        addMenuItem(fileMenu, action, 'Import Polygon Set');

        addMenuItem(fileMenu, SaveScene(), 'Save As...', true);

        action = CloseCurrentDocAction('closeDoc');
        addMenuItem(fileMenu, action, '&Close', true);


        % Edit Menu Definition 

        editMenu = uimenu(hf, 'Label', '&Edit');
        addMenuItem(editMenu, SelectAllShapes(obj),      'Select &All');
        addMenuItem(editMenu, DeleteSelectedShapes(), '&Clear Selection');
        addMenuItem(editMenu, PrintSceneInfo(), 'Scene Info', true);
%       addMenuItem(editMenu, SetSelectedShapeStyleAction(obj),  'Set Display Style...', true);
        addMenuItem(editMenu, SetSelectedShapesLineColor(obj),  'Set Selection Line Color...', true);
        addMenuItem(editMenu, SetSelectedShapesLineWidth(obj),  'Set Selection Line Width...');
        addMenuItem(editMenu, RenameSelectedShape(obj),  '&Rename', true);

        viewMenu = uimenu(hf, 'Label', '&View');
        addMenuItem(viewMenu, SetAxisBounds(), 'Set Axis Bounds...');
%         addMenuItem(viewMenu, ToggleBackgroundImageDisplay(), 'Toggle Background Image Display', true);
        addMenuItem(viewMenu, ZoomInAction(), 'Zoom &In', true);
        addMenuItem(viewMenu, ZoomOutAction(), 'Zoom &Out');

%          % Document Menu Definition 
%             
%             docMenu = uimenu(hf, 'Label', '&Document');
%             addMenuItem(docMenu, AddNewDemoShapeAction(obj), 'Add Demo Shape');
%             addMenuItem(docMenu, AddPaperHenShapeAction(obj), 'Add Paper Hen Shape');
%             addMenuItem(docMenu, AddRandomPointsAction(obj), 'Add Random Points');
%             addMenuItem(docMenu, DisplaySelectionInfoAction(obj), 'Display &Info', true);
%             addMenuItem(docMenu, SetDocumentViewBoxAction(obj), 'Set &View Box...', true);
%             addMenuItem(docMenu, ToggleDocumentShowAxisLinesAction(obj), 'Toggle &Axis Lines');
%             addMenuItem(docMenu, ChangeUserUnitAction(obj), 'Change &Unit...');
%             addMenuItem(docMenu, RenameCurrentDocAction(obj), '&Rename...');
%             

       % Process Menu Definition 

        processMenu = uimenu(hf, 'Label', '&Process');

%         % geometric transform of shapes
%         addMenuItem(processMenu, FlipShapeHorizAction(obj), '&Horizontal Flip');
%         addMenuItem(processMenu, FlipShapeVertAction(obj), '&Vertical Flip');
        addMenuItem(processMenu, RecenterSelectedShapes(frame), 'Recenter');
%         addMenuItem(processMenu, TranslateShapeAction(obj), '&Translate...');
%         addMenuItem(processMenu, ScaleShapeAction(obj), '&Scale...');
%         addMenuItem(processMenu, RotateShapeAction(obj), '&Rotate...');
% 
%         % computation of derived shapes
%         addMenuItem(processMenu, AddShapeBoundingBoxAction(obj), '&Bounding Box', true);
%         addMenuItem(processMenu, AddShapeOrientedBoxAction(obj), '&Oriented Box');
%         addMenuItem(processMenu, AddShapeConvexHullAction(obj), '&Convex Hull');
%         addMenuItem(processMenu, AddShapeInertiaEllipseAction(obj), 'Inertia &Ellipse');
%             
%         % operations on polygons
%         addMenuItem(processMenu, SimplifyPolygonAction(obj), ...
%             'Simplify Polygon/Polyline', true);
%             
%             
        % Tools Menu Definition 
        toolsMenu = uimenu(hf, 'Label', '&Tools');
        addMenuItem(toolsMenu, ...
            SelectToolAction(CreateMultiPointTool(frame)), ...
            'Create &MultiPoint');
        addMenuItem(toolsMenu, ...
            SelectToolAction(CreatePolygonTool(frame)), ...
            'Create &Polygon');
        addMenuItem(toolsMenu, ...
            SelectToolAction(SelectionTool(frame)), ...
            'Selection', true);

        function item = addMenuItem(menu, action, label, varargin)
            
            % creates new item
            item = uimenu(menu, 'Label', label, ...
                'Callback', @(src, evt) action.run(frame));
            
            if ~isActivable(action, frame)
                set(item, 'Enable', false);
            end
            
            % eventually add separator above item
            if ~isempty(varargin)
                var = varargin{1};
                if islogical(var)
                    set(item, 'Separator', 'On');
                end
            end
        end

    end
end

end % end classdef

