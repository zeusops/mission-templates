////////////////////////////////////////////////
//             EDITABLE VARIABLES             //
////////////////////////////////////////////////

// Make sure the ammo fits the weapon.
// Give best allowed vest, backpack, and helmet that players are allowed (e.g. armored vest instead of chest rig).
// Give tracer/mixed ammo if possible.
_uniform = "rhsgref_uniform_3color_desert";
_vest = "UK3CB_ANP_B_V_GA_HEAVY_TAN";
_backpack = "B_Kitbag_cbr";
_headgear = "rhsgref_helmet_pasgt_3color_desert";
_radio = "TFAR_anprc152";
_backpackLeader = "TFAR_rt1523g_sage";
_nightvision = "";
_weapon1Use = "";
_weaponMain = ["rhs_weap_ak104", "rhs_30Rnd_762x39mm_polymer_tracer", ["rhs_acc_pkas", ""]];
_weaponAR = ["hlc_lmg_M60E4", "hlc_100Rnd_762x51_M_M60E4", ["optic_aco", ""]];
_weaponGrenadier = ["rhs_weap_ak103_gp25", "rhs_30Rnd_762x39mm_polymer_tracer", ["rhs_acc_pkas", ""], "hlc_VOG25_AK"];
_weaponMarksman = ["rhs_weap_m40a5_d", "rhsusf_10Rnd_762x51_m62_Mag", ["optic_dms", ""]];
_weaponLauncher = ["rhs_weap_rpg7", "rhs_rpg7_PG7VL_mag", [""]];

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
