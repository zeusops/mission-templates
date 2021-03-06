// Reset oxygen
fn_fill_tank = {
	[] spawn {
		_backpack = backpackContainer player;
		_backpack setVariable ["cbrn_oxygen", cbrn_maxOxygenTime];
		_backpack setVariable ["cbrn_5min_warning", false];
		_backpack setVariable ["cbrn_1min_warning", false];
		if (player getVariable ["cbrn_oxygen", false]) then {
			player setVariable ["cbrn_oxygen", false];
			sleep 1;
			[player] call cbrn_fnc_startOxygen;
		};
	};
};


fn_add_fill_action = {
	_this setVariable ["refills", missionNameSpace getVariable ["tankRefillCount", 1], true];
	if (!isServer) exitWith {};
	[
		/* 0 object */                       _this,
		/* 1 action title */
		{
			switch (_this getVariable 'refills') do {
				case -1: {
					"Refill tank";
				};

				case 0: {
					(format ["Refill tank</t><t color='#FF0000' align='left'> (%1 uses)", (_this getVariable 'refills')]);
				};

				case 1: {
					(format ["Refill tank (%1 use)", (_this getVariable 'refills')]);
				};

				default {
					(format ["Refill tank (%1 uses)", (_this getVariable 'refills')]);
				};
			};
		},
		/* 2 idle icon */                       "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloadDevice_ca.paa",
		/* 3 progress icon */                   "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloadDevice_ca.paa",
		/* 4 condition to show */               "(_this distance _target < 3)",
		/* 5 condition for action */            "(_this distance _target < 3) && (_target getVariable ""refills"") != 0",
		/* 6 code executed on start */          {},
		/* 7 code executed per tick */          {},
		/* 8 code executed on completion */
		{
			_refills = (_target getVariable "refills");
			if (_refills != 0) then {
				if (_refills > 0) then {
					_target setVariable ["refills", _refills - 1, false];
				};
				cutText ["Tank refilled", "PLAIN", 0.2];

				playSound "sound1";
				[] call fn_fill_tank;
			};
		},
		/* 9 code executed on interruption */
		{
			if ((_target getVariable "refills") == 0) then {
				cutText ["No refills left!", "PLAIN", 0.2];
			};
		},
		/* 10 arguments */                      [],
		/* 11 action duration */                1,
		/* 12 priority */                       8,
		/* 13 remove on completion */           false,
		/* 14 show unconscious */               false
	] remoteExec ["ZO_fnc_holdActionAdd",[0,-2] select isDedicated,true];
};
