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
		if ((_unit select 1) in ["A","A1","A2","B","B1","B2","C","C1","C2"]) then {_type = "inf";};
		if ((_unit select 1) in ["HQ1PLT","ASL","BSL","CSL"]) then {_type = "hq";};
		if ((_unit select 1) in ["Z1","Z2","Z3","Z4","Z5","Z6"]) then {_type = "air";};
		if ((_unit select 1) in ["Y1","Y2","Y3","Y4","Y5","Z6"]) then {_type = "armor";};
		if ((_unit select 1) in ["W1","W2","W3","W4","W5","Z6"]) then {_type = "plane";};
		if ((_unit select 1) in ["V1","V2","V3","V4","V5","V6"]) then {_type = "motor_inf";};
		if ((_unit select 1) in ["U1","U2","U3","U4","U5","Z6"]) then {_type = "naval";};
		_markerType = _prefix + _type;
		_markerType;
	};
	_marker setMarkerTypeLocal _markerType;
	_marker setMarkerTextLocal (_unit select 1);
	_marker setMarkerColorLocal (missionNameSpace getVariable "unitColor");
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
	_markerName setMarkerColorLocal (missionNameSpace getVariable "unitColor");
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
