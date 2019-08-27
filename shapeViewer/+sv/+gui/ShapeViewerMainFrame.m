classdef ShapeViewerMainFrame < handle
% A viewer that displays a SceneGraph.
%
%   Class ShapeViewerMainFrame
%
%   Example
%   ShapeViewerMainFrame
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
    % reference to the main GUI instance
    GUI;
   
    % list of handles to the various gui items
    Handles;
    
    % the document containing the scene
    Doc;
    
    % the set of mouse listeners.
    MouseListeners = [];
    
    % the currently selected tool
    CurrentTool = [];
    
    % the set of selected shapes, stored as a cell array
    SelectedShapes = [];

end % end properties


%% Constructor
methods
    function obj = ShapeViewerMainFrame(gui, doc)
        obj.GUI = gui;
        obj.Doc = doc;
        
        % create default figure
        fig = figure(...
            'MenuBar', 'none', ...
            'NumberTitle', 'off', ...
            'NextPlot', 'new', ...
            'Name', 'Shape Viewer');
        obj.Handles.Figure = fig;

        % create main figure menu
        buildFrameMenu(gui, obj);
        
        % setup layout
        setupLayout(obj);

        % refresh some displays
        updateDisplay(obj);
        updateTitle(obj);
        
        % setup listeners associated to the figure
        set(fig, ...
            'CloseRequestFcn', @obj.close, ...
            'ResizeFcn', @obj.onFigureResized);
        
        % setup mouse listeners associated to the figure
        set(fig, 'WindowButtonDownFcn',     @obj.processMouseButtonPressed);
        set(fig, 'WindowButtonUpFcn',       @obj.processMouseButtonReleased);
        set(fig, 'WindowButtonMotionFcn',   @obj.processMouseMoved);

        % setup mouse listener for display of mouse coordinates
        tool = sv.tools.ShowCursorPositionTool(obj, 'showMousePosition');
        addMouseListener(obj, tool);
        
        tool = sv.tools.SelectionTool(obj, 'selection');
        addMouseListener(obj, tool);
        obj.CurrentTool = tool;
        
        set(fig, 'UserData', obj);
    end
end

% helper methods for contructor
methods (Access = private)
    function setupLayout(obj)

        hf = obj.Handles.Figure;
        
        % compute background color of most widgets
        bgColor = get(0, 'defaultUicontrolBackgroundColor');
        if ispc
            bgColor = 'White';
        end
        set(hf, 'defaultUicontrolBackgroundColor', bgColor);

        % vertical layout for putting status bar on bottom
        mainPanel = uix.VBox('Parent', hf, ...
            'Units', 'normalized', ...
            'Position', [0 0 1 1]);

        % horizontal panel: main view nmiddle, options left and right
        horzPanel = uix.HBoxFlex('Parent', mainPanel);

        % panel for doc info
        % Contains uitree for shapes, and a panel for selection info
        docInfoPanel = uix.VBoxFlex('Parent', horzPanel);

        % create a default uittree
        treePanel = uipanel(...
            'Parent', docInfoPanel, ...
            'Position', [0 0 1 1], ...
            'BorderType', 'none', ...
            'BorderWidth', 0);

        obj.Handles.ShapeList = uicontrol(...
            'Style', 'listbox', ...
            'Parent', treePanel, ...
            'String', {'Circle', 'Poly1', 'Poly2', 'Ellipse'}, ...
            'Min', 1, 'Max', Inf, ...
            'Units', 'normalized', ...
            'Position', [0 0 1 1], ...
            'Callback', @obj.onShapeListModified);

%             displayOptionsPanel = uipanel(...
%                 'parent', docInfoPanel, ...
%                 'Position', [0 0 1 1], ...
%                 'BorderType', 'none', ...
%                 'BorderWidth', 0);
        displayOptionsPanel = uitable(...
            'Parent', docInfoPanel, ...
            'Position', [0 0 1 1] );


        docInfoPanel.Heights = [-1 -1];

        obj.Handles.DocInfoPanel = docInfoPanel;
        obj.Handles.DisplayOptionsPanel = displayOptionsPanel;


        % panel for image display
        displayPanel = uix.VBox('Parent', horzPanel);

        ax = axes('Parent', displayPanel, ...
            'Units', 'normalized', ...
            'DataAspectRatio', [1 1 1], ...
            'OuterPosition', [0 0 1 1], ...
            'XTick', [], ...
            'YTick', [], ...
            'Box', 'off');

        bounds = viewBox(doc.Scene);
        set(ax, 'XLim', bounds(1:2));
        set(ax, 'YLim', bounds(3:4));

        % keep widgets handles
        obj.Handles.MainAxis = ax;

        horzPanel.Widths = [180 -1];

        % info panel for cursor position and value
        obj.Handles.StatusBar = uicontrol(...
            'Parent', mainPanel, ...
            'Style', 'text', ...
            'String', ' x=    y=     I=', ...
            'HorizontalAlignment', 'left');

        % set up relative sizes of layouts
        mainPanel.Heights = [-1 20];
    end
    
end

%% Management of selected shapes
methods
    function clearSelection(obj)
        % remove all shapes in the selectedShapes field
        obj.SelectedShapes = [];
    end
    
    function addToSelection(obj, shape)
        obj.SelectedShapes = [obj.SelectedShapes shape];
    end
    
    function removeFromSelection(obj, shape)
        ind = find(shape == obj.SelectedShapes);
        if isempty(ind)
            warning('ShapeViewer:MainFrame:Selection', ...
                'could not find a shape in selection list');
            return;
        end
        obj.SelectedShapes(ind(1)) = [];
    end
    
    function onSelectionUpdated(obj)
        updateShapeSelectionDisplay(obj);
        updateShapeList(obj);
    end
end


%% General methods

methods
    
    function updateDisplay(obj)
        % refresh document display: clear axis, draw each shape, udpate axis
        
%         disp('update Display');
        
        ax = obj.Handles.MainAxis;
        if isempty(obj.Doc)
            set(ax, 'Visible', 'off');
        end
        
        % clear axis
        cla(ax);
        hold on;

        % extract scene info
        scene = obj.Doc.Scene;

        % initialize line handles for axis lines
        if scene.AxisLinesVisible
            hl1 = plot([0 1], [0 0], 'k-');
            hl2 = plot([0 0], [0 1], 'k-');
        end

        % draw each shape in the document
        tool = obj.CurrentTool;
        if ~isempty(scene.RootNode)
            drawNode(scene.RootNode);
        end
%         shapes = obj.Doc.Scene.Shapes;
%         for i = 1:length(shapes)
%             shape = shapes(i);
%             hs = draw(shape);
%             if ~isempty(tool)
%                 set(hs, 'buttonDownFcn', @tool.onMouseClicked);
%                 set(hs, 'UserData', shape);
%             end            
%             if any(shape == obj.SelectedShapes)
%                 set(hs, 'Selected', 'on');
%             end
%         end
        
        % set axis bounds from view box
        bounds = viewBox(scene);
        set(ax, 'XLim', bounds(1:2));
        set(ax, 'YLim', bounds(3:4));
            
        % draw lines for X and Y axes, based on current axis bounds
        if scene.AxisLinesVisible
            set(hl1, 'XData', bounds(1:2), 'Ydata', [0 0]);
            set(hl2, 'Xdata', [0 0], 'YData', bounds(3:4));
        end

        updateShapeList(obj);
        
%         disp('end of update Display');
        function drawNode(node)
            % recursively display the content of nodes, 
            % and associates listeners
            
            if isa(node, 'GroupNode')
                disp('group node');
                children = node.Children;
                for iChild = 1:length(children)
                    drawNode(children{iChild});
                end
            else
                % display a terminal node (leaf)
                hs = draw(node);
                if ~isempty(tool)
                    set(hs, 'buttonDownFcn', @tool.onMouseClicked);
                    set(hs, 'UserData', node);
                end            
                if any(node == obj.SelectedShapes)
                    set(hs, 'Selected', 'on');
                end
            end
        end
    end
    
    function updateShapeSelectionDisplay(obj)
        % update the selected state of each shape
        
        % extract the list of handles in current axis
        ax = obj.Handles.MainAxis;
        children = get(ax, 'Children');
        
        % iterate over children
        for i = 1:length(children)
            % Extract shape referenced by current handle, if any
            shape = get(children(i), 'UserData');
            if isempty(shape) || ~isa(shape, 'Shape')
                continue;
            end
            
            % update selection state of current shape
            if any(shape == obj.SelectedShapes)
                set(children(i), 'Selected', 'on');
            else
                set(children(i), 'Selected', 'off');
            end
        end
        
    end
    
    function updateTitle(obj)
        % set up title of the figure, containing name of doc
        title = sprintf('%s - ShapeViewer', obj.Doc.Name);
        set(obj.Handles.Figure, 'Name', title);
    end
    
    
    function updateShapeList(obj)
        % Refresh the shape tree when a shape is added or removed

        disp('update shape list');
        
        scene = obj.Doc.Scene;
%         nShapes = length(scene.Shapes);
%         shapeNames = cell(nShapes, 1);
%         inds = [];
%         for i = 1:nShapes
%             shape = scene.Shapes(i);
%             
%             % create name for current shape
%             name = shape.Name;
%             if isempty(shape.Name)
%                 name = ['(' class(shape.Geometry) ')'];
%             end
%             shapeNames{i} = name;
%             
%             % create the set of selected indices
%             if any(shape == obj.SelectedShapes)
%                 inds = [inds i]; %#ok<AGROW>
%             end
%         end
% 
%         % avoid empty indices, causing problems to gui...
%         if nShapes > 0 && isempty(inds)
%             inds = 1;
%         end
%         
%         set(obj.Handles.ShapeList, ...
%             'String', shapeNames, ...
%             'Max', nShapes, ...
%             'Value', inds);
    end
end


%% Mouse listeners management
methods
    function addMouseListener(obj, listener)
        % Add a mouse listener to obj viewer
        obj.MouseListeners = [obj.MouseListeners {listener}];
    end
    
    function removeMouseListener(obj, listener)
        % Remove a mouse listener from obj viewer
        
        % find which listeners are the same as the given one
        inds = false(size(obj.MouseListeners));
        for i = 1:numel(obj.MouseListeners)
            if obj.MouseListeners{i} == listener
                inds(i) = true;
            end
        end
        
        % remove first existing listener
        inds = find(inds);
        if ~isempty(inds)
            obj.MouseListeners(inds(1)) = [];
        end
    end
    
    function processMouseButtonPressed(obj, hObject, eventdata)
        % propagates mouse event to all listeners
        for i = 1:length(obj.MouseListeners)
            onMouseButtonPressed(obj.MouseListeners{i}, hObject, eventdata);
        end
    end
    
    function processMouseButtonReleased(obj, hObject, eventdata)
        % propagates mouse event to all listeners
        for i = 1:length(obj.MouseListeners)
            onMouseButtonReleased(obj.MouseListeners{i}, hObject, eventdata);
        end
    end
    
    function processMouseMoved(obj, hObject, eventdata)
        % propagates mouse event to all listeners
        for i = 1:length(obj.MouseListeners)
            onMouseMoved(obj.MouseListeners{i}, hObject, eventdata);
        end
    end
end


%% Widget callbacks

methods
    function onShapeListModified(obj, varargin)
        
%         disp('shape list updated');
        
%         inds = get(obj.Handles.ShapeList, 'Value');
%         if isempty(inds)
%             return;
%         end
%         
%         obj.SelectedShapes = obj.Doc.Scene.Shapes(inds);
%         updateShapeSelectionDisplay(obj);
    end
end

%% Figure management
methods
    function close(obj, varargin)
        disp('Close shape viewer frame');
        delete(obj.Handles.Figure);
    end
    
    function onFigureResized(obj, varargin)
        updateShapeSelectionDisplay(obj);
    end
end


end % end classdef

