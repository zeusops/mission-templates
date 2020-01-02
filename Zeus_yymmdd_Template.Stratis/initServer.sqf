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
_radio = "TFAR_anprc152";
_backpackLeader = "unv_MARPAT_D_big_rt1523g";
_weaponMain = ["rhs_weap_m16a4_carryhandle", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", "rhsusf_acc_ACOG"];
_weaponAR = ["rhs_weap_m249_pip_L", "rhsusf_200Rnd_556x45_mixed_box", "rhsusf_acc_ACOG"];
_weaponGrenadier = ["rhs_weap_m16a4_carryhandle_m203", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", "rhsusf_acc_ACOG", "rhs_mag_M441_HE"];
_weaponLauncher = ["launch_MRAWS_olive_rail_F", "MRAWS_HEAT_F", ""];
_weapon1Use = "rhs_weap_m136";

// UNITTRACKER
// All colors: https://community.bistudio.com/wiki/CfgMarkerColors_Arma_3
_unitColor = "ColorBlufor";

////////////////////////////////////////////////
//        DO NOT EDIT BELOW THIS LINE         //
////////////////////////////////////////////////

["Initialize"] call BIS_fnc_dynamicGroups;
TF_give_microdagr_to_soldier = false;

// GEAR
missionNameSpace setVariable ["gearUniform", _uniform, true];
missionNameSpace setVariable ["gearVest", _vest, true];
missionNameSpace setVariable ["gearBackpack", _backpack, true];
missionNameSpace setVariable ["gearHeadgear", _headgear, true];
missionNameSpace setVariable ["gearRadio", _radio, true];
missionNameSpace setVariable ["gearBackpackLeader", _backpackLeader, true];
missionNameSpace setVariable ["gearWeaponMain", _weaponMain, true];
missionNameSpace setVariable ["gearWeaponAR", _weaponAR, true];
missionNameSpace setVariable ["gearWeaponGrenadier", _weaponGrenadier, true];
missionNameSpace setVariable ["gearWeaponLauncher", _weaponLauncher, true];
missionNameSpace setVariable ["gearWeapon1Use", _weapon1Use, true];

// UNITTRACKER
missionNameSpace setVariable ["unitColor", _unitColor, true];
missionNameSpace setVariable ["unitTrackerInterval", 0.1, true];

// RESPAWN
missionNameSpace setVariable ["RESPAWN_POSITION", getMarkerPos "respawn", true];
missionNameSpace setVariable ["respawnAllow", true, true];
missionNameSpace setvariable ["respawnTime", 900, true];
missionNameSpace setvariable ["respawnTimeInfinite", 100000, true];
missionNameSpace setVariable ["respawnWave", false, true];
missionNameSpace setvariable ["respawnWaveTime", 480, true];
missionNameSpace setVariable ["respawnNextWaveTime", 0, true];

[] spawn ZO_fnc_coverMap;
[] spawn ZO_fnc_showFPS;
[] spawn ZO_fnc_respawnHandle;
