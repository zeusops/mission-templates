/*
	@file_name: fn_unitTracker.sqf
	@file_author: Dyzalonius
*/

////////////////////////////////////////////////
//               SUB-FUNCTIONS                //
////////////////////////////////////////////////

fn_createMarker = {
	private _unit = _this select 0;
	private _groupMarkerAlpha = _this select 1;
	
	private _markername = (format["%1_%2", (_unit select 2), (_unit select 1)]);
	private _marker = createMarkerLocal [_markername,(getPosVisual (_unit select 0))];
	private _markerType = [_unit] call {
		private ["_unit","_prefix","_type","_markerType"];
		_unit = _this select 0;
		_prefix = "b_";
		_type = "unknown";
		if ((_unit select 1) in ["A","A1","A2","B","B1","B2","C","C1","C2"]) then {_type = "inf";};
		if ((_unit select 1) in ["HQ1PLT","ASL","BSL","CSL"]) then {_type = "hq";};
		if ((_unit select 1) in ["Y1","Y2","Y3","Y4"]) then {_type = "armor";};
		if ((_unit select 1) in ["Z1","Z2","Z3","Z4"]) then {_type = "air";};
		if ((_unit select 1) in ["W1","W2","W3","W4"]) then {_type = "plane";};
		_markerType = _prefix + _type;
		_markerType;
	};
	_marker setMarkerAlphaLocal _groupMarkerAlpha;
	_marker setMarkerTypeLocal _markerType;
	_marker setMarkerTextLocal (_unit select 1);
	_marker setMarkerColorLocal (missionNameSpace getVariable "unitColor");
};

fn_drawUnit = {
	private _unit = _this select 0;
	private _alpha = _this select 1;
	
	if (getMarkerColor (format ["%1_%2", (_unit select 2), (_unit select 1)]) == "") then {
		[_unit, _alpha] spawn fn_createMarker;
	} else {
		[_unit, _alpha] spawn fn_updateMarker;
	};
};

fn_unitTrackerAlpha = {
	private _flickerDelta = 0;
	private _flickerOn = true;
	private _alpha = 0;
	
	while {true} do {
		private _hasGPS = ("ItemGPS" in (assignedItems player) || "B_UavTerminal" in (assignedItems player) || "O_UavTerminal" in (assignedItems player) || "I_UavTerminal" in (assignedItems player) || "C_UavTerminal" in (assignedItems player));
		private _effects = missionNamespace getVariable "unitTrackerEffects";
		
		if ((_effects select 4) > 0 && (_effects select 6) > 0) then {
			if ((_flickerOn && _flickerDelta > (_effects select 4) - (_effects select 5) + (_effects select 5)*2*(random 1))
			|| (!_flickerOn && _flickerDelta > (_effects select 6) - (_effects select 7) + (_effects select 7)*2*(random 1))) then {
				_flickerOn = !_flickerOn;
				_flickerDelta = 0;
			};
			_flickerDelta = _flickerDelta + 0.01;
		} else {
			_flickerOn = true;
			_flickerDelta = 0;
		};
		
		if (_hasGPS && _flickerOn) then {
			_alpha = _alpha - 0.05 + 0.1*(round random 1);
			if (_alpha < (_effects select 2)) then {
				_alpha = (_effects select 2);
			};
			if (_alpha > (_effects select 3)) then {
				_alpha = (_effects select 3);
			};
			missionNameSpace setVariable ["unitsTrackedAlpha", _alpha, false];
		} else {
			missionNameSpace setVariable ["unitsTrackedAlpha", 0, false];
		};
		
		sleep 0.05;
	};
};

fn_unitLastPosUpdater = {
	private _lastPositions = [[], []];
	
	while {true} do {
		_lastPositions = [[], []];
		
		{
			(_lastPositions select 0) pushback (format["%1_%2", (_x select 2), (_x select 1)]);
			(_lastPositions select 1) pushback (getPosVisual (_x select 0));
		} foreach (missionNamespace getVariable "unitsTracked");
		missionNameSpace setVariable ["unitsTrackedLastPositions", _lastPositions, false];
		
		_interval = 0.1;
		if ((missionNamespace getVariable "unitTrackerEffects" select 0) > 0) then {
			_interval = (missionNamespace getVariable "unitTrackerEffects" select 0) - (missionNamespace getVariable "unitTrackerEffects" select 1) + (missionNamespace getVariable "unitTrackerEffects" select 1)*2*(random 1);
		};
		sleep _interval;
	};
};

fn_unitTracker = {
	while {true} do {
		private _alpha = missionNamespace getVariable "unitsTrackedAlpha";
		private _units = missionNameSpace getVariable "unitsTracked";
		
		{
			[_x, _alpha] spawn fn_drawUnit;
		} foreach _units;
		
		sleep 0.05;
	};
};

fn_unitUpdater = {
	private _oldUnits = [];
	private _units = [];
	
	[] spawn fn_unitLastPosUpdater;
	
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
	private _unit = _this select 0;
	private _alpha = _this select 1;
	private _position = getPosVisual (_unit select 0);
	
	if ((missionNamespace getVariable "unitTrackerEffects" select 0) != 0) then {
		_index = (missionNamespace getVariable "unitsTrackedLastPositions" select 0 find (format ["%1_%2", _unit select 2, _unit select 1]));
		
		if (_index != -1) then {
			_position = missionNamespace getVariable "unitsTrackedLastPositions" select 1 select _index;
		};
	};
	
	(format["%1_%2", (_unit select 2), (_unit select 1)]) setMarkerPosLocal _position;
	(format["%1_%2", (_unit select 2), (_unit select 1)]) setMarkerAlphaLocal _alpha;
	(format["%1_%2", (_unit select 2), (_unit select 1)]) setMarkerColorLocal (missionNameSpace getVariable "unitColor");
};

////////////////////////////////////////////////
//               FUNCTION LOOP                //
////////////////////////////////////////////////

_request = _this select 0;

switch (_request) do {
	// update all units
	case 0: {
		missionNameSpace setVariable ["unitsTracked", [], false];
		missionNameSpace setVariable ["unitsTrackedLastPositions", [], false];
		missionNameSpace setVariable ["unitsTrackedAlpha", 1, false];
		
		sleep 5;
		
		[] spawn fn_unitTrackerAlpha;
		[] spawn fn_unitTracker;
		[] spawn fn_unitUpdater;
	};
	
	// add effects
	case 1: {
		_effects = _this select 1;
		missionNameSpace setVariable ["unitTrackerEffects", _effects, true];
	};
};

////////////////////////////////////////////////
/*          INTERESTING INFORMATION           //
////////////////////////////////////////////////

// START THE UNITTRACKER FOR A PLAYER:
[0] spawn ZO_fnc_unitTracker;

// EDIT EFFECTS:
[1, [a, b, c, d, e, f, g, h]] spawn ZO_fnc_unitTracker;
a: _updateInterval (lower than 0.05 has no effect)
b: _updateIntervalDeviation
c: _alphaMinimum
d: _alphaMaximum
e: _flickerOnDuration
f: _flickerOnDurationDeviation
g: _flickerOffDuration
h: _flickerOffDurationDeviation

// DEFAULT EFFECTS:
[1, [0, 0, 1, 1, 0, 0, 0, 0]] spawn ZO_fnc_unitTracker;

// EXAMPLE EFFECTS:
[1, [2, 1.5, 0.1, 1, 4, 0.5, 0.75, 0.25]] spawn ZO_fnc_unitTracker;
