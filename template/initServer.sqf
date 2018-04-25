["Initialize"] call BIS_fnc_dynamicGroups;

[] spawn ZO_fnc_showFPS;
TF_give_microdagr_to_soldier = false;

missionNameSpace setVariable ["mapButton03", 0, true];
missionNameSpace setVariable ["mapButton03_user", objNull, true];
missionNameSpace setVariable ["RESPAWN_POSITION", getMarkerPos "respawn", true];