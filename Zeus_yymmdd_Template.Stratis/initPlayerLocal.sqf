["InitializePlayer", [player]] call zeusops_fnc_dynamicGroups;
[player] join grpNull;
player setVariable ["ACE_GForceCoef", 0];
missionNameSpace setVariable ["playerGear", [], false];

waitUntil { missionNameSpace getVariable ["initDone", false] };
setPlayerRespawnTime (missionNameSpace getVariable "respawnTime");

player setPosASL (missionNameSpace getVariable "RESPAWN_POSITION");
[0] spawn ZO_fnc_unitTracker;
[0] spawn ZO_fnc_gearHandle;
[] spawn ZO_fnc_respawnHandleLocal;
[] spawn ZO_fnc_mapFunctionalities;
[-1] spawn ZO_fnc_fortificationBox;


//Angel - 2023-08-10: Add TTT INIT from old mission
//"INIT" spawn ZO_fnc_TTT;
