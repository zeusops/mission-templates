////////////////////////////////////////////////
//             EDITABLE VARIABLES             //
////////////////////////////////////////////////

_faction = "ger_army_woodland"; // All factions are in the factions folder, use custom to edit your own.
_unitTrackerColor = "ColorBlufor"; // All colors: https://community.bistudio.com/wiki/CfgMarkerColors_Arma_3
_nightvision = false; // Set to true if you want players to spawn with nightvision

////////////////////////////////////////////////
//        DO NOT EDIT BELOW THIS LINE         //
////////////////////////////////////////////////

missionNameSpace setVariable ["initDone", false, true];
["Initialize"] call zeusops_fnc_dynamicGroups;
TF_give_microdagr_to_soldier = false;
_handle = execVM format["factions\%1.sqf", _faction];
missionNameSpace setVariable ["gearGiveNightvision", _nightvision, true];
missionNameSpace setVariable ["unitTrackerColor", _unitTrackerColor, true];
missionNameSpace setVariable ["unitTrackerInterval", 0.1, true];
missionNameSpace setVariable ["RESPAWN_POSITION", getMarkerPos "respawn", true];
missionNameSpace setVariable ["respawnAllow", true, true];
missionNameSpace setvariable ["respawnTime", 900, true];
missionNameSpace setvariable ["respawnTimeInfinite", 100000, true];
missionNameSpace setVariable ["respawnWave", false, true];
missionNameSpace setvariable ["respawnWaveTime", 480, true];
missionNameSpace setVariable ["respawnNextWaveTime", 0, true];
[] spawn ZO_fnc_drawEditorObjects;
[] spawn ZO_fnc_coverMap;
[] spawn ZO_fnc_showFPS;
[] spawn ZO_fnc_respawnHandle;
missionNameSpace setVariable ["initDone", true, true];
