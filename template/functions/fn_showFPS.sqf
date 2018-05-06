/*
	@file_name: fn_showFPS.sqf
	@file_edit: 06/05/2018
*/

_myfpsmarker = createMarker [ format ["fpsmarker%1", _sourcestr ], [ 500, -500 - (500 * _position) ] ];
_myfpsmarker setMarkerType "mil_dot";
_myfpsmarker setMarkerSize [0,0];

while {true} do {
	_myfpsmarker setMarkerText format [ "SERVER FPS: %1", ( round ( _myfps * 100.0 ) ) / 100.0];
	sleep 10;
};