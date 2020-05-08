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
missionNameSpace setVariable ["respawnMessageGroups", ["Z1","Z2","Z3","Z4","Z5","Z6","Z7","Z8","Z9","Z10","V1","V2","V3","V4","V5","V6","V7","V8","V9","V10"], true];
missionNameSpace setVariable ["unitTrackerInfantry", ["A","ASL","A1","A2","B","BSL","B1","B2","C","CSL","C1","C2","D","DSL","D1","D2","E","ESL","E1","E2","F","FSL","F1","F2","G","GSL","G1","G2","H","HSL","H1","H2"], true];
missionNameSpace setVariable ["unitTrackerHQ", ["HQCO","HQ1PLT","HQ2PLT"], true];
missionNameSpace setVariable ["unitTrackerAir", ["Z1","Z2","Z3","Z4","Z5","Z6","Z7","Z8","Z9","Z10"], true];
missionNameSpace setVariable ["unitTrackerArmor", ["Y1","Y2","Y3","Y4","Y5","Y6","Y7","Y8","Y9","Y10"], true];
missionNameSpace setVariable ["unitTrackerPlane", ["W1","W2","W3","W4","W5","W6","W7","W8","W9","W10"], true];
missionNameSpace setVariable ["unitTrackerMotorized", ["V1","V2","V3","V4","V5","V6","V7","V8","V9","V10"], true];
missionNameSpace setVariable ["unitTrackerNaval", ["U1","U2","U3","U4","U5","U6","U7","U8","U9","U10"], true];
[] spawn ZO_fnc_drawEditorObjects;
[] spawn ZO_fnc_coverMap;
[] spawn ZO_fnc_showFPS;
[] spawn ZO_fnc_respawnHandle;
missionNameSpace setVariable ["initDone", true, true];
