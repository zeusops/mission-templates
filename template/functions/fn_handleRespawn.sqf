/*
	@file_name: fn_handleRespawn.sqf
	@file_author: Dyzalonius
*/

scopeName "main";

waitUntil {!alive player;};

while {true} do {
	if (((player distance2D [-5000,-5000]) < 10) || (alive player) || (vehicle player != player) || (missionNameSpace getVariable "forceBodyBag")) then {
		breakTo "main";
	};
	if (playerRespawnTime % 60 == 0) then {
		cutText [format["You are dead.\nRespawning with the next wave, if body bagged.\nAuto respawn in %1 minutes.", ceil(playerRespawnTime/60)], "PLAIN"];
	};
	sleep 1;
};

if (!alive player) then {
	cutText [format["You are body bagged.\nRespawning with the next wave.\nAuto respawn in %1 minutes.", ceil(playerRespawnTime/60)], "PLAIN"];
};

while {true} do {
	if (((!isNil "respawnWaveForce") && (missionNameSpace getVariable "respawnWaveForce")) || (alive player)) then {
		breakTo "main";
	};
	if (playerRespawnTime % 60 == 0) then {
		cutText [format["You are body bagged.\nRespawning with the next wave.\nAuto respawn in %1 minutes.", ceil(playerRespawnTime/60)], "PLAIN"];
	};
	sleep 1;
};

if (!alive player) then {
	cutText ["A respawn wave has been triggered\nYou will respawn in 5 seconds.", "PLAIN"];
	sleep 5;
	
	setPlayerRespawnTime 0.01;
	sleep 1;
	
	setPlayerRespawnTime 900;
	missionNameSpace setvariable ["respawnWaveForce", false, true];
};

[] spawn ZO_fnc_handleRespawn;