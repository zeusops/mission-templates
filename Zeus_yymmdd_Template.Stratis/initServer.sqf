////////////////////////////////////////////////
//             EDITABLE VARIABLES             //
////////////////////////////////////////////////

_faction = "custom"; // All factions are in the factions folder, use custom to edit your own.
_unitTrackerColor = "ColorBlufor"; // All colors: https://community.bistudio.com/wiki/Arma_3:_CfgMarkerColors
_nightvision = false; // Set to true if you want players to spawn with nightvision
_fullArsenal = true;  // Set to false if you've manually set up a limited arsenal in the editor

//Angel 2023-08-10 Added TTT config
// TTT
_traitorRate = 0.3;
_timePreparing = 30;
_timeBeforeOvertime = 300;

// Angel 2023-09-26 Added Tag config
missionNameSpace setVariable ["Tag_isContagionMode", true, true];

////////////////////////////////////////////////
//        DO NOT EDIT BELOW THIS LINE         //
////////////////////////////////////////////////

["Initialize"] call zeusops_fnc_dynamicGroups;
TF_give_microdagr_to_soldier = false;
_handle = execVM format["factions\%1.sqf", _faction];
missionNameSpace setVariable ["gearGiveNightvision", _nightvision, true];
missionNameSpace setVariable ["unitTrackerColor", _unitTrackerColor, true];
missionNameSpace setVariable ["fullArsenal", _fullArsenal, true];
missionNameSpace setVariable ["unitTrackerInterval", 0.1, true];
missionNameSpace setVariable ["RESPAWN_POSITION", getPosASL respawn, true];
missionNameSpace setVariable ["respawnAllow", true, true];
missionNameSpace setvariable ["respawnTime", 900, true];
missionNameSpace setvariable ["respawnTimeInfinite", 100000, true];
missionNameSpace setVariable ["respawnWave", false, true];
missionNameSpace setvariable ["respawnWaveTime", 480, true];
missionNameSpace setVariable ["respawnNextWaveTime", 0, true];

_air = ["Z","Zulu","Z1","Z2","Z3","Z4","Z5","Z6","Z7","Z8","Z9","Z10","K","Kilo","K1","K2","K3","K4","K5","K6","K7","K8","K9","K10"];
_armor = ["Y","Yankee","Y1","Y2","Y3","Y4","Y5","Y6","Y7","Y8","Y9","Y10"];
_plane = ["W","Whiskey","W1","W2","W3","W4","W5","W6","W7","W8","W9","W10"];
_motorized = ["V","Victor","V1","V2","V3","V4","V5","V6","V7","V8","V9","V10"];
_maintenance = ["L","Lima","L1","L2","L3","L4","L5","L6","L7","L8","L9","L10"];
_naval = ["U","Uniform","U1","U2","U3","U4","U5","U6","U7","U8","U9","U10"];
_artillery = ["T","Thunder","T1","T2","T3","T4","T5","T6","T7","T8","T9","T10"];
missionNameSpace setVariable ["respawnMessageGroups", ["HQCO","HQ1PLT","HQ2PLT"] + _air + _motorized + _maintenance, true];

missionNameSpace setVariable ["unitTrackerInfantry", ["ALPHA","Alpha","A","ASL","A1","A2","BRAVO","Bravo","B","BSL","B1","B2","CHARLIE","Charlie","C","CSL","C1","C2","DELTA","Delta","D","DSL","D1","D2","ECHO","Echo","E","ESL","E1","E2","FOXTROT","Foxtrot","F","FSL","F1","F2","GOLF","Golf","G","GSL","G1","G2","HOTEL","Hotel","H","HSL","H1","H2"], true];
missionNameSpace setVariable ["unitTrackerHQ", ["HQCO","HQ1PLT","HQ2PLT"], true];
missionNameSpace setVariable ["unitTrackerAir", _air, true];
missionNameSpace setVariable ["unitTrackerArmor", _armor, true];
missionNameSpace setVariable ["unitTrackerPlane", _plane, true];
missionNameSpace setVariable ["unitTrackerMotorized", _motorized, true];
missionNameSpace setVariable ["unitTrackerNaval", _naval, true];
missionNameSpace setVariable ["unitTrackerMaintenance", _maintenance, true];
missionNameSpace setVariable ["unitTrackerUAV", ["X","X-RAY","X-Ray","X1","X2","X3","X4","X5","X6","X7","X8","X9","X10"], true];
missionNameSpace setVariable ["unitTrackerArtillery", _artillery, true];
missionNameSpace setVariable ["unitTrackerFOB", ["H","Hotel","H1","H2","H3","H4","H5","H6","H7","H8","H9","H10"], true];
missionNameSpace setVariable ["unitTrackerSupport", ["G","Golf","G1","G2","G3","G4","G5","G6","G7","G8","G9","G10"], true];
missionNameSpace setVariable ["unitTrackerRecon", ["RTO", "FAC", "JTAC"], true];

missionNameSpace setVariable ["autoBodybagTeams", _plane + _armor + _air + _motorized + _maintenance + _naval + _artillery, true];

//Angel 2023-08-10 Added TTT config
// TTT
missionNameSpace setVariable ["TTT_traitorRate", _traitorRate, true];
missionNameSpace setVariable ["TTT_timeLimitStarting", 5, true];
missionNameSpace setVariable ["TTT_timeLimitPreparing", _timePreparing, true];
missionNameSpace setVariable ["TTT_timeLimit", _timeBeforeOvertime, true];
missionNameSpace setVariable ["TTT_timeLimitEnding", 5, true];
missionNameSpace setVariable ["TTT_timeLeft", _timeBeforeOvertime, true];
missionNameSpace setVariable ["TTT_gameOngoing", false, true];
missionNameSpace setVariable ["TTT_overtime", false, true];

[] spawn ZO_fnc_coverMap;
[] spawn ZO_fnc_showFPS;
