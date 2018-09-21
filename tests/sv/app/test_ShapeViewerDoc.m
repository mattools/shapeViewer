function testSuite = test_ShapeViewerDoc(varargin)
%TEST_SHAPEVIEWERDOC  Test case for the file ShapeViewerDoc
%
%   Test case for the file ShapeViewerDoc

%   Example
%   test_ShapeViewerDoc
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2018-09-21,    using Matlab 8.6.0.267246 (R2015b)
% Copyright 2018 INRA - Cepia Software Platform.

testSuite = buildFunctionHandleTestSuite(localfunctions);

function test_Constructor %#ok<*DEFNU>
% Test call of function without argument
scene = Scene();
doc = sv.app.ShapeViewerDoc(scene);

assertTrue(isa(doc, 'sv.app.ShapeViewerDoc'));


