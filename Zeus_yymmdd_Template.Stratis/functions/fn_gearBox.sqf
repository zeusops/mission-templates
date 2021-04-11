/*
	@file_name: fn_gearBox.sqf
	@file_author: Dyzalonius
*/

////////////////////////////////////////////////
//               SUB-FUNCTIONS                //
////////////////////////////////////////////////

fn_addATRiflemanAction = {
	_object = _this;

	// Add the hold-action to the object
	[
		/* 0 object */                      	_object,
		/* 1 action title */                	"Load AT RIFLEMAN",
		/* 2 idle icon */                   	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloadDevice_ca.paa",
		/* 3 progress icon */               	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloadDevice_ca.paa",
		/* 4 condition to show */           	"(_this distance _target < 3)",
		/* 5 condition for action */        	"(_this distance _target < 3)",
		/* 6 code executed on start */      	{},
		/* 7 code executed per tick */      	{},
		/* 8 code executed on completion */
		{
			playSound "sound1";

			[1, "AT RIFLEMAN"] call ZO_fnc_gearHandle;
		},
		/* 9 code executed on interruption */   {},
		/* 10 arguments */                      [],
		/* 11 action duration */                1,
		/* 12 priority */                       8,
		/* 13 remove on completion */           false,
		/* 14 show unconscious */               false
	] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select isDedicated,true];
};

fn_addAutoriflemanAction = {
	_object = _this;

	// Add the hold-action to the object
	[
		/* 0 object */                     	 	_object,
		/* 1 action title */                	"Load AUTORIFLEMAN",
		/* 2 idle icon */                   	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloadDevice_ca.paa",
		/* 3 progress icon */               	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloadDevice_ca.paa",
		/* 4 condition to show */           	"(_this distance _target < 3)",
		/* 5 condition for action */        	"(_this distance _target < 3)",
		/* 6 code executed on start */      	{},
		/* 7 code executed per tick */      	{},
		/* 8 code executed on completion */
		{
			playSound "sound1";

			[1, "AUTORIFLEMAN"] call ZO_fnc_gearHandle;
		},
		/* 9 code executed on interruption */  	{},
		/* 10 arguments */                     	[],
		/* 11 action duration */               	1,
		/* 12 priority */                      	8,
		/* 13 remove on completion */          	false,
		/* 14 show unconscious */              	false
	] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select isDedicated,true];
};

fn_addEngineerAction = {
	_object = _this;

	// Add the hold-action to the object
	[
		/* 0 object */                      	_object,
		/* 1 action title */                	"Load ENGINEER",
		/* 2 idle icon */                   	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloadDevice_ca.paa",
		/* 3 progress icon */               	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloadDevice_ca.paa",
		/* 4 condition to show */           	"(_this distance _target < 3)",
		/* 5 condition for action */        	"(_this distance _target < 3)",
		/* 6 code executed on start */      	{},
		/* 7 code executed per tick */      	{},
		/* 8 code executed on completion */
		{
			playSound "sound1";

			[1, "ENGINEER"] call ZO_fnc_gearHandle;
		},
		/* 9 code executed on interruption */   {},
		/* 10 arguments */                      [],
		/* 11 action duration */                1,
		/* 12 priority */                       8,
		/* 13 remove on completion */           false,
		/* 14 show unconscious */               false
	] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select isDedicated,true];
};

fn_addGrenadierAction = {
	_object = _this;

	// Add the hold-action to the object
	[
		/* 0 object */                      	_object,
		/* 1 action title */                	"Load GRENADIER",
		/* 2 idle icon */                   	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloadDevice_ca.paa",
		/* 3 progress icon */               	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloadDevice_ca.paa",
		/* 4 condition to show */           	"(_this distance _target < 3)",
		/* 5 condition for action */        	"(_this distance _target < 3)",
		/* 6 code executed on start */      	{},
		/* 7 code executed per tick */      	{},
		/* 8 code executed on completion */
		{
			playSound "sound1";

			[1, "GRENADIER"] call ZO_fnc_gearHandle;
		},
		/* 9 code executed on interruption */   {},
		/* 10 arguments */                      [],
		/* 11 action duration */                1,
		/* 12 priority */                       8,
		/* 13 remove on completion */           false,
		/* 14 show unconscious */               false
	] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select isDedicated,true];
};

fn_addMarksmanAction = {
	_object = _this;

	// Add the hold-action to the object
	[
		/* 0 object */                           _object,
		/* 1 action title */                    "Load MARKSMAN",
		/* 2 idle icon */                   	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloadDevice_ca.paa",
		/* 3 progress icon */               	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloadDevice_ca.paa",
		/* 4 condition to show */               "(_this distance _target < 3)",
		/* 5 condition for action */            "(_this distance _target < 3)",
		/* 6 code executed on start */          {},
		/* 7 code executed per tick */          {},
		/* 8 code executed on completion */
		{
			playSound "sound1";

			[1, "MARKSMAN"] call ZO_fnc_gearHandle;
		},
		/* 9 code executed on interruption */   {},
		/* 10 arguments */                      [],
		/* 11 action duration */                1,
		/* 12 priority */                       8,
		/* 13 remove on completion */           false,
		/* 14 show unconscious */               false
	] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select isDedicated,true];
};

fn_addMedicAction = {
	_object = _this;

	// Add the hold-action to the object
	[
		/* 0 object */                      	_object,
		/* 1 action title */                	"Load MEDIC",
		/* 2 idle icon */                   	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloadDevice_ca.paa",
		/* 3 progress icon */               	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloadDevice_ca.paa",
		/* 4 condition to show */           	"(_this distance _target < 3)",
		/* 5 condition for action */        	"(_this distance _target < 3)",
		/* 6 code executed on start */      	{},
		/* 7 code executed per tick */      	{},
		/* 8 code executed on completion */
		{
			playSound "sound1";

			[1, "MEDIC"] call ZO_fnc_gearHandle;
		},
		/* 9 code executed on interruption */ 	{},
		/* 10 arguments */                    	[],
		/* 11 action duration */              	1,
		/* 12 priority */                     	8,
		/* 13 remove on completion */         	false,
		/* 14 show unconscious */             	false
	] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select isDedicated,true];
};

fn_addRearmAction = {
	_object = _this;

	// Add the hold-action to the object
	[
		/* 0 object */                      	_object,
		/* 1 action title */
		{
			switch (_this getVariable 'rearmUses') do {
				case -1: {
					"REARM";
				};

				case 0: {
					(format ["REARM</t><t color='#FF0000' align='left'> (%1 uses)", (_this getVariable 'rearmUses')]);
				};

				case 1: {
					(format ["REARM (%1 use)", (_this getVariable 'rearmUses')]);
				};

				default {
					(format ["REARM (%1 uses)", (_this getVariable 'rearmUses')]);
				};
			};
		},
		/* 2 idle icon */                   	"files\holdAction_rearm.paa",
		/* 3 progress icon */               	"files\holdAction_rearm.paa",
		/* 4 condition to show */           	"(_this distance _target < 3)",
		/* 5 condition for action */        	"(_this distance _target < 3) && (_target getVariable ""rearmUses"") != 0",
		/* 6 code executed on start */      	{},
		/* 7 code executed per tick */      	{},
		/* 8 code executed on completion */
		{
			playSound "sound1";

			if (!((missionNameSpace getVariable "playerGear") isEqualTo [])) then {
				_rearmUses = (_target getVariable "rearmUses");
				if (_rearmUses != 0) then {
					if (_rearmUses > 0) then {
						_target setVariable ["rearmUses", _rearmUses - 1, false];
					};
					cutText ["Rearmed", "PLAIN", 0.2];
					[3] call ZO_fnc_gearHandle;
					["ace_medical_treatment_fullHealLocal", [_caller], _caller] call CBA_fnc_targetEvent;
				};
			} else {
				cutText ["You don't have any loadout saved!", "PLAIN", 0.2];
			};
		},
		/* 9 code executed on interruption */
		{
			if ((_target getVariable "rearmUses") == 0) then {
				cutText ["Rearm has no uses left!", "PLAIN", 0.2];
			};
		},
		/* 10 arguments */                      [],
		/* 11 action duration */                1,
		/* 12 priority */                       10,
		/* 13 remove on completion */           false,
		/* 14 show unconscious */               false
	] remoteExec ["ZO_fnc_holdActionAdd",[0,-2] select isDedicated,true];
};

fn_addRiflemanAction = {
	_object = _this;

	// Add the hold-action to the object
	[
		/* 0 object */                           _object,
		/* 1 action title */                    "Load RIFLEMAN",
		/* 2 idle icon */                   	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloadDevice_ca.paa",
		/* 3 progress icon */               	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloadDevice_ca.paa",
		/* 4 condition to show */               "(_this distance _target < 3)",
		/* 5 condition for action */            "(_this distance _target < 3)",
		/* 6 code executed on start */          {},
		/* 7 code executed per tick */          {},
		/* 8 code executed on completion */
		{
			playSound "sound1";

			[1, "RIFLEMAN"] call ZO_fnc_gearHandle;
		},
		/* 9 code executed on interruption */   {},
		/* 10 arguments */                      [],
		/* 11 action duration */                1,
		/* 12 priority */                       8,
		/* 13 remove on completion */           false,
		/* 14 show unconscious */               false
	] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select isDedicated,true];
};

fn_addSaveAction = {
	_object = _this;

	// Add the hold-action to the object
	[
		/* 0 object */                          _object,
		/* 1 action title */                    "SAVE loadout for rearm",
		/* 2 idle icon */                       "files\holdAction_save.paa",
		/* 2 idle icon */                       "files\holdAction_save.paa",
		/* 4 condition to show */               "(_this distance _target < 3)",
		/* 5 condition for action */            "(_this distance _target < 3)",
		/* 6 code executed on start */          {},
		/* 7 code executed per tick */          {},
		/* 8 code executed on completion */
		{
			playSound "sound1";

			[2] call ZO_fnc_gearHandle;
		},
		/* 9 code executed on interruption */   {},
		/* 10 arguments */                      [],
		/* 11 action duration */                1,
		/* 12 priority */                       9,
		/* 13 remove on completion */           false,
		/* 14 show unconscious */               false
	] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select isDedicated,true];
};

fn_addTeamleaderAction = {
	_object = _this;

	// Add the hold-action to the object
	[
		/* 0 object */                          _object,
		/* 1 action title */                    "Load TEAMLEADER",
		/* 2 idle icon */                   	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloadDevice_ca.paa",
		/* 3 progress icon */               	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloadDevice_ca.paa",
		/* 4 condition to show */               "(_this distance _target < 3)",
		/* 5 condition for action */            "(_this distance _target < 3)",
		/* 6 code executed on start */          {},
		/* 7 code executed per tick */          {},
		/* 8 code executed on completion */
		{
			playSound "sound1";

			[1, "TEAMLEADER"] call ZO_fnc_gearHandle;
		},
		/* 9 code executed on interruption */   {},
		/* 10 arguments */                      [],
		/* 11 action duration */                1,
		/* 12 priority */                       8,
		/* 13 remove on completion */           false,
		/* 14 show unconscious */               false
	] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select isDedicated,true];
};

fn_createBox = {
	_position = _this;

	// Spawn ammobox
	_object = createVehicle ["B_supplyCrate_F", _position, [], 0, "CAN_COLLIDE"];
	_object setDir (round random 360);
	[_object, 4] call ace_cargo_fnc_setSize;

	// Empty ammobox
	clearWeaponCargoGlobal _object;
	clearMagazineCargoGlobal _object;
	clearItemCargoGlobal _object;
	clearBackpackCargoGlobal _object;

	// Allow zeuses to move the ammobox
	{
		_x addCuratorEditableObjects [[_object],true];
	} foreach allCurators;

	_object;
};

////////////////////////////////////////////////
//               FUNCTION LOOP                //
////////////////////////////////////////////////

if (isDedicated && !isServer) exitWith {};

_request = _this select 0;

switch (_request) do {
	// START BOX
	case 0: {
		_position = _this select 1;
		_object = _position call fn_createBox;
		_object setVariable ["rearmUses", -1, true];

		_object call fn_addRearmAction;
		_object call fn_addSaveAction;
		// _object call fn_addATRiflemanAction;
		// _object call fn_addAutoriflemanAction;
		_object call fn_addEngineerAction;
		// _object call fn_addGrenadierAction;
		// _object call fn_addMarksmanAction;
		_object call fn_addMedicAction;
		// _object call fn_addRiflemanAction;
		_object call fn_addTeamleaderAction;
		// [_object, true] call ace_arsenal_fnc_initBox;
		// ["AmmoboxInit",[_object,true]] call BIS_fnc_arsenal;
	};

	// REARM BOX
	case 1: {
		_position = _this select 1;
		_object = _position call fn_createBox;
		_object setVariable ["rearmUses", 1, true];

		_object call fn_addRearmAction;
	};

	// START BOX ON OBJECT
	case 2: {
		_object = _this select 1;
		[_object, 4] call ace_cargo_fnc_setSize;
		_object setVariable ["rearmUses", -1, true];

		// Empty ammobox
		clearWeaponCargoGlobal _object;
		clearMagazineCargoGlobal _object;
		clearItemCargoGlobal _object;
		clearBackpackCargoGlobal _object;

		_object call fn_addRearmAction;
		_object call fn_addSaveAction;
		// _object call fn_addATRiflemanAction;
		// _object call fn_addAutoriflemanAction;
		_object call fn_addEngineerAction;
		// _object call fn_addGrenadierAction;
		// _object call fn_addMarksmanAction;
		_object call fn_addMedicAction;
		// _object call fn_addRiflemanAction;
		_object call fn_addTeamleaderAction;
		// [_object, true] call ace_arsenal_fnc_initBox;
		// ["AmmoboxInit",[_object,true]] call BIS_fnc_arsenal;
	};

	// REARM BOX ON OBJECT
	case 3: {
		_object = _this select 1;
		[_object, 4] call ace_cargo_fnc_setSize;

		_alreadyRearmObject = (_object getVariable ["rearmUses", false]);

		_object setVariable ["rearmUses", 1, true];

		if (!_alreadyRearmObject) then {
			_object call fn_addRearmAction;
		};
	};
};
