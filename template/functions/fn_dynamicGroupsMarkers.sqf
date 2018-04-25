/*
	@file_name: fn_dynamicGroupsMarkers.sqf
	@file_edit: 04/01/17
*/

////////////////////////////////////////////////
//     ONLY CHANGE THINGS BELOW THIS LINE     //
////////////////////////////////////////////////

// all Arma 3 colors: https://community.bistudio.com/wiki/CfgMarkerColors_Arma_3
_bluforGroups = "colorBLUFOR";
_opforGroups = "colorOPFOR";
_independantGroups = "colorIndependent";
_civilianGroups = "colorCivilian";

////////////////////////////////////////////////
//    DO NOT CHANGE THINGS BELOW THIS LINE    //
////////////////////////////////////////////////

private ["_unitsToBeTracked", "_groupColors"];
_unitsToBeTracked = [];
missionNameSpace setVariable ["_unitsToBeTracked", _unitsToBeTracked, false];
_groupColors = [_bluforGroups, _opforGroups, _independantGroups, _civilianGroups];

sleep 5;

[] spawn {
	private _unitsToBeTracked = [];
	private _oldUnitsToBeTracked = [];
	while {true} do {
		_unitsToBeTracked = [];
		{
			if ( (side group player == side _x || side group player == sidelogic) && (["IsGroupRegistered", [_x]] call { _this call (missionNamespace getVariable ["BIS_fnc_dynamicGroups", {}]); }) && (isPlayer leader _x) && (count units _x > 0) ) then {
				if !([(leader _x),(groupId _x),(side _x)] in _unitsToBeTracked) then {
					_unitsToBeTracked pushback [(leader _x),(groupId _x),(side _x)];
				};
			};
		} foreach allGroups;
		missionNameSpace setVariable ["_unitsToBeTracked", _unitsToBeTracked, false];
		sleep 0.1;
		{
			deleteMarkerLocal (format["%1_",(_x select 2)]+(_x select 1));
		} foreach (_oldUnitsToBeTracked - _unitsToBeTracked);
		_oldUnitsToBeTracked = []+_unitsToBeTracked;
	};
};

while {true} do {
	_unitsToBeTracked = missionNameSpace getVariable "_unitsToBeTracked";
	if (count _unitsToBeTracked > 0) then {
		{
			[_x, _groupColors] spawn {
				private _unitToBeTracked = _this select 0;
				private _groupColors = _this select 1;
				if (getMarkerColor (format ["%1_"+(_unitToBeTracked select 1),(_unitToBeTracked select 2)]) == "") then {
					{
						private ["_markername","_marker","_markerType"];
						_markername = (format["%1_",(_unitToBeTracked select 2)]+(_unitToBeTracked select 1));
						_marker = createMarkerLocal [_markername,(getPosVisual (_unitToBeTracked select 0))];
						_markerType = [_unitToBeTracked] call {
							private ["_unitToBeTracked","_prefix","_type","_markerType"];
							_unitToBeTracked = _this select 0;
							_prefix = "b_";
							_type = "unknown";
							if ((_unitToBeTracked select 1) in ["A","A1","A2","B","B1","B2","C","C1","C2"]) then {_type = "inf";};
							if ((_unitToBeTracked select 1) in ["HQ1PLT","ASL","BSL","CSL"]) then {_type = "hq";};
							if ((_unitToBeTracked select 1) in ["Y1","Y2","Y3","Y4"]) then {_type = "armor";};
							if ((_unitToBeTracked select 1) in ["Z1","Z2","Z3","Z4"]) then {_type = "air";};
							if ((_unitToBeTracked select 1) in ["W1","W2","W3","W4"]) then {_type = "plane";};
							_markerType = _prefix + _type;
							_markerType;
						};
						_marker setMarkerTypeLocal _markerType;
						_marker setMarkerTextLocal (_unitToBeTracked select 1);
						_marker setMarkerColorLocal (_groupColors select ([BLUFOR,OPFOR,RESISTANCE,CIVILIAN] find (_unitToBeTracked select 2)));
						if (_unitToBeTracked select 2 == CIVILIAN) then {_marker setMarkerColorLocal "colorCivilian"};
					} foreach _unitToBeTracked;
				} else {
					(format["%1_",(_unitToBeTracked select 2)]+(_unitToBeTracked select 1)) setMarkerPosLocal (getPosVisual (_unitToBeTracked select 0));
				};
			};
		} foreach _unitsToBeTracked;
	};
	sleep 0.01;
};