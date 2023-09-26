/*
    @file_name: fn_bindVehicle.sqf
    @file_author: Dyzalonius
*/

////////////////////////////////////////////////
//               SUB-FUNCTIONS                //
////////////////////////////////////////////////

fn_giveBindActions = {
    [] call fn_addBindAction;
    [] call fn_addRespawnVehicleAction;
};

fn_addBindAction = {
    _actionID = [
        /* 0 object */                          player,
        /* 1 action title */
        {
            "BIND VEHICLE";
        },
        /* 2 idle icon */                       "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",
        /* 3 progress icon */                   "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",
        /* 4 condition to show */               "((player getVariable ['BoundVehicleClassname', '']) isEqualTo '')",
        /* 5 condition for action */            "((player getVariable ['BoundVehicleClassname', '']) isEqualTo '')",
        /* 6 code executed on start */          {},
        /* 7 code executed per tick */          {},
        /* 8 code executed on completion */
        {
            playSound "sound1";

            _vehicle = cursorObject;
            _vehicleClassname = typeOf cursorObject;

            if (_vehicleClassname isEqualTo "") then {
                hint "No vehicle found to bind to";
            } else {
                if (_vehicle getVariable ["isBound", false]) then {
                    hint "Vehicle is already bound to someone else";
                } else {
                    hint format ["Bound to vehicle\n%1", _vehicleClassname];
                    player setVariable ["BoundVehicle", _vehicle, false];
                    player setVariable ["BoundVehicleClassname", _vehicleClassname, false];
                    _vehicle setVariable ["isBound", true, true];
                }
            }
        },
        /* 9 code executed on interruption */   {},
        /* 10 arguments */                      [],
        /* 11 action duration */                0.5,
        /* 12 priority */                       10,
        /* 13 remove on completion */           false,
        /* 14 show unconscious */               false
    ] call ZO_fnc_holdActionAdd;

    // Add action id to players BoundVehicleActionIDs
    _actionID call fn_addBoundVehicleActionID;
};

fn_addRespawnVehicleAction = {
    // Add holdaction to reset vehicle at cursorPosition when on foot, when vehicle bound.
    _actionID = [
        /* 0 object */                          player,
        /* 1 action title */
        {
            "RESPAWN VEHICLE";
        },
        /* 2 idle icon */                       "files\holdAction_return.paa",
        /* 3 progress icon */                   "files\holdAction_return.paa",
        /* 4 condition to show */               "!((player getVariable ['BoundVehicleClassname', '']) isEqualTo '') && vehicle player == player",
        /* 5 condition for action */            "!((player getVariable ['BoundVehicleClassname', '']) isEqualTo '') && vehicle player == player",
        /* 6 code executed on start */          {},
        /* 7 code executed per tick */          {},
        /* 8 code executed on completion */
        {
            playSound "sound1";

            _wPos = screenToWorld [0.5,0.5];
            ["respawn", _wPos] call ZO_fnc_bindVehicle;
        },
        /* 9 code executed on interruption */   {},
        /* 10 arguments */                      [],
        /* 11 action duration */                0.5,
        /* 12 priority */                       10,
        /* 13 remove on completion */           false,
        /* 14 show unconscious */               false
    ] call ZO_fnc_holdActionAdd;

    // Add action id to players BoundVehicleActionIDs
    _actionID call fn_addBoundVehicleActionID;
};

fn_addBoundVehicleActionID = {
    _actionID = _this;
    _actionIDs = player getVariable ["BoundVehicleActionIDs", []];
    _actionIDs pushback _actionID;
    player setVariable ["BoundVehicleActionIDs", _actionIDs, false];
};

fn_unbind = {
    // Remove both bind holdactions.
    _actionIDs = player getVariable ["BoundVehicleActionIDs", []];
    {
        player removeAction _x;
    } foreach _actionIDs;

    player setVariable ["BoundVehicle", objNull, false];
    player setVariable ["BoundVehicleClassname", "", false];
};

////////////////////////////////////////////////
//               FUNCTION LOOP                //
////////////////////////////////////////////////

_request = _this select 0;

switch (_request) do {
    case "bind": {
        _player = _this select 1;

        // Execute bind if local, otherwise remote exec for player
        if (_player == player) then {
            [] call fn_unbind;
            [] call fn_giveBindActions;
        } else {
            ["bind"] remoteExec ["ZO_fnc_bindVehicle", [_player]];
        };
    };

    case "unbind": {
        _player = _this select 1;

        // Execute bind if local, otherwise remote exec for player
        if (_player == player) then {
            [] call fn_unbind;
        } else {
            ["unbind"] remoteExec ["ZO_fnc_bindVehicle", [_player]];
        };
    };

    case "respawn": {
        _position = _this select 1;
        _type = player getVariable ["BoundVehicleClassname", ""];

        // Delete old vehicle
        deleteVehicle (player getVariable ["BoundVehicle", objNull]);

        // Spawn and set new vehicle
        _newVehicle = createVehicle [_type, _position, [], 0, "CAN_COLLIDE"];
        _newVehicle setDir (getDir player);
        player setVariable ["BoundVehicle", _newVehicle, false];
    };
};
