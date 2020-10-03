/*
	@file_name: Fuel_Consumption.sqf
	@file_author: Kasteelharry & Gehock

	Description:
	Modifies the speed of which fuel is drained from the vehicle. Called from the vehicle init or debug console on server side.

	Parameters:
	0: OBJECT - the vehicle the code is called on; this if called from vehicle init or variable name if called from debug console
	1: NUMBER - the speed of the fuel leak in seconds, a number from 1 to 0; 1 is the entire fuel tank, 0 is nothing. (for 30 minutes use 0.00055 and 45 minutes use 0.00037)

	Example:
	When calling from  the vehicle init, mid mission or in the editor:
	nul=[_this, rateOfLeak] remoteExec ["ZO_fnc_fuelConsumption",2];

	When calling from the debug console:
	nul=[nameOfVehicle, rateOfLeak] spawn ZO_fnc_fuelConsumption;

	Returns:
	Nothing.
*/


fn_fuelDecr = {
	_unit = _this select 0;
	_unit setVariable ["running", true, true];
	_rate = _this select 1;
	if isServer exitWith{};
	while {alive _unit} do {
		waitUntil {(isEngineOn _unit)};
		_fuel = fuel _unit;
		_newFuel = (_fuel - _rate);
		if (not local _unit) exitWith {_unit setVariable ["running", false, true];};
		_unit setFuel _newFuel;
		sleep 1;
	};
};


if !isServer exitwith{};

_unit = _this select 0;
_rate = _this select 1;

fn_startLoop = {
	
	_unit = _this select 0;
	_rate = _this select 1;
	_unit setVariable ["running", false, true];
	_owner = owner _unit;
	while {alive _unit} do {
		waitUntil {not local _unit};
		_owner = owner _unit;
		if (_owner != 2) then {
			_unit setVariable ["running", true, true];
			[_unit, _rate] remoteExec ["fn_fuelDecr", _owner];
		};
		waitUntil { isNull _unit or !(alive _unit) or !(_unit getVariable ["running", false])};
	};

};
[_unit, _rate] spawn fn_startLoop;
