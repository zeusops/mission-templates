_position = missionNameSpace getVariable "RESPAWN_POSITION";
player setPos _position;

if ((missionNameSpace getVariable "playerGear") isEqualTo []) then {
	[0] spawn ZO_fnc_gearHandle;
} else {
	[3] call ZO_fnc_gearHandle;
};