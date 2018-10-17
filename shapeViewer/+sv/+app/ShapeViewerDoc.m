classdef ShapeViewerDoc < handle
% Encapsulates a scene and associated information
%
%   Class ShapeViewerDoc
%
%   Example
%   ShapeViewerDoc
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
    % the name of the doc, used as ID
    name;

    % the scene displayed by this document
    scene;
    
    % a flag of modification
    modified = false;

    % flag for display of background image
    displayBackgroundImage = true;
    
end % end properties


%% Constructor
methods
    function this = ShapeViewerDoc(varargin)
        % Constructor for ShapeViewerDoc class
        
        if isempty(varargin)
            error('Requires one input argument');
        end
        var1 = varargin{1};
        if ~isa(var1, 'Scene')
            error('Requires a Scene instance as input argument');
        end
        
        this.scene = var1;
        this.name = '[No Name]';
        
    end

end % end constructors


end % end classdef

