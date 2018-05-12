/*
	@file_name: fn_respawnHandle.sqf
	@file_author: Dyzalonius
*/

while {true} do {
	// Generate respawn wave time
	_time = 420 + (round random 60);
	
	// Wait for time, disable, or force
	while {_time > 0 && (missionNameSpace getVariable "respawnAllow") && !(missionNameSpace getVariable "respawnWaveForce")} do {
		_time = _time - 1;
		missionNameSpace setvariable ["respawnWaveTime", _time, true];
		sleep 1;
	};
	
	// Wait for enable, or force
	while {!(missionNameSpace getVariable "respawnAllow") || _time <= 0 || (missionNameSpace getVariable "respawnWaveForce")} do {
		// Trigger wave if its allowed, or if its forced
		if ((missionNameSpace getVariable "respawnAllow") || (missionNameSpace getVariable "respawnWaveForce")) then {
			// Reset force-option
			missionNameSpace setVariable ["respawnWaveForce", false, true];
			
			//get array of all zeuses
			private _zeuses = [];
			{
				if (side _x == sideLogic) then {
					_zeuses pushback _x;
				};
			} foreach allPlayers;
			
			// Notify all zeuses
			[0, ["A respawn wave was triggered.", "PLAIN"]] remoteExec ["cutText", _zeuses];
			
			// Trigger respawn wave
			missionNameSpace setvariable ["respawnWave", true, true];
			sleep 1;
			missionNameSpace setvariable ["respawnWave", false, true];
		};
	};
};