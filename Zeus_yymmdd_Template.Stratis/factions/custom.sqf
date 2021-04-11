////////////////////////////////////////////////
//             EDITABLE VARIABLES             //
////////////////////////////////////////////////

// Make sure the ammo fits the weapon.
// Give best allowed vest, backpack, and helmet that players are allowed (e.g. armored vest instead of chest rig).
// Give tracer/mixed ammo if possible.
_uniform = "U_CBRN_B_blue";
_vest = "V_CBRN_C";
_backpack = "UK3CB_CPD_B_B_ASS_BLU";
_headgear = "rhs_altyn";
_radio = "TFAR_anprc152";
_backpackLeader = "unv_black_big_rt1523g";
_nightvision = "rhsusf_ANPVS_14";
_weapon1Use = "hlc_rifle_ak12";
_weaponMain = ["hlc_rifle_ak12", "rhs_30Rnd_545x39_AK_green"];
_weaponAR = ["hlc_rifle_RPK12", "UK3CB_RPK74_60rnd_545x39_RT"];
_weaponGrenadier = ["hlc_rifle_ak12GL", "rhs_30Rnd_545x39_AK_green", [], "hlc_VOG25_AK" ];
_weaponMarksman = ["rhs_weap_svdp", "rhs_10Rnd_762x54mmR_7N14", ["rhs_acc_pso1m21"]];
// _weaponLauncher = ["launch_MRAWS_olive_rail_F", "MRAWS_HEAT_F", [""]];

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
// missionNameSpace setVariable ["gearWeaponLauncher", _weaponLauncher, true];
