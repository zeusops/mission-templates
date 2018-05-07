["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
[player] join grpNull;
player setVariable ["ACE_GForceCoef", 0];
missionNameSpace setVariable ["playerGear", [], false];

_position = missionNameSpace getVariable "RESPAWN_POSITION";
player setPos _position;

[] spawn ZO_fnc_dynamicGroupsMarkers;
[0] spawn ZO_fnc_gearHandle;
[] spawn ZO_fnc_respawnHandleLocal;
[] spawn ZO_fnc_mapButtons;

if (!isDedicated && !hasInterface && isMultiplayer) then {
	[] spawn ZO_fnc_showFPS;
};