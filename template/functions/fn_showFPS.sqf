/*
	@file_name: fn_showFPS.sqf
	@file_author: Dyzalonius
*/

_myfpsmarker = createMarker [ "fpsmarker", [ 500, -500 ] ];
_myfpsmarker setMarkerType "mil_dot";
_myfpsmarker setMarkerSize [0,0];

while {true} do {
	_myfpsmarker setMarkerText format [ "SERVER PERFORMANCE: %1 fps", ( round ( diag_fps * 100.0 ) ) / 100.0];
	sleep 10;
};