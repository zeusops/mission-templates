////////////////////////////////////////////////
//             EDITABLE VARIABLES             //
////////////////////////////////////////////////

// Make sure the ammo fits the weapon.
// Give best allowed vest, backpack, and helmet that players are allowed (e.g. armored vest instead of chest rig).
// Give tracer/mixed ammo if possible.
_uniform = "rhsgref_uniform_altis_lizard";
_vest = "rhsgref_otv_khaki";
_backpack = "B_Kitbag_rgr";
_headgear = "rhsgref_helmet_pasgt_altis_lizard";
_radio = "TFAR_anprc152";
_backpackLeader = "unv_M05_big_rt1523g";
_nightvision = "";
_weapon1Use = "";
_weaponMain = ["hlc_rifle_g3a3ris", "hlc_20rnd_762x51_b_G3", ["hlc_optic_hensoldtzo_lo_docter", ""]];
_weaponAR = ["rhs_weap_fnmag", "rhsusf_100Rnd_762x51", ["", ""]];
_weaponGrenadier = ["HLC_Rifle_g3ka4_GL", "hlc_20rnd_762x51_b_G3", ["hlc_optic_hensoldtzo_lo_docter", ""], "1Rnd_HE_Grenade_shell"];
_weaponMarksman = ["rhs_weap_m40a5_wd", "rhsusf_5Rnd_762x51_AICS_m118_special_Mag", ["optic_dms", ""]];
_weaponLauncher = ["rhs_weap_maaws", "rhs_mag_maaws_HEAT", [""]];

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
