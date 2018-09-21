classdef SetAxisBounds < sv.gui.ShapeViewerAction
%SETAXISBOUNDS  One-line description here, please.
%
%   Class SetAxisBounds
%
%   Example
%   SetAxisBounds
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
end % end properties


%% Constructor
methods
    function this = SetAxisBounds(varargin)
    % Constructor for SetAxisBounds class

        % calls the parent constructor
        this = this@sv.gui.ShapeViewerAction('setAxisBounds');
    end

end % end constructors


%% Methods
methods
    function run(this, viewer) %#ok<INUSL>

        % get current scene
        scene = viewer.doc.scene;
        
        % define dialog options
        prompt = {...
            sprintf('XAxis Min bound (%f):', scene.xAxis.limits(1)), ...
            sprintf('XAxis Max bound (%f):', scene.xAxis.limits(2)), ...
            sprintf('YAxis Min bound (%f):', scene.yAxis.limits(1)), ...
            sprintf('YAxis Max bound (%f):', scene.yAxis.limits(2)), ...
            sprintf('ZAxis Min bound (%f):', scene.zAxis.limits(1)), ...
            sprintf('ZAxis Max bound (%f):', scene.zAxis.limits(2)) };
        title = 'Scene bounds';
        nbLines = 1;
        default = {...
            num2str(scene.xAxis.limits(1)), num2str(scene.xAxis.limits(2)), ...
            num2str(scene.yAxis.limits(1)), num2str(scene.yAxis.limits(2)), ...
            num2str(scene.zAxis.limits(1)), num2str(scene.zAxis.limits(2)) };
        
        % open the dialog
        answers = inputdlg(prompt, title, nbLines, default);

        % if user cancel, return
        if isempty(answers)
            return;
        end
        
        % convert input texts into numerical values
        xmin = str2double(answers{1});
        xmax = str2double(answers{2});
        if isnan(xmin) || isnan(xmax)
            return;
        end
        ymin = str2double(answers{3});
        ymax = str2double(answers{4});
        if isnan(ymin) || isnan(ymax)
            return;
        end
        
        zmin = str2double(answers{5});
        zmax = str2double(answers{6});
        if isnan(zmin) || isnan(zmax)
            return;
        end
        
        disp(sprintf('New bounds: [ %f,%f   %f,%f  %f,%f]', ...
            xmin, xmax, ymin, ymax, zmin, zmax)); %#ok<DSPS>

        % setup new bounds
        scene.xAxis.limits = [xmin xmax];
        scene.yAxis.limits = [ymin ymax];
        scene.zAxis.limits = [zmin zmax];
        
        % refresh display
        updateDisplay(viewer);
    end
    
end % end methods

end % end classdef

