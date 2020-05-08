/*
	@file_name: fn_respawnHandle.sqf
	@file_author: Dyzalonius
*/

while {true} do {
	// Set respawnNextWaveTime to respawnWaveTime
	_time = (missionNameSpace getVariable "respawnWaveTime");
	missionNameSpace setvariable ["respawnNextWaveTime", _time, true];

	// Wait for timer to run out or respawn to be disabled
	while {_time > 0 && (missionNameSpace getVariable "respawnAllow")} do {
		_time = (missionNameSpace getVariable "respawnNextWaveTime") - 1;
		missionNameSpace setvariable ["respawnNextWaveTime", _time, true];
		sleep 1;
	};

	// Wait for enable
	waitUntil {(missionNameSpace getVariable "respawnAllow")};

	// Get all zeuses and notify
	private _zeuses = [];
	{
		if (side _x == sideLogic) then {
			_zeuses pushback _x;
		};
	} foreach allPlayers;
 	[0, ["<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><t shadowColor='#444444'>A respawn wave was triggered</t>", "PLAIN", 0.2, true, true]] remoteExec ["cutText", _zeuses];

	// Trigger respawn wave
	missionNameSpace setvariable ["respawnWave", true, true];
	sleep 3;
	missionNameSpace setvariable ["respawnWave", false, true];
};
