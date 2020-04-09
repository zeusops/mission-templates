STHud_IsMedic = {
    params ["_unit"];
    (_unit getVariable ["Ace_medical_medicClass", 0]) >= 1;
};

STHud_IsEngineer = {
    params ["_unit"];
    _isEngineer = _unit getVariable ["Ace_IsEngineer", 0];
    if (_isEngineer isEqualType false) then {
        _isEngineer = [0, 1] select _isEngineer;
    };

    _isEngineer >= 1;
};

STHud_IsAT = {
    params ["_type"];
    _has_at = getText(configFile >> "CfgWeapons" >> _type >>
        "UIPicture") == "\a3\weapons_f\data\ui\icon_at_ca.paa";
    if (_has_at) exitWith {
        _has_rhs =
        if (getNumber(configfile >> "CfgWeapons" >> _type >>
                "rhs_disposable") == 1) exitWith {
            false;
        };
        if (!isNil {
                (configfile >> "CfgWeapons" >> _type >> "UK3CB_used_launcher")
                call BIS_fnc_getCfgData;}) exitWith {
            false;
        };
        if (!isNil {(configfile >> "CfgWeapons" >> _type >> "EventHandlers"
                >> "fired") call BIS_fnc_getCfgData;}) exitWith {
            false;
        };
        // Has a reloadable AT launcher
        true;
    };
    // No AT launcher
    false;
};

STHud_Icon_Real = STHud_Icon;

STHud_Icon = {
    params [
        "_unit",
        ["_disableVehicleIcons", true]
    ];

    _icon = [_unit, _disableVehicleIcons] call STHud_Icon_Real;
    if (_icon == STHud_BGIcon) exitWith {
        if (_unit call STHud_IsEngineer) exitWith {
            "\A3\ui_f\data\map\vehicleicons\iconManEngineer_ca.paa";
        };
        _icon;
    };
    _icon;
};
