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
