/*
	@file_name: fn_gearBox.sqf
	@file_author: Dyzalonius
*/

////////////////////////////////////////////////
//                  USAGE                     //
////////////////////////////////////////////////

/*
  // Full arsenal:
  [0, player] spawn ZO_fnc_gearBox;

  // Rearm box:
  [1, player] spawn ZO_fnc_gearBox;

  // Full arsenal in editor:
  [2, this] spawn ZO_fnc_gearBox;
*/

////////////////////////////////////////////////
//               SUB-FUNCTIONS                //
////////////////////////////////////////////////

fn_addATRiflemanAction = {
	_object = _this;

	// Add the hold-action to the object
	[
		/* 0 object */                      _object,
		/* 1 action title */                "Load default AT RIFLEMAN",
		/* 2 idle icon */                   "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff2_ca.paa",
		/* 3 progress icon */               "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff2_ca.paa",
		/* 4 condition to show */           "(_this distance _target < 3)",
		/* 5 condition for action */        "(_this distance _target < 3)",
		/* 6 code executed on start */      {},
		/* 7 code executed per tick */      {},
		/* 8 code executed on completion */
		{
			playSound "sound1";

			[1, "AT RIFLEMAN"] call ZO_fnc_gearHandle;
		},
		/* 9 code executed on interruption */	{},
		/* 10 arguments */						[],
		/* 11 action duration */				1,
		/* 12 priority */						8,
		/* 13 remove on completion */			false,
		/* 14 show unconscious */				false
	] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select isDedicated,true];
};

fn_addAutoriflemanAction = {
	_object = _this;

	// Add the hold-action to the object
	[
		/* 0 object */                      _object,
		/* 1 action title */                "Load default AUTORIFLEMAN",
		/* 2 idle icon */                   "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff2_ca.paa",
		/* 3 progress icon */               "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff2_ca.paa",
		/* 4 condition to show */           "(_this distance _target < 3)",
		/* 5 condition for action */        "(_this distance _target < 3)",
		/* 6 code executed on start */      {},
		/* 7 code executed per tick */      {},
		/* 8 code executed on completion */
		{
			playSound "sound1";

			[1, "AUTORIFLEMAN"] call ZO_fnc_gearHandle;
		},
		/* 9 code executed on interruption */  {},
		/* 10 arguments */                     [],
		/* 11 action duration */               1,
		/* 12 priority */                      8,
		/* 13 remove on completion */          false,
		/* 14 show unconscious */              false
	] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select isDedicated,true];
};

fn_addEngineerAction = {
	_object = _this;

	// Add the hold-action to the object
	[
		/* 0 object */                      _object,
		/* 1 action title */                "Load default ENGINEER",
		/* 2 idle icon */                   "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff2_ca.paa",
		/* 3 progress icon */               "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff2_ca.paa",
		/* 4 condition to show */           "(_this distance _target < 3)",
		/* 5 condition for action */        "(_this distance _target < 3)",
		/* 6 code executed on start */      {},
		/* 7 code executed per tick */      {},
		/* 8 code executed on completion */
		{
			playSound "sound1";

			[1, "ENGINEER"] call ZO_fnc_gearHandle;
		},
		/* 9 code executed on interruption */	{},
		/* 10 arguments */						[],
		/* 11 action duration */				1,
		/* 12 priority */						8,
		/* 13 remove on completion */			false,
		/* 14 show unconscious */				false
	] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select isDedicated,true];
};

fn_addMedicAction = {
	_object = _this;

	// Add the hold-action to the object
	[
		/* 0 object */                      _object,
		/* 1 action title */                "Load default MEDIC",
		/* 2 idle icon */                   "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff2_ca.paa",
		/* 3 progress icon */               "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff2_ca.paa",
		/* 4 condition to show */           "(_this distance _target < 3)",
		/* 5 condition for action */        "(_this distance _target < 3)",
		/* 6 code executed on start */      {},
		/* 7 code executed per tick */      {},
		/* 8 code executed on completion */
		{
			playSound "sound1";

			[1, "MEDIC"] call ZO_fnc_gearHandle;
		},
		/* 9 code executed on interruption */ {},
		/* 10 arguments */                    [],
		/* 11 action duration */              1,
		/* 12 priority */                     8,
		/* 13 remove on completion */         false,
		/* 14 show unconscious */             false
	] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select isDedicated,true];
};

fn_addRearmAction = {
	_object = _this;

	// Add the hold-action to the object
	[
		/* 0 object */                      _object,
		/* 1 action title */                "REARM",
		/* 2 idle icon */                   "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff1_ca.paa",
		/* 3 progress icon */               "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff1_ca.paa",
		/* 4 condition to show */           "(_this distance _target < 3)",
		/* 5 condition for action */        "(_this distance _target < 3)",
		/* 6 code executed on start */      {},
		/* 7 code executed per tick */      {},
		/* 8 code executed on completion */
		{
			playSound "sound1";

			[3] call ZO_fnc_gearHandle;
		},
		/* 9 code executed on interruption */	{},
		/* 10 arguments */						[],
		/* 11 action duration */				1,
		/* 12 priority */						10,
		/* 13 remove on completion */			false,
		/* 14 show unconscious */				false
	] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select isDedicated,true];
};

fn_addRiflemanAction = {
	_object = _this;

	// Add the hold-action to the object
	[
		/* 0 object */							_object,
		/* 1 action title */					"Load default RIFLEMAN",
		/* 2 idle icon */						"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff2_ca.paa",
		/* 3 progress icon */					"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff2_ca.paa",
		/* 4 condition to show */				"(_this distance _target < 3)",
		/* 5 condition for action */			"(_this distance _target < 3)",
		/* 6 code executed on start */			{},
		/* 7 code executed per tick */			{},
		/* 8 code executed on completion */
		{
			playSound "sound1";

			[1, "RIFLEMAN"] call ZO_fnc_gearHandle;
		},
		/* 9 code executed on interruption */	{},
		/* 10 arguments */						[],
		/* 11 action duration */				1,
		/* 12 priority */						8,
		/* 13 remove on completion */			false,
		/* 14 show unconscious */				false
	] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select isDedicated,true];
};

fn_addSaveAction = {
	_object = _this;

	// Add the hold-action to the object
	[
		/* 0 object */							_object,
		/* 1 action title */					"SAVE loadout for rearm",
		/* 2 idle icon */						"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff1_ca.paa",
		/* 3 progress icon */					"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff1_ca.paa",
		/* 4 condition to show */				"(_this distance _target < 3)",
		/* 5 condition for action */			"(_this distance _target < 3)",
		/* 6 code executed on start */			{},
		/* 7 code executed per tick */			{},
		/* 8 code executed on completion */
		{
			playSound "sound1";

			[2] call ZO_fnc_gearHandle;
		},
		/* 9 code executed on interruption */	{},
		/* 10 arguments */						[],
		/* 11 action duration */				1,
		/* 12 priority */						9,
		/* 13 remove on completion */			false,
		/* 14 show unconscious */				false
	] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select isDedicated,true];
};

fn_addTeamleaderAction = {
	_object = _this;

	// Add the hold-action to the object
	[
		/* 0 object */							_object,
		/* 1 action title */					"Load default TEAMLEADER",
		/* 2 idle icon */						"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff2_ca.paa",
		/* 3 progress icon */					"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff2_ca.paa",
		/* 4 condition to show */				"(_this distance _target < 3)",
		/* 5 condition for action */			"(_this distance _target < 3)",
		/* 6 code executed on start */			{},
		/* 7 code executed per tick */			{},
		/* 8 code executed on completion */
		{
			playSound "sound1";

			[1, "TEAMLEADER"] call ZO_fnc_gearHandle;
		},
		/* 9 code executed on interruption */	{},
		/* 10 arguments */						[],
		/* 11 action duration */				1,
		/* 12 priority */						8,
		/* 13 remove on completion */			false,
		/* 14 show unconscious */				false
	] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select isDedicated,true];
};

fn_createBox = {
	_position = _this;

	// Spawn ammobox
	_object = createVehicle ["B_supplyCrate_F", _position, [], 0, "CAN_COLLIDE"];

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

_request = _this select 0;

switch (_request) do {
	// START BOX
	case 0: {
		_position = position (_this select 1);
		_object = _position call fn_createBox;

		_object call fn_addRearmAction;
		_object call fn_addSaveAction;

		_object call fn_addATRiflemanAction;
		_object call fn_addAutoriflemanAction;
		_object call fn_addEngineerAction;
		_object call fn_addMedicAction;
		_object call fn_addRiflemanAction;
		_object call fn_addTeamleaderAction;
		[_object, true] call ace_arsenal_fnc_initBox;
		["AmmoboxInit",[_object,true]] call BIS_fnc_arsenal;
	};

	// REARM BOX
	case 1: {
		_position = position (_this select 1);
		_object = _position call fn_createBox;

		_object call fn_addRearmAction;
	};

	// START BOX EDITOR
	case 2: {
		if (!isServer) exitWith {};

		_object = _this select 1;

		// Empty ammobox
		clearWeaponCargoGlobal _object;
		clearMagazineCargoGlobal _object;
		clearItemCargoGlobal _object;
		clearBackpackCargoGlobal _object;

		_object call fn_addRearmAction;
		_object call fn_addSaveAction;

		_object call fn_addATRiflemanAction;
		_object call fn_addAutoriflemanAction;
		_object call fn_addEngineerAction;
		_object call fn_addMedicAction;
		_object call fn_addRiflemanAction;
		_object call fn_addTeamleaderAction;
		[_object, true] call ace_arsenal_fnc_initBox;
		["AmmoboxInit",[_object,true]] call BIS_fnc_arsenal;
	};
};
