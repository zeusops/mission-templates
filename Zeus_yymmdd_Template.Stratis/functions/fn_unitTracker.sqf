/*
	@file_name: fn_unitTracker.sqf
	@file_author: Dyzalonius
*/

////////////////////////////////////////////////
//                  USAGE                     //
////////////////////////////////////////////////

/*
  // Start the unittracker for a player:
  [0] spawn ZO_fnc_unitTracker;

  // Edit update interval:
  [1, a] spawn ZO_fnc_unitTracker;
  a: _updateInterval (lower than 0.05 has no effect)

  // Example interval:
  [1, 0.05] spawn ZO_fnc_unitTracker;

*/

////////////////////////////////////////////////
//               SUB-FUNCTIONS                //
////////////////////////////////////////////////

fn_createMarker = {
	private _unit = _this;

	private _markerName = (format["%1_%2", (_unit select 2), (_unit select 1)]);
	private _marker = createMarkerLocal [_markerName,(getPosVisual (_unit select 0))];
	private _markerType = [_unit] call {
		private ["_unit","_prefix","_type","_markerType"];
		_unit = _this select 0;
		_prefix = "b_";
		_type = "unknown";
		if ((_unit select 1) in (missionNameSpace getVariable "unitTrackerInfantry")) then {_type = "inf";};
		if ((_unit select 1) in (missionNameSpace getVariable "unitTrackerHQ")) then {_type = "hq";};
		if ((_unit select 1) in (missionNameSpace getVariable "unitTrackerAir")) then {_type = "air";};
		if ((_unit select 1) in (missionNameSpace getVariable "unitTrackerArmor")) then {_type = "armor";};
		if ((_unit select 1) in (missionNameSpace getVariable "unitTrackerPlane")) then {_type = "plane";};
		if ((_unit select 1) in (missionNameSpace getVariable "unitTrackerMotorized")) then {_type = "motor_inf";};
		if ((_unit select 1) in (missionNameSpace getVariable "unitTrackerNaval")) then {_type = "naval";};
		if ((_unit select 1) in (missionNameSpace getVariable "unitTrackerMaintenance")) then {_type = "maint";};
		if ((_unit select 1) in (missionNameSpace getVariable "unitTrackerUAV")) then {_type = "uav";};
		if ((_unit select 1) in (missionNameSpace getVariable "unitTrackerArtillery")) then {_type = "art";};
		if ((_unit select 1) in (missionNameSpace getVariable "unitTrackerFOB")) then {_type = "service";};
		if ((_unit select 1) in (missionNameSpace getVariable "unitTrackerSupport")) then {_type = "support";};
		if ((_unit select 1) in (missionNameSpace getVariable "unitTrackerRecon")) then {_type = "recon";};
		_markerType = _prefix + _type;
		_markerType;
	};
	_marker setMarkerTypeLocal _markerType;
	_marker setMarkerTextLocal (_unit select 1);
	_marker setMarkerColorLocal (missionNameSpace getVariable "unitTrackerColor");
};

fn_drawUnit = {
	private _unit = _this;
	private _markerName = format ["%1_%2", (_unit select 2), (_unit select 1)];

	if (getMarkerColor _markerName == "") then {
		_unit spawn fn_createMarker;
	} else {
		_unit spawn fn_updateMarker;
	};
};

fn_unitTracker = {
	while {true} do {
		private _units = missionNameSpace getVariable "unitsTracked";

		{
			_x spawn fn_drawUnit;
		} foreach _units;

		_defaultInterval = 0.05;
		_interval = missionNamespace getVariable "unitTrackerInterval";
		if (_interval < _defaultInterval) then {
			_interval = _defaultInterval;
		};
		sleep _interval;
	};
};

fn_unitUpdater = {
	private _oldUnits = [];
	private _units = [];

	while {true} do {
		_units = [];

		{
			if ( (side group player == side _x || side group player == sidelogic) && (["IsGroupRegistered", [_x]] call { _this call (missionNamespace getVariable ["BIS_fnc_dynamicGroups", {}]); }) && (isPlayer leader _x) && (count units _x > 0) ) then {
				if !([(leader _x),(groupId _x),(side _x)] in _units) then {
					_units pushback [(leader _x), (groupId _x), (side _x)];
				};
			};
		} foreach allGroups;
		missionNameSpace setVariable ["unitsTracked", _units, false];

		sleep 0.1;

		{
			deleteMarkerLocal (format["%1_%2", (_x select 2), (_x select 1)]);
		} foreach (_oldUnits - _units);
		_oldUnits = []+_units;
	};
};

fn_updateMarker = {
	private _unit = _this;
	private _position = getPosVisual (_unit select 0);
	private _markerName = format["%1_%2", (_unit select 2), (_unit select 1)];

	_markerName setMarkerPosLocal _position;
	_markerName setMarkerColorLocal (missionNameSpace getVariable "unitTrackerColor");
};

////////////////////////////////////////////////
//               FUNCTION LOOP                //
////////////////////////////////////////////////

_request = _this select 0;

switch (_request) do {
	// update all units
	case 0: {
		missionNameSpace setVariable ["unitsTracked", [], false];

		sleep 5;

		[] spawn fn_unitTracker;
		[] spawn fn_unitUpdater;
	};

	// set update interval
	case 1: {
		_interval = _this select 1;
		missionNameSpace setVariable ["unitTrackerInterval", _interval, true];
	};
};
