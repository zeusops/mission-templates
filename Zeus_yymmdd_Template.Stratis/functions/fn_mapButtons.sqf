/*
	@file_name: fn_mapButtons.sqf
	@file_author: Dyzalonius
*/

// spawn default buttons
[] call {
	private _worldSize = getnumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");
	private _pos = [-500, -1500];
	if (_worldSize > 0 && _worldSize < 5000) then {
		_pos = [-500, -600];
	};

	private _mk = createMarkerLocal ["mapButton00", [0,0]];
	_mk setMarkerAlphaLocal 0;
	_mk setMarkerTypeLocal "mil_dot_noShadow";
	_mk setMarkerSizeLocal [2.35,2.35];

	private _mk = createMarkerLocal ["mapButton01", _pos];
	_mk setMarkerTypeLocal "mil_circle";
	_mk setMarkerSizeLocal [0.8,0.8];
	_mk setMarkerTextLocal " Toggle Grass";

	missionNameSpace setVariable ["mapButton01", 0, false]; //local
	missionNameSpace setVariable ["mapButtons",["mapButton01"], false]; //local
};

//spawn zeus checker
[] spawn {
	// Give extra map buttons when zeus
	waitUntil {playerSide == sideLogic};

	// Find position to put toggle respawn button
	private _mapButtons = missionNameSpace getvariable "mapButtons";
	private _worldSize = getnumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");
	private _spacer = -1000;
	if (_worldSize > 0 && _worldSize < 5000) then {
		_spacer = -100;
	};

	// Spawn toggle respawn button
	private _mk = createMarkerLocal ["mapButton02", [-500, -500 + _spacer*2]];
	_mk setMarkerTypeLocal "mil_circle";
	_mk setMarkerSizeLocal [0.8,0.8];
	if (missionNameSpace getVariable "respawnAllow") then {
		_mk setMarkerTextLocal " Toggle Respawns [ENABLED]";
	} else {
		_mk setMarkerTextLocal " Toggle Respawns [DISABLED]";
	};
	_mapButtons pushback _mk;

	missionNameSpace setvariable ["mapButtons", _mapButtons, false];

	// Spawn respawn position marker
	private _mk = createMarkerLocal ["respawnPosition", (missionNameSpace getVariable "RESPAWN_POSITION")];
	_mk setMarkerTypeLocal "mil_dot";
	_mk setMarkerSizeLocal [0.5,0.5];
	_mk setMarkerTextLocal "RESPAWN POSITION";

	// Spawn respawn position marker updater
	onEachFrame {
		_respawnPos = missionNameSpace getVariable "RESPAWN_POSITION";
		_distance = player distance _respawnPos;
		_alpha = linearConversion [500, 1500, _distance, 1, 0.1, true];
		drawIcon3D [
			"",
			[0,0,0,_alpha],
			[_respawnPos select 0, _respawnPos select 1, 5],
			0,
			0,
			direction player,
			"RESPAWN POSITION",
			0,
			0.04,
			"PuristaSemiBold",
			"center"
		];
		"respawnPosition" setMarkerPosLocal _respawnPos;
	};
};

//spawn eventhandler
[
	"leftClick_EH",
	"onMapSingleClick",
	{
		private _scale = ctrlMapScale (findDisplay 12 displayCtrl 51);
		private _posMkBool = false;
		private _posMk = nil;

		//set posMkBool to true if clicking (roughly) on a mapButton, and posMk to that marker
		{
			if ((_pos select 0) > (getMarkerPos _x select 0) - _scale*300 && (_pos select 0) < (getMarkerPos _x select 0) + _scale*300 && (_pos select 1) > (getMarkerPos _x select 1) - _scale*300 && (_pos select 1) < (getMarkerPos _x select 1) + _scale*300) exitWith {
				_posMkBool = true;
				_posMk = _x;
			};
		} foreach (missionNameSpace getVariable "mapButtons");

		//if clicked on a button, do whatever should happen
		if (_posMkBool) then {
			//show animation with 00 button
			[_posMk] spawn {
				private _posMk = _this select 0;
				"mapButton00" setMarkerPosLocal (getMarkerPos _posMk);
				"mapButton00" setMarkerAlphaLocal 0.8;
				playSound "sound1";
				while {markerAlpha "mapButton00" > 0} do {
					"mapButton00" setMarkerAlphaLocal (markerAlpha "mapButton00" - 0.05);
					sleep 0.01;
				};
			};

			//run the button specific code
			switch (_posMk) do {
				// TOGGLE GRASS
				case "mapButton01": {
					private _mapButton01 = missionNameSpace getVariable "mapButton01";
					_mapButton01 = [1,0] select _mapButton01;
					missionNameSpace setVariable ["mapButton01", _mapButton01, false];

					if (_mapButton01 == 1) then {
						setTerrainGrid 50;
					} else {
						setTerrainGrid 25;
					};
				};

				// TOGGLE RESPAWN
				case "mapButton02": {
					if (missionNameSpace getVariable "respawnAllow") then {
						missionNameSpace setVariable ["respawnAllow", false, true];
						[999999] remoteExec ["setPlayerRespawnTime", allPlayers];
						"mapButton02" setMarkerTextLocal " Toggle Respawns [DISABLED]";
					} else {
						missionNameSpace setVariable ["respawnAllow", true, true];
						[900] remoteExec ["setPlayerRespawnTime", allPlayers];
						"mapButton02" setMarkerTextLocal " Toggle Respawns [ENABLED]";
					};
				};
			};
		};
	},
	[]
] call BIS_fnc_addStackedEventHandler;
