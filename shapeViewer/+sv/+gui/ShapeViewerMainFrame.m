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
    SelectedNodeList = [];

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
        
        % setup layout (can be slow first time GUI Layout is activated)
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
            'String', {}, ...
            'Min', 1, 'Max', Inf, ...
            'Units', 'normalized', ...
            'Position', [0 0 1 1], ...
            'Callback', @obj.onShapeListModified);

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

        bounds = viewBox(obj.Doc.Scene);
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
        obj.SelectedNodeList = [];
    end
    
    function addToSelection(obj, node)
        obj.SelectedNodeList = [obj.SelectedNodeList node];
    end
    
    function removeFromSelection(obj, node)
        ind = find(node == obj.SelectedNodeList);
        if isempty(ind)
            warning('ShapeViewer:MainFrame:Selection', ...
                'could not find a node in selection list');
            return;
        end
        obj.SelectedNodeList(ind(1)) = [];
    end
    
    function onSelectionUpdated(obj)
        updateShapeSelectionDisplay(obj);
        updateShapeListDisplay(obj);
    end
    
    function b = isNodeSelect(obj, node)
        b = any(node == obj.SelectedNodeList);
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
        
        % set axis bounds from view box
        bounds = viewBox(scene);
        set(ax, 'XLim', bounds(1:2));
        set(ax, 'YLim', bounds(3:4));
            
        % draw lines for X and Y axes, based on current axis bounds
        if scene.AxisLinesVisible
            set(hl1, 'XData', bounds(1:2), 'Ydata', [0 0]);
            set(hl2, 'Xdata', [0 0], 'YData', bounds(3:4));
        end

        updateShapeListDisplay(obj);

        
        function drawNode(node)
            % inner function that recursively displays the content of nodes
            % and associates listeners
            
            if isa(node, 'GroupNode')
                % recursively display children
                for iChild = 1:length(node.Children)
                    drawNode(node.Children{iChild});
                end
            else
                % display a terminal node (leaf)
                hs = draw(node);
                set(hs, 'UserData', node);
                if ~isempty(tool)
                    set(hs, 'buttonDownFcn', @tool.onMouseClicked);
                end
                
                % set selection flag if needed
                if any(node == obj.SelectedNodeList)
                    set(hs, 'Selected', 'On');
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
            node = get(children(i), 'UserData');
            if isempty(node) || ~isa(node, 'ShapeNode')
                continue;
            end
            
            % update selection state of current shape
            if isNodeSelect(obj, node)
                set(children(i), 'Selected', 'On');
            else
                set(children(i), 'Selected', 'Off');
            end
        end
        
    end
    
    function updateTitle(obj)
        % set up title of the figure, containing name of doc
        title = sprintf('%s - ShapeViewer', obj.Doc.Name);
        set(obj.Handles.Figure, 'Name', title);
    end
    
    
    function updateShapeListDisplay(obj)
        % Refresh the shape tree when a shape is added or removed

%         disp('update shape list');
        
        scene = obj.Doc.Scene;
        
        % create a list of list items, with corresponding node as UserData
        inds = [];
        [nodeNames, nodeList, inds] = processNode(scene.RootNode, cell(0,1), cell(0,1), inds);
        
        % avoid empty indices, causing problems to gui...
        nShapes = length(nodeNames);
        if nShapes > 0 && isempty(inds)
            inds = 1;
        end

        set(obj.Handles.ShapeList, ...
            'String', nodeNames, ...
            'Max', nShapes, ...
            'Value', inds, ...
            'UserData', nodeList);

        function [nodeNames, nodeList, inds] = processNode(node, nodeNames, nodeList, inds)
            
            % create name for current shape
            name = node.Name;
            if isempty(name)
                name = ['(' class(node) ')'];
            end
            
            % update the lists
            nodeNames = [nodeNames ; {name}];
            nodeList = [nodeList ; {node}];
            
            if find(obj.SelectedNodeList == node)
                inds = [inds ; length(nodeNames)];
            end
            
            % if recursice, process children
            if isa(node, 'GroupNode')
                for iChild = 1:length(node.Children)
                    child = node.Children{iChild};
                    [nodeNames, nodeList, inds] = processNode(child, nodeNames, nodeList, inds);
                end
            end
        end
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
        
        inds = get(obj.Handles.ShapeList, 'Value');
        if isempty(inds)
            return;
        end
        
        nodeList = get(obj.Handles.ShapeList, 'UserData');
        obj.SelectedNodeList = nodeList{inds};
        updateShapeSelectionDisplay(obj);
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

