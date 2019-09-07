# Zeus Operations Mission Template

Arma 3 mission templates for [Zeus Operations](https://www.zeusops.com).

The templates have been created by [Dyzalonius](https://github.com/Dyzalonius) and [Gehock](https://github.com/Gehock).

# How To Use The Template

1. Clone the repository or [download the ZIP file](https://github.com/zeusops/mission-templates/archive/master.zip).
2. Copy template files from `Zeus_yymmdd_Template.Stratis` folder to your mission folder.
3. Copy mission items from `Zeus_yymmdd_Template.Stratis` mission to your mission file.

See the [Zeus Guide](https://docs.google.com/document/d/1PFK__UcgmAJ1P3xBnJxeW2ow7u8bgEfM8lkpHJrLYDU/edit#heading=h.nleh2xb28ay8) for in-depth information about using the templates.

# Useful Code

##### Move cover map:
    [[_centerX, _centerY], [_radiusX, _radiusY]] call ZO_fnc_coverMap;
##### Change unit tracker color:
    missionNameSpace setVariable ["unitColor", "newUnitColor", true];
##### Change default gear:
    missionNameSpace setVariable ["gearUniform", "classnameOfUniform", true];
    missionNameSpace setVariable ["gearVest", "classnameOfVest", true];
    missionNameSpace setVariable ["gearBackpack", "classnameOfBackpack", true];
    missionNameSpace setVariable ["gearHeadgear", "classnameOfHeadgear", true];
    missionNameSpace setVariable ["gearRadio", "classnameOfRadio", true];
    missionNameSpace setVariable ["gearBackpackLeader", "classnameOfBackpackLeader", true];
    missionNameSpace setVariable ["gearWeaponMain", ["classnameOfWeapon", "classnameOfAmmunition", "classnameOfScope"], true];
    missionNameSpace setVariable ["gearWeaponAR", ["classnameOfWeapon", "classnameOfAmmunition", "classnameOfScope"], true];
    missionNameSpace setVariable ["gearWeaponLauncher", ["classnameOfWeapon", "classnameOfAmmunition", "classnameOfScope"], true];
