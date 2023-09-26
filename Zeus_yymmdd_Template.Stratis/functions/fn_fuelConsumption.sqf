/*
    @file_name: fn_fuelConsumption.sqf
    @file_author: Kasteelharry & Gehock

    Description:
    Modifies the speed of which fuel is drained from the vehicle. Called from the vehicle init or debug console on server side.

    Parameters:
    0: OBJECT - the vehicle the code is called on; _this if called from vehicle init or variable name if called from debug console
    1: NUMBER - the speed of the fuel leak in seconds, a number from 1 to 0; 1 is the entire fuel tank, 0 is nothing. (for 30 minutes use 0.00055 and 45 minutes use 0.00037)

    Example:
    When calling from the 3den Editor Object Init or
    When using the init mid operation make sure the execution mode is set to Global:
    [_this, rateOfLeak] spawn ZO_fnc_fuelConsumption;

    When calling from the debug console:
    [nameOfVehicle, rateOfLeak] spawn ZO_fnc_fuelConsumption;

    Returns:
    Nothing.
*/

////////////////////////////////////////////////
//               SUB-FUNCTIONS                //
////////////////////////////////////////////////

fn_fuelDecrease = {
    // This function should only be executed on the machine where the vehicle is local and a player.
    if (isServer) exitWith {};

    _vehicle = _this select 0;
    _rate = _this select 1;
    _vehicle setVariable ["zo_fuel_scriptRunning", true, true];

    // Loop on client side while the vehicle is local to that machine
    while {alive _vehicle} do {
        waitUntil {isEngineOn _vehicle};
        _fuel = fuel _vehicle;
        _newFuel = (_fuel - _rate);
        // Vehicle locality changed because another player got in the driver's seat
        // -> break loop and let server transfer execution to that machine
        if (!local _vehicle) exitWith {
            _vehicle setVariable ["zo_fuel_scriptRunning", false, true];
        };
        _vehicle setFuel _newFuel;
        sleep 1;
    };
};

////////////////////////////////////////////////
//               FUNCTION LOOP                //
////////////////////////////////////////////////
// If function is not run on the server stop execution
if (!isServer) exitwith{};

_vehicle = _this select 0;
_rate = _this select 1;

// While loop to make sure that decrease function is run on correct client
while {alive _vehicle} do {
    // Pause until the vehicle gets transferred away from the server
    waitUntil {!local _vehicle};
    // owner = last driver of the vehicle or person that spawned it in
    _owner = owner _vehicle;

    _vehicle setVariable ["zo_fuel_scriptRunning", true, true];
    // Start the main fuel decrease loop on the machine where the vehicle is local
    [_vehicle, _rate] remoteExec ["fn_fuelDecrease", _owner];
    // Loop when locality of vehicle is transferred between players
    waitUntil {isNull _vehicle or !(alive _vehicle ) or !(_vehicle getVariable ["zo_fuel_scriptRunning", false])};
};
