/*
	@file_name: fn_respawnHandleLocal.sqf
	@file_author: Dyzalonius
*/

////////////////////////////////////////////////
//               SUB-FUNCTIONS                //
////////////////////////////////////////////////

fn_notification = {
	switch (_this) do {
		// waiting for bodybag or respawn /minute
		case "bodybagwait": {
			if (playerRespawnTime % 60 == 0) then {
				if (missionNameSpace getVariable "respawnAllow") then {
					(format["<t font='PuristaBold' size='1.6'>You are dead.</t><br />Respawning with the next wave in %1 minutes, if body bagged.<br />Auto respawn in %2 minutes.", ceil((missionNameSpace getVariable "respawnNextWaveTime")/60), ceil(playerRespawnTime/60)]) spawn fn_text;
				} else {
					("<t font='PuristaBold' size='1.6'>You are dead.</t><br />Respawning with the next wave, if body bagged.<br />Auto respawn disabled.") spawn fn_text;
				};
			};
		};

		// waiting for wave or respawn
		case "bodybagged": {
			if (missionNameSpace getVariable "respawnAllow") then {
				(format["<t font='PuristaBold' size='1.6'>You are body bagged.</t><br />Respawning with the next wave in %1 minutes.<br />Auto respawn in %2 minutes.", ceil((missionNameSpace getVariable "respawnNextWaveTime")/60), ceil(playerRespawnTime/60)]) spawn fn_text;
			} else {
				("<t font='PuristaBold' size='1.6'>You are body bagged.</t><br />Respawning with the next wave.<br />Auto respawn disabled.") spawn fn_text;
			};
		};

		// waiting for wave or respawn /minute
		case "wavewait": {
			if (playerRespawnTime % 60 == 0) then {
				if (missionNameSpace getVariable "respawnAllow") then {
					(format["<t font='PuristaBold' size='1.6'>You are body bagged.</t><br />Respawning with the next wave in %1 minutes.<br />Auto respawn in %2 minutes.", ceil((missionNameSpace getVariable "respawnNextWaveTime")/60), ceil(playerRespawnTime/60)]) spawn fn_text;
				} else {
					("<t font='PuristaBold' size='1.6'>You are body bagged.</t><br />Respawning with the next wave.<br />Auto respawn disabled.") spawn fn_text;
				};
			};
		};

		// respawn with wave
		case "waverespawn": {
			("A respawn wave has been triggered<br /><t font='PuristaBold' size='1.6'>You will respawn in 5 seconds.</t>") spawn fn_text;
		};
	};
};

fn_text = {
	[parseText _this, [1.1,-0.3,0.6,0.2], nil, 5, 0.5, 0] spawn BIS_fnc_textTiles;
};

////////////////////////////////////////////////
//               FUNCTION LOOP                //
////////////////////////////////////////////////

scopeName "main";

// waiting for death
waitUntil {!alive player;};

// waiting for bodybag or respawn
while {true} do {
	_autoBodybagTeams = missionNameSpace getVariable "autoBodybagTeams";
	if (((player distance2D [-5000,-5000]) < 7100) || (alive player) || ((groupId (group player)) in _autoBodybagTeams)) then {
		breakTo "main";
	};

	"bodybagwait" spawn fn_notification;
	sleep 1;
};

// if not respawn notify bodybagged
if (!alive player) then {
	"bodybagged" spawn fn_notification;
};

// waiting for wave or respawn
while {true} do {
	if (((!isNil "respawnWave") && (missionNameSpace getVariable "respawnWave")) || (alive player)) then {
		breakTo "main";
	};

	"wavewait" spawn fn_notification;
	sleep 1;
};

// respawn
if (!alive player) then {
	"waverespawn" spawn fn_notification;
	sleep 5;

	// respawn
	setPlayerRespawnTime 0.01;
	sleep 1;

	// Get all zeuses and notify
	private _zulus = [];
 	{
  		if ((groupId _x) in (missionNameSpace getVariable "respawnMessageGroups")) then {
   			_zulus = _zulus + (units _x);
  		};
 		} foreach allGroups;
 	[0, ["<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><t shadowColor='#444444'>A player respawned</t>", "PLAIN", 0.2, true, true]] remoteExec ["cutText", _zulus];

	// reset respawn timer
	if (missionNameSpace getVariable "respawnAllow") then {
		setPlayerRespawnTime (missionNameSpace getVariable "respawnTime");
	} else {
		setPlayerRespawnTime (missionNameSpace getVariable "respawnTimeInfinite");
	};
};

// restart
[] spawn ZO_fnc_respawnHandleLocal;
