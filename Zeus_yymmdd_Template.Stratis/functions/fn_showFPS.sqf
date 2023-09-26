/*
    @file_name: fn_showFPS.sqf
    @file_author: Dyzalonius
*/

_mk = createMarker ["fpsmarker", [-500, -500]];
_mk setMarkerType "mil_dot";
_mk setMarkerSize [0,0];

while {true} do {
    _mk setMarkerText format ["        SERVER PERFORMANCE: %1 fps", (round (diag_fps * 100.0)) / 100.0];
    sleep 10;
};
