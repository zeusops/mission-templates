/*
	@file_name: fn_respawnHandleLocal.sqf
	@file_author: Dyzalonius
*/

////////////////////////////////////////////////
//               SUB-FUNCTIONS                //
////////////////////////////////////////////////

fn_text = {
	switch (_this) do {
		// waiting for bodybag or respawn /minute
		case 0: {
			if (playerRespawnTime % 60 == 0) then {
				if (missionNameSpace getVariable "respawnAllow") then {
					cutText [format["You are dead.\nRespawning with the next wave in %1 minutes, if body bagged.\nAuto respawn in %2 minutes.", ceil((missionNameSpace getVariable "respawnWaveTime")/60), ceil(playerRespawnTime/60)], "PLAIN"];
				} else {
					cutText ["You are dead.\nRespawning with the next wave, if body bagged.\nAuto respawn disabled.", "PLAIN"];
				};
			};
		};
		
		// waiting for wave or respawn
		case 1: {
			if (missionNameSpace getVariable "respawnAllow") then {
				cutText [format["You are body bagged.\nRespawning with the next wave in %1 minutes.\nAuto respawn in %2 minutes.", ceil((missionNameSpace getVariable "respawnWaveTime")/60), ceil(playerRespawnTime/60)], "PLAIN"];
			} else {
				cutText ["You are body bagged.\nRespawning with the next wave.\nAuto respawn disabled.", "PLAIN"];
			};
		};
		
		// waiting for wave or respawn /minute
		case 2: {
			if (playerRespawnTime % 60 == 0) then {
				if (missionNameSpace getVariable "respawnAllow") then {
					cutText [format["You are body bagged.\nRespawning with the next wave in %1 minutes.\nAuto respawn in %2 minutes.", ceil((missionNameSpace getVariable "respawnWaveTime")/60), ceil(playerRespawnTime/60)], "PLAIN"];
				} else {
					cutText ["You are body bagged.\nRespawning with the next wave.\nAuto respawn disabled.", "PLAIN"];
				};
			};
		};
		
		// respawn
		case 3: {
			cutText ["A respawn wave has been triggered\nYou will respawn in 5 seconds.", "PLAIN"];
		};
	};
};

////////////////////////////////////////////////
//               FUNCTION LOOP                //
////////////////////////////////////////////////

scopeName "main";

// waiting for death
waitUntil {!alive player;};

// waiting for bodybag or respawn
while {true} do {
	if (((player distance2D [-5000,-5000]) < 1000) || (alive player) || (vehicle player != player) || (missionNameSpace getVariable "forceBodyBag")) then {
		breakTo "main";
	};
	
	0 spawn fn_text;
	sleep 1;
};

// body bagged
if (!alive player) then {
	1 spawn fn_text;
};

// waiting for wave or respawn
while {true} do {
	if (((!isNil "respawnWave") && (missionNameSpace getVariable "respawnWave")) || (alive player)) then {
		breakTo "main";
	};
	
	2 spawn fn_text;
	sleep 1;
};

// respawn
if (!alive player) then {
	3 spawn fn_text;
	sleep 5;
	
	// force respawn
	setPlayerRespawnTime 0.01;
	
	sleep 1;
	
	// reset respawn timer
	if (missionNameSpace getVariable "respawnAllow") then {
		setPlayerRespawnTime 900;
	} else {
		setPlayerRespawnTime 100020;
	};
};

// restart
[] spawn ZO_fnc_respawnHandleLocal;