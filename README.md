# How to use these files

Clone the repository or [download the ZIP file](https://github.com/zeusops/mission-templates/archive/master.zip). Copy template files from `Zeus_yymmdd_Template.Stratis` to the mission folder.

See the [Zeus Guide](https://docs.google.com/document/d/1PFK__UcgmAJ1P3xBnJxeW2ow7u8bgEfM8lkpHJrLYDU/edit#heading=h.nleh2xb28ay8) for further information about the templates.

## Authors

The templates have been created by [Dyzalonius](https://github.com/Dyzalonius) and [Gehock](https://github.com/Gehock) for [Zeus Operations](https://www.zeusops.com).

## Useful scripts

### The gear box (fn_gearBox.sqf)
Execute locally in debug console while in game. Spawns a box at player (or zeus camera) location.

    // Full arsenal:
    [0, player] spawn ZO_fnc_gearBox;

    // Rearm box:
    [1, player] spawn ZO_fnc_gearBox;

Put down an ammo box in the editor, add following to the init field of the box.

    // Full arsenal in editor:
    [2, this] spawn ZO_fnc_gearBox;

See `fn_unitTracker.sqf` for information on how to customise the unit tracker. The default settings are suitable for most of the missions.
