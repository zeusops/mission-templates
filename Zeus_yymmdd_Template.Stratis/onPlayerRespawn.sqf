_position = missionNameSpace getVariable "RESPAWN_POSITION";
player setPosASL _position;

if ((missionNameSpace getVariable "playerGear") isEqualTo []) then {
    [0] spawn ZO_fnc_gearHandle;
} else {
    [3] call ZO_fnc_gearHandle;
};

//Angel - 2023-08-10 Add TTT spawn INIT
//"SPAWN" call ZO_fnc_TTT;
