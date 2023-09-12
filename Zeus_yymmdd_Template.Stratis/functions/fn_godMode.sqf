/*
	@file_name: fn_godMode.sqf
	@file_author: Dyzalonius
*/

////////////////////////////////////////////////
//               SUB-FUNCTIONS                //
////////////////////////////////////////////////

fn_enableGodMode = {
    player allowDamage false;
};

fn_disableGodMode = {
    player allowDamage true;
};

////////////////////////////////////////////////
//               FUNCTION LOOP                //
////////////////////////////////////////////////

_request = _this select 0;

switch (_request) do {
    case "enable": {
        _player = _this select 1;

        // Execute bind if local, otherwise remote exec for player
        if (_player == player) then {
            [] call fn_enableGodMode;
        } else {
            ["enable"] remoteExec ["ZO_fnc_godMode", [_player]];
        };
    };

    case "disable": {
        _player = _this select 1;

        // Execute bind if local, otherwise remote exec for player
        if (_player == player) then {
            [] call fn_disableGodMode;
        } else {
            ["enable"] remoteExec ["ZO_fnc_godMode", [_player]];
        };
    };
};
