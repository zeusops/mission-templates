////////////////////////////////////////////////
//             EDITABLE VARIABLES             //
////////////////////////////////////////////////

// Make sure the ammo fits the weapon.
// Give best allowed vest, backpack, and helmet that players are allowed (e.g. armored vest instead of chest rig).
// Give tracer/mixed ammo if possible.
_uniform = "rhs_uniform_cu_ocp";
_vest = "rhsusf_spcs_ocp_rifleman_alt";
_backpack = "B_Kitbag_tan";
_headgear = "rhsusf_ach_helmet_ocp";
_radio = "TFAR_anprc152";
_backpackLeader = "TFAR_rt1523g_big_rhs";
_nightvision = "rhsusf_ANPVS_14";
_weapon1Use = "rhs_weap_m136";
_weaponMain = ["rhs_weap_m4a1_carryhandle", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", ["rhsusf_acc_ACOG", "rhsusf_acc_anpeq15_bk"]];
_weaponAR = ["rhs_weap_m249_pip_L", "rhsusf_200Rnd_556x45_mixed_box", ["rhsusf_acc_ELCAN", "rhsusf_acc_anpeq15a"]];
_weaponGrenadier = ["rhs_weap_m4a1_carryhandle_m203", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", ["rhsusf_acc_ACOG", "rhsusf_acc_anpeq15a"], "rhs_mag_M441_HE"];
_weaponMarksman = ["rhs_weap_m14ebrri", "rhsusf_20Rnd_762x51_m62_Mag", ["optic_AMS", "rhsusf_acc_anpeq15_bk"]];
_weaponLauncher = ["launch_MRAWS_olive_rail_F", "MRAWS_HEAT_F", [""]];

////////////////////////////////////////////////
//        DO NOT EDIT BELOW THIS LINE         //
////////////////////////////////////////////////

missionNameSpace setVariable ["gearUniform", _uniform, true];
missionNameSpace setVariable ["gearVest", _vest, true];
missionNameSpace setVariable ["gearBackpack", _backpack, true];
missionNameSpace setVariable ["gearHeadgear", _headgear, true];
missionNameSpace setVariable ["gearRadio", _radio, true];
missionNameSpace setVariable ["gearBackpackLeader", _backpackLeader, true];
missionNameSpace setVariable ["gearNightvision", _nightvision, true];
missionNameSpace setVariable ["gearWeapon1Use", _weapon1Use, true];
missionNameSpace setVariable ["gearWeaponMain", _weaponMain, true];
missionNameSpace setVariable ["gearWeaponAR", _weaponAR, true];
missionNameSpace setVariable ["gearWeaponGrenadier", _weaponGrenadier, true];
missionNameSpace setVariable ["gearWeaponMarksman", _weaponMarksman, true];
missionNameSpace setVariable ["gearWeaponLauncher", _weaponLauncher, true];
