["Initialize"] call BIS_fnc_dynamicGroups;
TF_give_microdagr_to_soldier = false;

missionNameSpace setVariable ["mapButton05", 0, true];
missionNameSpace setVariable ["mapButton05_user", objNull, true];
missionNameSpace setVariable ["RESPAWN_POSITION", getMarkerPos "respawn", true];
missionNameSpace setVariable ["respawnAllow", true, true];
missionNameSpace setVariable ["respawnWave", false, true];
missionNameSpace setVariable ["respawnWaveForce", false, true];
missionNameSpace setvariable ["respawnWaveTime", 0, true];
missionNameSpace setvariable ["forceBodyBag", false, true];
missionNameSpace setVariable ["unitTrackerEffects", [0, 0, 1, 1, 0, 0, 0, 0], true];

[] spawn ZO_fnc_showFPS;
[] spawn ZO_fnc_respawnHandle;
