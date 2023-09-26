/*
    @file_name: fn_drawEditorObjects.sqf
    @file_author: Dyzalonius
*/

////////////////////////////////////////////////
//               SUB-FUNCTIONS                //
////////////////////////////////////////////////

fn_drawObject = {
    _object = _this select 0;
    _darkObjectWhitelist = _this select 1;
    boundingBoxReal _object params["_mins", "_maxs"];
    _mins params[ "_minX", "_minY" ];
    _maxs params[ "_maxX", "_maxY" ];

    _marker1 = createMarker [_object call BIS_fnc_netId, getPosATL _object];
    _marker1 setMarkerShape "RECTANGLE";
    _marker1 setMarkerSize [_maxX, _maxY];
    _marker1 setMarkerDir getDir _object;
    _marker1 setMarkerBrush "SolidFull";
    _marker1 setMarkerColor "ColorGrey";

    if ((typeOf _x) in _darkObjectWhitelist) then {
        _marker1 setMarkerColor "ColorBlack";
        _marker2 = createMarker [format["%1-1", _object call BIS_fnc_netId], getPosATL _object];
        _marker2 setMarkerShape "RECTANGLE";
        _marker2 setMarkerSize [_maxX, _maxY];
        _marker2 setMarkerDir getDir _object;
        _marker2 setMarkerBrush "Solid";
        _marker2 setMarkerColor "ColorGrey";
    };
};

fn_findObjects = {
    _triggers = _this select 0;
    _objectBlacklist = _this select 1;
    _missionObjects = _this select 2;
    _objects = [];

    {
        // Check if type is in blacklist
        if (!((typeOf _x) in _objectBlacklist) && ((_x call BIS_fnc_objectType) select 1) == "House") then {
            if ([_triggers, _x] call fn_inTriggers) then {
                _objects pushback _x;
            };
        };
    } foreach _missionObjects;

    _objects;
};

fn_findTriggers = {
    _missionObjects = _this;
    _triggers = [];

    {
        if (((typeOf _x) in ["EmptyDetector", "EmptyDetectorAreaR50", "EmptyDetectorAreaR250", "EmptyDetectorArea10x10"]) && (((vehicleVarName _x) splitString "_") select 0) == "drawEditorObjects") then {
            _triggers pushback _x;
        };
    } foreach _missionObjects;

    _triggers;
};

fn_getObjectBlackList = {
    _objectBlacklist = [
        "CamoNet_BLUFOR_big_Curator_F",
        "CamoNet_BLUFOR_big_F",
        "CamoNet_BLUFOR_Curator_F",
        "CamoNet_BLUFOR_F",
        "CamoNet_BLUFOR_open_Curator_F",
        "CamoNet_BLUFOR_open_F",
        "CamoNet_INDP_big_Curator_F",
        "CamoNet_INDP_big_F",
        "CamoNet_INDP_Curator_F",
        "CamoNet_INDP_F",
        "CamoNet_INDP_open_Curator_F",
        "CamoNet_INDP_open_F",
        "CamoNet_OPFOR_big_Curator_F",
        "CamoNet_OPFOR_big_F",
        "CamoNet_OPFOR_Curator_F",
        "CamoNet_OPFOR_F",
        "CamoNet_OPFOR_open_Curator_F",
        "CamoNet_OPFOR_open_F"
    ];

    _objectBlacklist;
};

fn_getDarkObjectWhiteList = {
    _darkObjectWhitelist = [
        "Land_HBarrier_1_F",
        "Land_HBarrier_3_F",
        "Land_HBarrier_5_F",
        "Land_HBarrier_Big_F",
        "Land_HBarrierBig_F",
        "Land_HBarrierTower_F",
        "Land_HBarrierWall4_F",
        "Land_HBarrierWall6_F",
        "Land_HBarrierWall_corner_F",
        "Land_HBarrierWall_corridor_F",
        "Land_Razorwire_F",
        "Land_BagBunker_Large_F",
        "Land_BagBunker_Small_F",
        "Land_BagBunker_Tower_F",
        "Land_BagFence_Corner_F",
        "Land_BagFence_End_F",
        "Land_BagFence_Long_F",
        "Land_BagFence_Round_F",
        "Land_BagFence_Short_F",
        "Land_CncBarrier_F",
        "Land_CncBarrier_stripes_F",
        "Land_CncBarrierMedium4_F",
        "Land_CncBarrierMedium_F",
        "Land_CncShelter_F",
        "Land_CncWall1_F",
        "Land_CncWall4_F",
        "Land_Concrete_SmallWall_4m_F",
        "Land_Concrete_SmallWall_8m_F",
        "Land_Mil_ConcreteWall_F",
        "Land_Mil_WallBig_4m_F",
        "Land_Mil_WallBig_Corner_F",
        "Land_Mil_WallBig_Gate_F",
        "Land_Mil_WiredFence_F",
        "Land_Mil_WiredFence_Gate_F",
        "Land_Mil_WiredFenceD_F"
    ];

    _darkObjectWhitelist;
};

fn_inTriggers = {
    _triggers = _this select 0;
    _object = _this select 1;
    _inTriggers = false;

    {
        if (_object inArea _x) then {
            _inTriggers = true;
        };
    } foreach _triggers;

    _inTriggers;
};

////////////////////////////////////////////////
//               FUNCTION LOOP                //
////////////////////////////////////////////////

_objectBlacklist = [] call fn_getObjectBlackList;
_darkObjectWhitelist = [] call fn_getDarkObjectWhiteList;
_missionObjects = allMissionObjects "";

// Find triggers
_triggers = _missionObjects call fn_findTriggers;

// Find objects
_objects = [_triggers, _objectBlacklist, _missionObjects] call fn_findObjects;

// Find existing map markers
_markers = [];
{
    _markers pushback [_x, (getMarkerPos _x), (markerDir _x), (getMarkerSize _x), (markerText _x), (markerShape _x), (markerBrush _x), (markerType _x), (markerColor _x), (markerAlpha _x)];
    // variable name, position, direction, size, text, shape, brush, type, color, alpha
} foreach allMapMarkers;

// Draw objects
{
    [_x, _darkObjectWhitelist] call fn_drawObject;
} foreach _objects;

sleep 10;

// Redraw existing map markers
{
    deleteMarker (_x select 0);
    _marker = createMarker [(_x select 0), (_x select 1)];
    _marker setMarkerDir (_x select 2);
    _marker setMarkerSize (_x select 3);
    _marker setMarkerText (_x select 4);
    _marker setMarkerShape (_x select 5);
    _marker setMarkerBrush (_x select 6);
    _marker setMarkerType (_x select 7);
    _marker setMarkerColor (_x select 8);
    _marker setMarkerAlpha (_x select 9);
} foreach _markers;
