////////////////////////////////////////////////
//             EDITABLE VARIABLES             //
////////////////////////////////////////////////

// Make sure the ammo fits the weapon.
// Give best allowed vest, backpack, and helmet that players are allowed (e.g. armored vest instead of chest rig).
// Give tracer/mixed ammo if possible.
_uniform = "rhs_uniform_cu_ocp";
_vest = "";
_backpack = "";
_headgear = "";
_radio = "TFAR_anprc152";
_backpackLeader = "TFAR_rt1523g_big_rhs";
_nightvision = "rhsusf_ANPVS_14";
_weapon1Use = "";
_weaponMain = ["", "", ["", ""]];
_weaponAR = ["", "", ["", ""]];
_weaponGrenadier = ["", "", ["", ""], ""];
_weaponMarksman = ["", "", ["", ""]];
_weaponLauncher = ["", "", [""]];

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
