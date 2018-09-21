function testSuite = test_Scene(varargin)
%TEST_SCENE  Test case for the file Scene
%
%   Test case for the file Scene

%   Example
%   test_Scene
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2018-09-20,    using Matlab 8.6.0.267246 (R2015b)
% Copyright 2018 INRA - Cepia Software Platform.

testSuite = buildFunctionHandleTestSuite(localfunctions);

function test_Creation %#ok<*DEFNU>
% Test call of function without argument
scene = sv.app.Scene();
assertTrue(isa(scene, 'sv.app.Scene'));

function test_read

scene = sv.app.Scene.read('kandinsky.scene');
assertTrue(isa(scene, 'sv.app.Scene'));
assertEqual(3, length(scene.shapes));