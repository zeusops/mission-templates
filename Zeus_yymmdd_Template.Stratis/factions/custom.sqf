////////////////////////////////////////////////
//             EDITABLE VARIABLES             //
////////////////////////////////////////////////

// Make sure the ammo fits the weapon.
// Give best allowed vest, backpack, and helmet that players are allowed (e.g. armored vest instead of chest rig).
// Give tracer/mixed ammo if possible.
// Each item needs to be within double quotes: ""
// If there are multiple items, meaning attachments and mags, all of the are inside [] as well
// Each attachment needs to be within quotes, and then after each attachment there needs to be a comma after the quotes
// You can have maximum of 4 attachments, but you can have zero as well. In that case just have [""] in where the attachment should be
// Example; ["weapon", "mag", [""]];
// Each line needs to end in a ;
// Basic info for a weapon line: ["weapon_name", "magazine_name", ["attachment1","attachment2","attachment3","attachment4"], "secondary_ammunition_if_any"];
_uniform = "rhsgref_uniform_3color_desert";
_vest = "UK3CB_CW_US_B_LATE_V_PASGT_Rif_Vest";
_backpack = "UK3CB_CHD_B_B_RIF_WDL";
_headgear = "rhsgref_helmet_pasgt_3color_desert_rhino";
_radio = "rhsusf_radio_anprc152";
_backpackLeader = "unv_green_big_rt1523g";
_nightvision = "rhsusf_ANPVS_15";
_weapon1Use = "";
_weaponMain = ["hlc_wp_m16a2", "rhs_mag_30Rnd_556x45_M196_Stanag_Tracer_Red", ["", ""]];
_weaponAR = ["rhs_weap_m249]", "rhsusf_200rnd_556x45_mixed_box", ["", ""]];
_weaponGrenadier = ["hlc_rifle_m203", "rhs_mag_30Rnd_556x45_M196_Stanag_Tracer_Red", ["", ""], "1Rnd_HE_Grenade_shell"];
_weaponMarksman = ["rhs_weap_m40a5", "rhsusf_10Rnd_762x51_m62_Mag", ["rhsusf_acc_leupoldmk4", ""]];
_weaponLauncher = ["rhs_weap_M136", "", [""]];
_goggles = "G_CBRN_A";

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
missionNameSpace setVariable ["gearGoggles", _goggles, true];
