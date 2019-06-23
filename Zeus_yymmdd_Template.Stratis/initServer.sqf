////////////////////////////////////////////////
//             EDITABLE VARIABLES             //
////////////////////////////////////////////////

// GEAR
// Make sure the ammo fits the weapon.
// Give best allowed vest, backpack, and helmet that players are allowed (e.g. armored vest instead of chest rig).
// Give tracer/mixed ammo if possible.
_uniform = "rhs_uniform_FROG01_d";
_vest = "rhsusf_spc_patchless_radio";
_backpack = "rhsusf_assault_eagleaiii_coy";
_headgear = "rhsusf_lwh_helmet_marpatd";
_radio = "tf_anprc152";
_backpackLeader = "tf_rt1523g_big_bwmod_tropen";
_weaponMain = ["rhs_weap_m16a4_carryhandle", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", "rhsusf_acc_ACOG"]; 
_weaponAR = ["rhs_weap_m249_pip_L", "rhs_200rnd_556x45_M_SAW", "rhsusf_acc_ACOG"];
_weaponLauncher = ["launch_MRAWS_olive_rail_F", "MRAWS_HEAT_F", ""];

// UNITTRACKER
// All colors: https://community.bistudio.com/wiki/CfgMarkerColors_Arma_3
_unitColor = "ColorBlufor";

// COVERMAP
// [center, size]
[[4096, 4096], [4096, 4096]] spawn ZO_fnc_coverMap;

////////////////////////////////////////////////
//        DO NOT EDIT BELOW THIS LINE         //
////////////////////////////////////////////////

["Initialize"] call BIS_fnc_dynamicGroups;
TF_give_microdagr_to_soldier = false;

// GEAR
missionNameSpace setVariable ["gearUniform", _uniform, true];
missionNameSpace setVariable ["gearVest", _vest, true];
missionNameSpace setVariable ["gearBackpack", _backpack, true];
missionNameSpace setVariable ["gearHeadger", _headgear, true];
missionNameSpace setVariable ["gearRadio", _radio, true];
missionNameSpace setVariable ["gearBackpackLeader", _backpackLeader, true];
missionNameSpace setVariable ["gearWeaponMain", _weaponMain, true];
missionNameSpace setVariable ["gearWeaponAR", _weaponAR, true];
missionNameSpace setVariable ["gearWeaponLauncher", _weaponLauncher, true];

// UNITTRACKER
missionNameSpace setVariable ["unitColor", _unitColor, true];

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