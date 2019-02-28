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
    Name;

    % the scene displayed by this document
    Scene;
    
    % a flag of modification
    Modified = false;

    % flag for display of background image
    DisplayBackgroundImage = true;
    
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
        
        this.Scene = var1;
        this.Name = '[No Name]';
        
    end

end % end constructors


end % end classdef

