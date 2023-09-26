/*
    @file_name: fn_coverMap.sqf
    @file_author: Dyzalonius
*/

////////////////////////////////////////////////
//               SUB-FUNCTIONS                //
////////////////////////////////////////////////

fn_spawn = {
    _center = (getMarkerPos "coverMapAreaCenter");
    _size = (getMarkerSize "coverMapAreaCenter");
    _bignumber = 50000;

    // edit area marker
    "coverMapAreaCenter" setMarkerShape "RECTANGLE";
    "coverMapAreaCenter" setMarkerBrush "Border";

    // create leftright area markers
    _mk = createMarker ["coverMapAreaLeft", [(-_bignumber + (_center select 0) - (_size select 0)), (_center select 1)]];
    _mk setMarkerShape "RECTANGLE";
    _mk setMarkerBrush "SOLID";
    _mk setMarkerSize [_bignumber, _bignumber];
    _mk = createMarker ["coverMapAreaRight", [(_bignumber + (_center select 0) + (_size select 0)), (_center select 1)]];
    _mk setMarkerShape "RECTANGLE";
    _mk setMarkerBrush "SOLID";
    _mk setMarkerSize [_bignumber, _bignumber];

    // create topbot area markers
    _mk = createMarker ["coverMapAreaTop", [(_center select 0), (_bignumber + (_center select 1) + (_size select 1))]];
    _mk setMarkerShape "RECTANGLE";
    _mk setMarkerBrush "SOLID";
    _mk setMarkerSize [(_size select 0), _bignumber];
    _mk = createMarker ["coverMapAreaBot", [(_center select 0), (-_bignumber + (_center select 1) - (_size select 1))]];
    _mk setMarkerShape "RECTANGLE";
    _mk setMarkerBrush "SOLID";
    _mk setMarkerSize [(_size select 0), _bignumber];

    // create corner markers
    _mk = createMarker ["coverMapSquareTopLeft", [((_center select 0) - (_size select 0)), ((_center select 1) + (_size select 1))]];
    _mk setMarkerType "mil_box_noShadow";
    _mk = createMarker ["coverMapSquareTopRight", [((_center select 0) + (_size select 0)), ((_center select 1) + (_size select 1))]];
    _mk setMarkerType "mil_box_noShadow";
    _mk = createMarker ["coverMapSquareBotLeft", [((_center select 0) - (_size select 0)), ((_center select 1) - (_size select 1))]];
    _mk setMarkerType "mil_box_noShadow";
    _mk = createMarker ["coverMapSquareBotRight", [((_center select 0) + (_size select 0)), ((_center select 1) - (_size select 1))]];
    _mk setMarkerType "mil_box_noShadow";
};

fn_transform = {
    _center = (_this select 0);
    _size = (_this select 1);
    _bignumber = 50000;

    // transform leftright area markers
    "coverMapAreaLeft" setMarkerPos [(-_bignumber + (_center select 0) - (_size select 0)), (_center select 1)];
    "coverMapAreaRight" setMarkerPos [(_bignumber + (_center select 0) + (_size select 0)), (_center select 1)];

    // transform topbot area markers
    "coverMapAreaTop" setMarkerPos [(_center select 0), (_bignumber + (_center select 1) + (_size select 1))];
    "coverMapAreaTop" setMarkerSize [(_size select 0), _bignumber];
    "coverMapAreaBot" setMarkerPos [(_center select 0), (-_bignumber + (_center select 1) - (_size select 1))];
    "coverMapAreaBot" setMarkerSize [(_size select 0), _bignumber];

    // transform area marker
    "coverMapAreaCenter" setMarkerPos _center;
    "coverMapAreaCenter" setMarkerSize _size;

    // transform corner markers
    "coverMapSquareTopLeft" setMarkerPos [((_center select 0) - (_size select 0)), ((_center select 1) + (_size select 1))];
    "coverMapSquareTopRight" setMarkerPos [((_center select 0) + (_size select 0)), ((_center select 1) + (_size select 1))];
    "coverMapSquareBotLeft" setMarkerPos [((_center select 0) - (_size select 0)), ((_center select 1) - (_size select 1))];
    "coverMapSquareBotRight" setMarkerPos [((_center select 0) + (_size select 0)), ((_center select 1) - (_size select 1))];
};

////////////////////////////////////////////////
//               FUNCTION LOOP                //
////////////////////////////////////////////////

if ((getMarkerColor "coverMapAreaLeft") == "") then {
    // init
    [] call fn_spawn;
} else {
    // change location
    _this call fn_transform;
};
