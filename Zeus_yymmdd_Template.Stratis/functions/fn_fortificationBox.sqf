/*
	@file_name: fn_fortificationBox.sqf
	@file_author: Dyzalonius
*/

////////////////////////////////////////////////
//               SUB-FUNCTIONS                //
////////////////////////////////////////////////

fn_addConfirmAction = {
    _object = _this;

    // Add the hold-action to the object
	_actionId = [
		/* 0 object */                      player,
		/* 1 action title */
		{
			"Place object"
		},
		/* 2 idle icon */                   "files\holdAction_hammer.paa",
		/* 3 progress icon */               "files\holdAction_hammer.paa",
		/* 4 condition to show */           "true",
		/* 5 condition for action */        "true",
		/* 6 code executed on start */      {},
		/* 7 code executed per tick */      {},
		/* 8 code executed on completion */
		{
			playSound "sound1";

            _object = _caller getVariable "movingObject";
            _caller setVariable ["movingObject", objNull, true];
            _caller setVariable ["movingObjectOrigin", objNull, true];
            _caller setVariable ["movingObjectMaterialCost", 0, true];
            _object setVariable ["moving", false, true];
            [_caller, "forceWalk", "MovingObject", false] call ace_common_fnc_statusEffect_set;
            _caller action ["SwitchWeapon", _caller, _caller, 0];
            ["ace_common_enableSimulationGlobal", [_object, true]] call CBA_fnc_serverEvent;
			[] call fn_removeAllMovingObjectActions;
		},
		/* 9 code executed on interruption */   {},
		/* 10 arguments */                      [],
		/* 11 action duration */                1,
		/* 12 priority */                       10,
		/* 13 remove on completion */           false,
		/* 14 show unconscious */               false
	] call ZO_fnc_holdActionAdd;

	// Add action id to players movingObjectActionIDs
	_actionID call fn_addMovingObjectActionID;
};

fn_addMovingObjectActionID = {
	_actionID = _this;
	_actionIDs = player getVariable ["movingObjectActionIDs", []];
	_actionIDs pushback _actionID;
	player setVariable ["movingObjectActionIDs", _actionIDs, false];
};

fn_removeAllMovingObjectActions = {
	_actionIDs = player getVariable ["movingObjectActionIDs", []];
	{
		player removeAction _x;
	} foreach _actionIDs;
};

fn_addReturnAction = {
    _object = _this;

    // Add the hold-action to the object
	_actionId = [
		/* 0 object */                      player,
		/* 1 action title */
		{
			"<t color='#ff8888'>Return object</t>"
		},
		/* 2 idle icon */                   "files\holdAction_return.paa",
		/* 3 progress icon */               "files\holdAction_return.paa",
		/* 4 condition to show */           "true",
		/* 5 condition for action */        "true",
		/* 6 code executed on start */      {},
		/* 7 code executed per tick */      {},
		/* 8 code executed on completion */
		{
			playSound "sound1";

            _caller call fn_returnObject;
		},
		/* 9 code executed on interruption */   {},
		/* 10 arguments */                      [],
		/* 11 action duration */                1,
		/* 12 priority */                       7,
		/* 13 remove on completion */           false,
		/* 14 show unconscious */               false
	] call ZO_fnc_holdActionAdd;

	// Add action id to players movingObjectActionIDs
	_actionID call fn_addMovingObjectActionID;
};

fn_addRotateAction = {
    _object = _this;

    _actionId = player addAction [
        "<t color='#FFFFFF' align='left'>Rotate object</t>        <t color='#83ffffff' align='right'>R     </t>",
        {
            params ["_target", "_caller", "_actionId", "_arguments"];
			playSound "sound1";

            _object  = _caller getVariable "movingObject";
            _rotation = _object getVariable "rotation";
            _rotation = (_rotation + 30) % 360;
            _object setVariable ["rotation",  _rotation, true];
		},
        [], // arguments
        9, // priority
        false, // showWindow
        false, // hideOnUse
        "reloadMagazine", // shortcut
        "true" // condition
    ];

	// Add action id to players movingObjectActionIDs
	_actionID call fn_addMovingObjectActionID;
};

fn_addSnapAction = {
    _object = _this;

    _actionId = player addAction [
        "<t color='#FFFFFF' align='left'>Toggle snap</t>        <t color='#83ffffff' align='right'>E     </t>",
        {
            params ["_target", "_caller", "_actionId", "_arguments"];
			playSound "sound1";

            _object  = _caller getVariable "movingObject";
            _snapToTerrain = _object getVariable "snapToTerrain";
            _object setVariable ["snapToTerrain",  !_snapToTerrain, true];
		},
        [], // arguments
        8, // priority
        false, // showWindow
        false, // hideOnUse
        "LeanRight", // shortcut
        "true" // condition
    ];

	// Add action id to players movingObjectActionIDs
	_actionID call fn_addMovingObjectActionID;
};

fn_addFortificationAction = {
	_object = _this select 0;
	_objectClassname = _this select 1;
	_objectName = _this select 2;
	_objectCost = _this select 3;
	_objectDistance = _this select 4;
	_objectDefaultRotation = _this select 5;

	//TODO: try setting the arguments as variables, or passing arguments, or embedding arguments

	// Add the hold-action to the object
	[
		/* 0 object */                      _object,
		/* 1 action title */
		{
			_target = _this select 0;
			_arguments = _this select 1;
			_name = _arguments select 1;
			_cost = _arguments select 2;
			if (typeName _cost == "STRING") then {
				_cost = parseNumber _cost;
			};
			if ((_target getVariable 'materialCount') - _cost < 0) then {
				(format ["</t><t color='#FFFF00' align='left'>%1</t><t color='#FFFFFF' align='left'>, cost %2 </t><t color='#FF0000' align='left'>(%3 left)", _name, _cost, (_target getVariable 'materialCount')]);
            } else {
                (format ["</t><t color='#FFFF00' align='left'>%1</t><t color='#FFFFFF' align='left'>, cost %2 (%3 left)", _name, _cost, (_target getVariable 'materialCount')]);
            };
		},
		/* 2 idle icon */                   "files\holdAction_hammer.paa",
		/* 3 progress icon */               "files\holdAction_hammer.paa",
		/* 4 condition to show */           "(_this distance _target < (_target getVariable ""interactionDistance"")) && ((_this getVariable [""movingObject"", objNull]) isEqualTo objNull)",
		/* 5 condition for action */        "(_this distance _target < (_target getVariable ""interactionDistance"")) && (_target getVariable ""materialCount"") >= (_arguments select 2) && {_isEngineer = _this getVariable [""Ace_IsEngineer"", 0]; if (_isEngineer isEqualType false) then { _isEngineer = [0, 1] select _isEngineer; }; _isEngineer == 1}",
		/* 6 code executed on start */      {},
		/* 7 code executed per tick */      {},
		/* 8 code executed on completion */
		{
			playSound "sound1";

            _objectClassname = _arguments select 0;
            _objectCost = _arguments select 2;
            _objectDistance = _arguments select 3;
			_objectDefaultRotation = _arguments select 4;
            _materialCount = (_target getVariable "materialCount");

            if (_materialCount >= _objectCost) then {
                _target setVariable ["materialCount", _materialCount - _objectCost, true];
                [_objectClassname, _objectCost, _objectDistance, _objectDefaultRotation, _target] call fn_giveObject;
                _target setVariable ["updateAllHoldActions", true, true];
            };
		},
		/* 9 code executed on interruption */
		{
			_isEngineer = _caller getVariable ["Ace_IsEngineer", 0];
			if (_isEngineer isEqualType false) then {
				_isEngineer = [0, 1] select _isEngineer;
			};
			if (_isEngineer != 1) then {
				cutText ["You are not an engineer", "PLAIN", 0.2];
			};
		},
		/* 10 arguments */                      [_objectClassname, _objectName, _objectCost, _objectDistance, _objectDefaultRotation],
		/* 11 action duration */                1,
		/* 12 priority */                       10,
		/* 13 remove on completion */           false,
		/* 14 show unconscious */               false
	] remoteExec ["ZO_fnc_holdActionAddFortification",[0,-2] select isDedicated,true];
};

fn_createBox = {
	_position = _this select 0;
    _classname = _this select 1;

	// Spawn ammobox
	_object = createVehicle [_classname, _position, [], 0, "CAN_COLLIDE"];

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

fn_giveObject = {
    _classname = _this select 0;
    _materialCost = _this select 1;
    _distanceToPlayer = _this select 2;
	_defaultRotation = _this select 3;
    _box = _this select 4;
    _unit = player;
    _object = createVehicle [_classname, [0, 0, 0]];
    _object setVariable ["moving", true, true];
	_object setVariable ["rotation", _defaultRotation, true];
    _object setVariable ["snapToTerrain", false, true];
    _unit setVariable ["movingObject", _object, true];
    _unit setVariable ["movingObjectMaterialCost", _materialCost, true];
    _unit setVariable ["movingObjectOrigin", _box, true];

    // prevent the placing unit from running
    [_unit, "forceWalk", "MovingObject", true] call ace_common_fnc_statusEffect_set;

    // Prevent collisions with object
    ["ace_common_enableSimulationGlobal", [_object, false]] call CBA_fnc_serverEvent;

    [_object, _distanceToPlayer] spawn fn_updateObject;
    _object spawn fn_addConfirmAction;
    _object spawn fn_addReturnAction;
    _object spawn fn_addRotateAction;
    _object spawn fn_addSnapAction;
};

fn_returnObject = {
	_caller = _this;
	_box = _caller getVariable "movingObjectOrigin";
	_materialCost = _caller getVariable "movingObjectMaterialCost";
	_object = _caller getVariable "movingObject";

	_caller setVariable ["movingObject", objNull, true];
	_caller setVariable ["movingObjectOrigin", objNull, true];
	_caller setVariable ["movingObjectMaterialCost", 0, true];
	[_caller, "forceWalk", "MovingObject", false] call ace_common_fnc_statusEffect_set;
	[] call fn_removeAllMovingObjectActions;

	if (!(_object isEqualTo objNull)) then {
		deleteVehicle _object;
	};

	if (!(_box isEqualTo objNull)) then {
		_box setVariable ["materialCount", (_box getVariable "materialCount") + _materialCost, true];
		_box setVariable ["updateAllHoldActions", true, true];
	};
};

fn_updateObject = {
    _object = _this select 0;
    _distanceToPlayer = _this select 1;
    _unit = player;
    _objectPos = [];
    _objectDir = 0;

    while {alive _object && _object getVariable "moving"} do {
        // Force player to holster weapon
        _unit action ["SwitchWeapon", _unit, _unit, -1];

        _objectPos = _unit ModelToWorld [0,_distanceToPlayer,0];
        _objectDir = getDir _unit + (_object getVariable "rotation");

		// Exit if player dead, unconscious or in a vehicle, or if object is gone
		if (!alive _unit || !alive _object || (!(isNull (objectParent _unit))) || (_unit getVariable ["ACE_isUnconscious", false])) exitWith {
			_unit call fn_returnObject;
		};

        // _v1 forward from the player, _v2 to the right, _v3 points away from the ground
        private _v3 = surfaceNormal _objectPos;
        private _v2 = [sin _objectDir, +cos _objectDir, 0] vectorCrossProduct _v3;
        private _v1 = _v3 vectorCrossProduct _v2;

        // Stick the object to the ground
        _objectPos set [2, getTerrainHeightASL _objectPos];

        // Set object position
        _object setPosASL _objectPos;
        if (_object getVariable "snapToTerrain") then {
            _object setVectorDirAndUp [_v1, _v3];
        } else {
            _v1 set [2, 0];
            _object setVectorDirAndUp [_v1, [0,0,1]];
        };
    };
};

////////////////////////////////////////////////
//               FUNCTION LOOP                //
////////////////////////////////////////////////

if (isDedicated && !isServer) exitWith {};

_request = _this select 0;

switch (_request) do {
	// INITIALISATION
	case -1: {

	};

	// SMALL FORTIFICATIONS
	case 0: {
        _position = _this select 1;
        _materialCount = 10;
        _interactionDistance = 3;
        _object = [_position, "CargoNet_01_box_f"] call fn_createBox;
		[_object, 4] call ace_cargo_fnc_setSize;
		_object setDir (round random 360);
        _object setVariable ["materialCount", _materialCount, true];
        _object setVariable ["interactionDistance", _interactionDistance, true];

		// params = [_box, _className, _displayName, _cost, _distanceFromPlayer]
		[_object, "Land_BagBunker_Small_F", "BAGBUNKER", 5, 4, 180] call fn_addFortificationAction;
		[_object, "Land_BagFence_Long_F", "BAGWALL", 1, 3, 0] call fn_addFortificationAction;
		[_object, "Land_BagFence_Round_F", "BAGWALLROUND", 1, 3, 180] call fn_addFortificationAction;
		[_object, "Land_HBarrier_1_F", "HBARRIER", 2, 3, 90] call fn_addFortificationAction;
		[_object, "Land_CzechHedgeHog_01_new_F", "HEDGEHOG", 1, 3, 0] call fn_addFortificationAction;
	};

	// BIG FORTIFICATIONS
	case 1: {
        _position = _this select 1;
        _materialCount = 100;
        _interactionDistance = 5;
        _object = [_position, "B_Slingload_01_Cargo_F"] call fn_createBox;
		_object setDir (round random 360);
        _object setVariable ["materialCount", _materialCount, true];
        _object setVariable ["interactionDistance", _interactionDistance, true];

		// params = [_box, _className, _displayName, _cost, _distanceFromPlayer _defaultRotation]
		[_object, "Land_BagBunker_Large_F", "BAGBUNKERLARGE", 20, 9, 180] call fn_addFortificationAction;
		[_object, "Land_BagBunker_Small_F", "BAGBUNKERSMALL", 5, 4, 180] call fn_addFortificationAction;
		[_object, "Land_BagFence_Long_F", "BAGWALL", 1, 3, 0] call fn_addFortificationAction;
		[_object, "Land_BagFence_Round_F", "BAGWALLROUND", 1, 3, 180] call fn_addFortificationAction;
		[_object, "Land_HBarrier_1_F", "HBARRIER1", 2, 3, 90] call fn_addFortificationAction;
		[_object, "Land_HBarrier_3_F", "HBARRIER3", 6, 3, 0] call fn_addFortificationAction;
		[_object, "Land_HBarrier_5_F", "HBARRIER5", 10, 5, 0] call fn_addFortificationAction;
		[_object, "Land_HBarrier_Big_F", "HBARRIERLARGE", 10, 6, 0] call fn_addFortificationAction;
		[_object, "Land_CzechHedgeHog_01_new_F", "HEDGEHOG", 1, 3, 0] call fn_addFortificationAction;
		[_object, "Land_CncShelter_F", "CONCRETESHELTER", 4, 3, 0] call fn_addFortificationAction;
		[_object, "Land_CncBarrierMedium_F", "CONCRETEBARRIER", 1, 3, 0] call fn_addFortificationAction;
		[_object, "Land_Razorwire_F", "RAZORWIRE", 1, 6, 0] call fn_addFortificationAction;
	};

	// SMALL FORTIFICATIONS ON EXISTING OBJECT
	case 2: {
        _object = _this select 1;
        _materialCount = 10;
        _interactionDistance = 3;
		[_object, 4] call ace_cargo_fnc_setSize;
        _object setVariable ["materialCount", _materialCount, true];
        _object setVariable ["interactionDistance", _interactionDistance, true];

		// params = [_box, _className, _displayName, _cost, _distanceFromPlayer]
		[_object, "Land_BagBunker_Small_F", "BAGBUNKER", 5, 4, 180] call fn_addFortificationAction;
		[_object, "Land_BagFence_Long_F", "BAGWALL", 1, 3, 0] call fn_addFortificationAction;
		[_object, "Land_BagFence_Round_F", "BAGWALLROUND", 1, 3, 180] call fn_addFortificationAction;
		[_object, "Land_HBarrier_1_F", "HBARRIER", 2, 3, 90] call fn_addFortificationAction;
		[_object, "Land_CzechHedgeHog_01_new_F", "HEDGEHOG", 1, 3, 0] call fn_addFortificationAction;
	};

	// BIG FORTIFICATIONS ON EXISTING OBJECT
	case 3: {
        _object = _this select 1;
        _materialCount = 100;
        _interactionDistance = 10;
        _object setVariable ["materialCount", _materialCount, true];
        _object setVariable ["interactionDistance", _interactionDistance, true];

		// params = [_box, _className, _displayName, _cost, _distanceFromPlayer]
		[_object, "Land_BagBunker_Large_F", "BAGBUNKERLARGE", 20, 9, 180] call fn_addFortificationAction;
		[_object, "Land_BagBunker_Small_F", "BAGBUNKERSMALL", 5, 4, 180] call fn_addFortificationAction;
		[_object, "Land_BagFence_Long_F", "BAGWALL", 1, 3, 0] call fn_addFortificationAction;
		[_object, "Land_BagFence_Round_F", "BAGWALLROUND", 1, 3, 180] call fn_addFortificationAction;
		[_object, "Land_HBarrier_1_F", "HBARRIER1", 2, 3, 90] call fn_addFortificationAction;
		[_object, "Land_HBarrier_3_F", "HBARRIER3", 6, 3, 0] call fn_addFortificationAction;
		[_object, "Land_HBarrier_5_F", "HBARRIER5", 10, 5, 0] call fn_addFortificationAction;
		[_object, "Land_HBarrier_Big_F", "HBARRIERLARGE", 10, 6, 0] call fn_addFortificationAction;
		[_object, "Land_CzechHedgeHog_01_new_F", "HEDGEHOG", 1, 3, 0] call fn_addFortificationAction;
		[_object, "Land_CncShelter_F", "CONCRETESHELTER", 4, 3, 0] call fn_addFortificationAction;
		[_object, "Land_CncBarrierMedium_F", "CONCRETEBARRIER", 1, 3, 0] call fn_addFortificationAction;
		[_object, "Land_Razorwire_F", "RAZORWIRE", 1, 6, 0] call fn_addFortificationAction;
	};
};
