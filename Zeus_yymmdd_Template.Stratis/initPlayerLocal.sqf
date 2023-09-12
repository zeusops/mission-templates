["InitializePlayer", [player]] call zeusops_fnc_dynamicGroups;
[player] join grpNull;
player setVariable ["ACE_GForceCoef", 0];
missionNameSpace setVariable ["playerGear", [], false];

waitUntil { missionNameSpace getVariable ["initDone", false] };

player setPos (missionNameSpace getVariable "RESPAWN_POSITION");
[0] spawn ZO_fnc_unitTracker;
[0] spawn ZO_fnc_gearHandle;
[] spawn ZO_fnc_mapFunctionalities;
[-1] spawn ZO_fnc_fortificationBox;
[] spawn ZO_fnc_sthudPatch;
