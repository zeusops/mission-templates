/*
	@file_name: fn_showFPS.sqf
	@file_edit: 24/12/2016
*/

private [ "_sourcestr", "_position", "_myfpsmarker", "_myfps", "_localunits", "_localvehicles" ];

if ( isServer ) then {
	_sourcestr = "SERVER";
	_position = 0;
} else {
	if (!isNil "HC1") then {
		if (!isNull HC1) then {
			if (local HC1) then {
				_sourcestr = "HC1";
				_position = 1;
			};
		};
	};

	if (!isNil "HC2") then {
		if (!isNull HC2) then {
			if (local HC2) then {
				_sourcestr = "HC2";
				_position = 2;
			};
		};
	};

	if (!isNil "HC3") then {
		if (!isNull HC3) then {
			if (local HC3) then {
				_sourcestr = "HC3";
				_position = 3;
			};
		};
	};
};

_myfpsmarker = createMarker [ format ["fpsmarker%1", _sourcestr ], [ 500, -500 - (500 * _position) ] ];
_myfpsmarker setMarkerType "mil_dot";
_myfpsmarker setMarkerSize [0,0];

while { true } do {

	_myfps = diag_fps;
	_localunits = { local _x } count allUnits;
	if (_localunits > 0) then {
		_localunits = _localunits / count allUnits * 100;
	} else {
		_localunits = 0;
	};
	
	_localvehicles = { local _x } count vehicles;
	if (_localvehicles > 0) then {
		_localvehicles = _localvehicles / count vehicles * 100;
	} else {
		_localvehicles = 0;
	};

	_myfpsmarker setMarkerText format [ "%1: %2 fps, %3%5 of units, %4%5 of vehicles", _sourcestr, ( round ( _myfps * 100.0 ) ) / 100.0 , _localunits, _localvehicles, "%" ];
	
	sleep 10;
};
