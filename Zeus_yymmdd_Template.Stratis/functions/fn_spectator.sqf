/*
    @file_name: fn_spectator.sqf
    @file_author: Dyzalonius
*/

#include "\a3\ui_f\hpp\definedikcodes.inc"

////////////////////////////////////////////////
//               SUB-FUNCTIONS                //
////////////////////////////////////////////////

fn_addSpectatorAction = {
    _object = _this;

    // Add the hold-action to the object
    [
        /* 0 object */                          _object,
        /* 1 action title */
        {
            "SPECTATE";
        },
        /* 2 idle icon */                       "files\holdAction_spectator.paa",
        /* 3 progress icon */                   "files\holdAction_spectator.paa",
        /* 4 condition to show */               "(_this distance _target < 10)",
        /* 5 condition for action */            "(_this distance _target < 10)",
        /* 6 code executed on start */          {},
        /* 7 code executed per tick */          {},
        /* 8 code executed on completion */
        {
            playSound "sound1";

            ["open"] call ZO_fnc_spectator;
        },
        /* 9 code executed on interruption */   {},
        /* 10 arguments */                      [],
        /* 11 action duration */                0.5,
        /* 12 priority */                       10,
        /* 13 remove on completion */           false,
        /* 14 show unconscious */               false
    ] remoteExec ["ZO_fnc_holdActionAdd",[0,-2] select isDedicated,true];
};

fn_openSpectator = {
    ["Initialize", [player]] call BIS_fnc_EGSpectator;
    waituntil {!isnull (finddisplay 60492)};
    findDisplay 60492 displayAddEventHandler ["KeyDown", {
        params ["_ctrl","_button","_BtnShift","_BtnCtrl","_BtnAlt"];
        if (_button isEqualTo DIK_ESCAPE) then {
            ["close"] call ZO_fnc_spectator;
        };
    }];
};

fn_closeSpectator = {
    ["Terminate"] call BIS_fnc_EGSpectator;
};

////////////////////////////////////////////////
//               FUNCTION LOOP                //
////////////////////////////////////////////////

_request = _this select 0;

switch (_request) do {
    case "setup": {
        _object = _this select 1;
        _object call fn_addSpectatorAction;
    };

    case "open": {
        [] spawn fn_openSpectator;
    };

    case "close": {
        [] call fn_closeSpectator;
    };
}
