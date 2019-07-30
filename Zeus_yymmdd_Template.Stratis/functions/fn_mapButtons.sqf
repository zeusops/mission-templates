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

	private _mk = createMarkerLocal ["mapButton01", _pos];
	_mk setMarkerTypeLocal "mil_circle";
	_mk setMarkerSizeLocal [0.8,0.8];
	_mk setMarkerTextLocal " Toggle Grass";

	private _mk = createMarkerLocal ["mapButton00", [0,0]];
	_mk setMarkerAlphaLocal 0;
	_mk setMarkerTypeLocal "mil_dot_noShadow";
	_mk setMarkerSizeLocal [2.35,2.35];

	missionNameSpace setVariable ["mapButton01", 0, false]; //local
	missionNameSpace setVariable ["mapButtons",["mapButton01"], false]; //local
};

//spawn zeus checker
[] spawn {
	//when a zeus, give the marker, else remove it.
	waitUntil {playerSide == sideLogic};

	private _mapButtons = missionNameSpace getvariable "mapButtons";
	private _worldSize = getnumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");
	private _spacer = -1000;
	if (_worldSize > 0 && _worldSize < 5000) then {
		_spacer = -100;
	};

	private _mk = createMarkerLocal ["mapButton02", [-500, -500 + _spacer*2]];
	_mk setMarkerTypeLocal "mil_circle";
	_mk setMarkerSizeLocal [0.8,0.8];
	if (missionNameSpace getVariable "respawnAllow") then {
		_mk setMarkerTextLocal " Toggle Respawns [ENABLED]";
	} else {
		_mk setMarkerTextLocal " Toggle Respawns [DISABLED]";
	};
	_mapButtons pushback _mk;

	private _mk = createMarkerLocal ["mapButton03", [-500, -500 + _spacer*3]];
	_mk setMarkerTypeLocal "mil_circle";
	_mk setMarkerSizeLocal [0.8,0.8];
	_mk setMarkerTextLocal " Force Respawn Wave";
	_mapButtons pushback _mk;

	private _mk = createMarkerLocal ["mapButton04", [-500, -500 + _spacer*4]];
	_mk setMarkerTypeLocal "mil_circle";
	_mk setMarkerSizeLocal [0.8,0.8];
	_mk setMarkerTextLocal " Force Bodybag";
	_mapButtons pushback _mk;

	private _mk = createMarkerLocal ["mapButton05", (getMarkerPos "respawn")];
	_mk setMarkerTypeLocal "mil_circle";
	_mk setMarkerSizeLocal [0.8,0.8];
	_mk setMarkerTextLocal " RESPAWN LOCATION";
	_mapButtons pushback _mk;

	missionNameSpace setvariable ["mapButtons", _mapButtons, false];
};

//spawn eventhandler
[
	"leftClick_EH",
	"onMapSingleClick",
	{
		private _scale = ctrlMapScale (findDisplay 12 displayCtrl 51);
		private _posMkBool = false;
		private _posMk = nil;
		private _mapButton05 = missionNameSpace getVariable "mapButton05";
		private _mapButton05_user = missionNameSpace getVariable "mapButton05_user";

		//set posMkBool to true if clicking (roughly) on a mapButton, and posMk to that marker
		{
			if ((_pos select 0) > (getMarkerPos _x select 0) - _scale*300 && (_pos select 0) < (getMarkerPos _x select 0) + _scale*300 && (_pos select 1) > (getMarkerPos _x select 1) - _scale*300 && (_pos select 1) < (getMarkerPos _x select 1) + _scale*300) exitWith {
				_posMkBool = true;
				_posMk = _x;
			};
		} foreach (missionNameSpace getVariable "mapButtons");

		//move mapButton05 to cursor if you are currently moving that marker
		if (_mapButton05 == 1 && player == _mapButton05_user) then {
			_mapButton05 = 0;
			missionNameSpace setVariable ["mapButton05", _mapButton05, true];

			_mapButton05_user = objNull;
			missionNameSpace setVariable ["mapButton05_user", _mapButton05_user, true];

			//get array of all zeuses
			private _zeuses = [];
			{
				if (side _x == sideLogic) then {
					_zeuses pushback _x;
				};
			} foreach allPlayers;

			//give hint to all zeuses
			[0, ["RESPAWN POSITION has been moved.", "PLAIN"]] remoteExec ["cutText", _zeuses];

			//put marker down at cursor position.
			["mapButton05", _pos] remoteExec ["setMarkerPosLocal", _zeuses];

			missionNameSpace setVariable ["RESPAWN_POSITION", _pos, true];
		} else {

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

					// FORCE WAVE
					case "mapButton03": {
						//force respawn all bagged dead people
						missionNameSpace setvariable ["respawnWaveForce", true, true];
					};

					// FORCE BODYBAG
					case "mapButton04": {
						//get array of all zeuses
						private _zeuses = [];
						{
							if (side _x == sideLogic) then {
								_zeuses pushback _x;
							};
						} foreach allPlayers;

						//give hint to all zeuses
						[0, ["Force body bagged everyone.", "PLAIN"]] remoteExec ["cutText", _zeuses];

						//force body bag all dead people
						missionNameSpace setvariable ["forceBodyBag", true, true];

						[] spawn {
							sleep 2;
							missionNameSpace setvariable ["forceBodyBag", false, true];
						};
					};

					// RESPAWN LOCATION
					case "mapButton05": {
							if (_mapButton05 == 0 && isNull _mapButton05_user) then {
							_mapButton05 = 1;
							missionNameSpace setVariable ["mapButton05", _mapButton05, true];

							_mapButton05_user = player;
							missionNameSpace setVariable ["mapButton05_user", _mapButton05_user, true];

							//get array of all zeuses
							private _zeuses = [];
							{
								if (side _x == sideLogic) then {
									_zeuses pushback _x;
								};
							} foreach allPlayers;

							//give hint to all zeuses
							[0, ["RESPAWN POSITION is being moved.", "PLAIN"]] remoteExec ["cutText", _zeuses];
						};
					};
				};
			};
		};
	},
	[]
] call BIS_fnc_addStackedEventHandler;
