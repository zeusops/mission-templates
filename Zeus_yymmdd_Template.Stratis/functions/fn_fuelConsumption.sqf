/*
	@file_name: fn_fuelConsumption.sqf
	@file_author: Kasteelharry & Gehock

	Description:
	Modifies the speed of which fuel is drained from the vehicle. Called from the vehicle init or debug console on server side.

	Parameters:
	0: OBJECT - the vehicle the code is called on; this if called from vehicle init or variable name if called from debug console
	1: NUMBER - the speed of the fuel leak in seconds, a number from 1 to 0; 1 is the entire fuel tank, 0 is nothing. (for 30 minutes use 0.00055 and 45 minutes use 0.00037)

	Example:
	When calling from  the vehicle init, mid mission or in the editor:
	[_this, rateOfLeak] remoteExec ["ZO_fnc_fuelConsumption", 2];

	When calling from the debug console:
	[nameOfVehicle, rateOfLeak] spawn ZO_fnc_fuelConsumption;

	Returns:
	Nothing.
*/


fn_fuelDecrease = {
	if (isServer) exitWith {};

	_vehicle = _this select 0;
	_rate = _this select 1;
	_vehicle setVariable ["zo_fuel_scriptRunning", true, true];

	while {alive _vehicle} do {
		waitUntil {isEngineOn _vehicle};
		_fuel = fuel _vehicle;
		_newFuel = (_fuel - _rate);
		// Vehicle locality changed because another player got in the driver's seat
		// -> transferring execution to them
		if (!local _vehicle) exitWith {
			_vehicle setVariable ["zo_fuel_scriptRunning", false, true];
		};
		_vehicle setFuel _newFuel;
		sleep 1;
	};
};


if !isServer exitwith{};

fn_startLoop = {
	_vehicle = _this select 0;
	_rate = _this select 1;
	_vehicle setVariable ["zo_fuel_scriptRunning", false, true];
	while {alive _vehicle} do {
		// Pause until the vehicle gets transferred away from the server
		waitUntil {!local _vehicle};
		// owner = last driver of the vehicle
		_owner = owner _vehicle;
		if (_owner != 2) then {
			_vehicle setVariable ["zo_fuel_scriptRunning", true, true];
			[_vehicle, _rate] remoteExec ["fn_fuelDecrease", _owner];
		};
		waitUntil {isNull _vehicle or !(alive _vehicle ) or !(_vehicle getVariable ["zo_fuel_scriptRunning", false])};
	};
};
_unit = _this select 0;
_rate = _this select 1;
[_unit, _rate] spawn fn_startLoop;
