["InitializePlayer", [player]] call zeusops_fnc_dynamicGroups;
[player] join grpNull;
player setVariable ["ACE_GForceCoef", 0];
missionNameSpace setVariable ["playerGear", [], false];

waitUntil { _var = missionNameSpace getVariable "initDone"; (!isNil "_var") && {missionNameSpace getVariable "initDone"} };

player setPos (missionNameSpace getVariable "RESPAWN_POSITION");
[0] spawn ZO_fnc_unitTracker;
[0] spawn ZO_fnc_gearHandle;
[] spawn ZO_fnc_respawnHandleLocal;
[] spawn ZO_fnc_mapFunctionalities;
